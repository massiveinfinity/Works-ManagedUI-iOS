//
// Created by Yunarta Kartawahyudi on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import "ManagedUITextField.h"
#import "ManagedObjectProvider.h"


@interface ManagedUITextField () <UITextFieldDelegate>
@end

@implementation ManagedUITextField {

}

- (void)awakeFromNib {
    NSLog(@"awakeFromNib");
    [super awakeFromNib];
    [self setDelegate:self];

    if ([self kName] && [self kProperty] && [self provider]) {
        [[self provider] registerManaged:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing");
    if ([self kName] && [self kProperty] && [self provider]) {
        [[self provider] setValueFor:[self kName] property:[self kProperty] value:[textField text]];
    }
}

- (BOOL)resignFirstResponder {
    NSLog(@"resignFirstResponder");
    return [super resignFirstResponder];
}

- (void)reloadManaged {
    if ([self kName] && [self kProperty] && [self provider]) {
        NSString *text = [[self provider] valueFor:[self kName] property:[self kProperty]];
        if (text) {
            [self setText:text];
        }
    }
}

@end