//
// Created by Yunarta Kartawahyudi on 30/3/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ManagedObjectProvider.h"

@interface UITextField (Managed) <ManagedUI>

@property(strong, nonatomic) IBInspectable NSString *managedName;
@property(strong, nonatomic) IBInspectable NSString *managedProperty;
@property(nonatomic, weak) IBOutlet ManagedObjectProvider *provider;

@end