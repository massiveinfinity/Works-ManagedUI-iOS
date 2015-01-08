//
// Created by Yunarta Kartawahyudi on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedUIProtocol.h"


@interface ManagedObjectProvider : NSObject

- (NSString *)valueFor:(NSString *)name property:(NSString *)property;

- (void)setValueFor:(NSString *)name property:(NSString *)property value:(id)value;

- (void)registerManaged:(id <ManagedUI>)control;

- (void)setManaged:(id)managed forName:(NSString *)name;

- (void)reload;

- (void)endEditing;
@end