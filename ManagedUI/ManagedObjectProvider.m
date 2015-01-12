//
// Created by Yunarta Kartawahyudi on 8/1/15.
// Copyright (c) 2015 Cerebos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagedObjectProvider.h"

@implementation ManagedObjectProvider {

    NSMutableArray *_controls;
    NSMutableDictionary *_managed;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _controls = [NSMutableArray array];
        _managed = [NSMutableDictionary dictionary];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (NSString *)valueFor:(NSString *)name property:(NSString *)property {
    id o = _managed[name];
    return [o valueForKey:property];
}

- (void)setValueFor:(NSString *)name property:(NSString *)property value:(id)value {
    id o = _managed[name];
    [o setValue:value forKey:property];
}

- (void)registerManaged:(id <ManagedUI>)control {
    [_controls addObject:control];
}

- (void)setManaged:(id)managed forName:(NSString *)name {
    _managed[name] = managed;
}

- (void)reload {
    for (id <ManagedUI> control in _controls) {
        [control reloadManaged];
    }
}

- (void)endEditing {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


@end