//
// Created by Kwee Tek Yin on 11/1/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import "ValidateUtil.h"
#import "ManagedObjectProvider.h"


@interface ValidateUtil ()
@property(nonatomic, strong) NSMutableArray *validations;
@property(nonatomic, strong) NSString *table;
@end

@implementation ValidateUtil {

}
- (instancetype)initWithFile:(NSString *)file withLocalization:(NSString *)table {
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:file ofType:@"plist"];
        [self setValidations:[NSMutableArray arrayWithContentsOfFile:plistPath]];
        [self setTable:table];
    }

    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (BOOL)validate:(ManagedObjectProvider *)provider error:(NSError **)error {

    for (id rule in [self validations]) {
        NSString *value = [provider valueFor:rule[@"name"] property:rule[@"property"]];
        NSLog(@"value %@", value);

        NSArray *validators = rule[@"validator"];
        for (id validator in validators) {
            NSString *type = [validator[@"type"] stringByAppendingString:@":"];

            NSString *text = validator[@"text"];
            SEL pSelector = NSSelectorFromString(type);
            BOOL valid = YES;
            if ([self respondsToSelector:pSelector]) {
                valid = (BOOL) [self performSelector:pSelector withObject:value];
            } else if ([self delegate] && [[self delegate] respondsToSelector:pSelector]) {
                valid = (BOOL) [[self delegate] performSelector:pSelector withObject:value];
            }

            if (!valid) {
                NSString *message = [[NSBundle mainBundle] localizedStringForKey:text value:text table:[self table]];
                *error = [NSError errorWithDomain:@"CerebosBrands" code:0 userInfo:@{
                        NSLocalizedDescriptionKey : message,
                        NSURLErrorKey : [NSString stringWithFormat:@"%@ %@", rule[@"name"], rule[@"property"]]
                }];

                return NO;
            }
        }
    }

    return YES;
}

#pragma clang diagnostic pop

- (BOOL)notEmpty:(NSString *)value {
    return value != nil && ![[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

- (BOOL)email:(NSString *)value {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:value];
}

@end