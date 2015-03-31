//
// Created by Kwee Tek Yin on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import "ManagedUITextField.h"
#import "ManagedObjectProvider.h"
#import "ManagedUITextFieldDelegate.h"


@interface ManagedUITextField () <UITextFieldDelegate>
@end

@implementation ManagedUITextField {
    ManagedUITextFieldDelegate* _delegate;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    if ([self managedName] && [self managedProperty] && [self provider]) {
        [[self provider] registerManaged:self];

        [self setDelegate:[[ManagedUITextFieldDelegate alloc] initWithCompletion:^void(UITextField *field) {
            if ([self managedName] && [self managedProperty] && [self provider]) {
                [[self provider] setValueFor:[self managedName] property:[self managedProperty] value:[self text]];
            }
        }]];
    }
}

- (void)reloadManaged {
    if ([self managedName] && [self managedProperty] && [self provider]) {
        NSString *text = [[self provider] valueFor:[self managedName] property:[self managedProperty]];
        if (text) {
            [self setText:text];
        } else {
            [self setText:@""];
        }
    }
}

@end