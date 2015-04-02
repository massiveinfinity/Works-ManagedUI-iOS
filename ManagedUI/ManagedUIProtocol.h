//
// Created by Kwee Tek Yin on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ManagedObjectProvider;

@protocol ManagedUI <NSObject>

@property(strong, nonatomic) IBInspectable NSString *managedName;
@property(strong, nonatomic) IBInspectable NSString *managedProperty;
@property(nonatomic, weak) IBOutlet ManagedObjectProvider *provider;

-(void)reloadManaged;

@end