//
// Created by Kwee Tek Yin on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedObjectProvider.h"

@interface ManagedObjectProvider () <UITextFieldDelegate>
@end

@implementation ManagedObjectProvider {

    NSMutableArray *_controls;
    NSMutableDictionary *_managed;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _controls = [NSMutableArray array];
        _managed = [NSMutableDictionary dictionary];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (NSString *)valueFor:(NSString *)name property:(NSString *)property {
    id o = _managed[name];
    return [o valueForKey:property];
}

- (void)setValueFor:(NSString *)name property:(NSString *)property value:(id)value {
    id o = _managed[name];
    [o setValue:value forKey:property];
}

- (void)registerManaged:(id <ManagedUI>)control {
    [_controls addObject:control];
}

- (void)setManaged:(id)managed forName:(NSString *)name {
    _managed[name] = managed;
}

- (void)reload {
    for (id <ManagedUI> control in _controls) {
        if ([control isKindOfClass:[UITextField class]]) {
            UITextField *textField = (id) control;
            [textField setDelegate:self];
//            [textField setDelegate:[[ManagedUITextFieldDelegate alloc] initWithCompletion:^void(UITextField *field) {
//                if ([control managedName] && [control managedProperty] && [control provider]) {
//                    [[control provider] setValueFor:[control managedName] property:[control managedProperty] value:[textField text]];
//                }
//            }]];
        }
        [control reloadManaged];
    }
}

- (void)endEditing {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id <ManagedUI> control = (id <ManagedUI>) textField;
    if ([control managedName] && [control managedProperty] && [control provider]) {
        [[control provider] setValueFor:[control managedName] property:[control managedProperty] value:[textField text]];
    }
}

@end