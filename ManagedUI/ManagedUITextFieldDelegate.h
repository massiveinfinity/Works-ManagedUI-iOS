//
// Created by Kwee Tek Yin on 13/1/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ManagedUITextFieldDelegateBlock)(UITextField *);

@interface ManagedUITextFieldDelegate : NSObject <UITextFieldDelegate>
- (id)initWithCompletion:(ManagedUITextFieldDelegateBlock)block;
@end