//
// Created by Kwee Tek Yin on 13/1/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import "ManagedUITextFieldDelegate.h"
#import "ManagedUITextField.h"


@implementation ManagedUITextFieldDelegate {
    ManagedUITextFieldDelegateBlock block;
}
- (id)initWithCompletion:(ManagedUITextFieldDelegateBlock)completion {
    block = completion;

    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    block(textField);
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    ManagedUITextField *managed = (ManagedUITextField *) textField;
//    if (managed.maxChars == 0) {
//        return YES;
//    }
//
//    NSUInteger oldLength = [textField.text length];
//    NSUInteger replacementLength = [string length];
//    NSUInteger rangeLength = range.length;
//
//    NSUInteger newLength = oldLength - rangeLength + replacementLength;
//
//    BOOL returnKey = [string rangeOfString:@"\n"].location != NSNotFound;
//
//    return newLength <= managed.maxChars || returnKey;
//    return YES;
//}

@end