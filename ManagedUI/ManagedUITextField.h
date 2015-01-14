//
// Created by Kwee Tek Yin on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ManagedObjectProvider.h"
#import "ManagedUIProtocol.h"

@interface ManagedUITextField : UITextField <ManagedUI>

@property(strong, nonatomic) IBOutlet ManagedObjectProvider *provider;

@property(strong, nonatomic) NSString *kName;
@property(strong, nonatomic) NSString *kProperty;

@end