//
// Created by Yunarta Kartawahyudi on 11/1/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ManagedObjectProvider;


@interface ValidateUtil : NSObject

@property(nonatomic, strong) id delegate;

- (instancetype)initWithFile:(NSString *)file withLocalization:(NSString*)table;

- (BOOL)validate:(ManagedObjectProvider *)provider error:(NSError **)error;

@end