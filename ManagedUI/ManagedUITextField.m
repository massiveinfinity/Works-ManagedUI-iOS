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

    if ([self kName] && [self kProperty] && [self provider]) {
        [[self provider] registerManaged:self];

        _delegate = [[ManagedUITextFieldDelegate alloc] initWithCompletion:^void(UITextField *field) {
            if ([self kName] && [self kProperty] && [self provider]) {
                [[self provider] setValueFor:[self kName] property:[self kProperty] value:[self text]];
            }
        }];
        [self setDelegate:_delegate];
    }
}

- (void)reloadManaged {
    if ([self kName] && [self kProperty] && [self provider]) {
        NSString *text = [[self provider] valueFor:[self kName] property:[self kProperty]];
        if (text) {
            [self setText:text];
        } else {
            [self setText:@""];
        }
    }
}

@end