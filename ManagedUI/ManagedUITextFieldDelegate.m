//
// Created by Kwee Tek Yin on 13/1/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import "ManagedUITextFieldDelegate.h"


@implementation ManagedUITextFieldDelegate {
    ManagedUITextFieldDelegateBlock block;
}
- (id)initWithCompletion:(ManagedUITextFieldDelegateBlock)completion {
    block = completion;

    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    block(textField);
}

@end