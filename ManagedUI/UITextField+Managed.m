//
// Created by Yunarta Kartawahyudi on 30/3/15.
// Copyright (c) 2015 Massive Infinity. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+Managed.h"
#import "ManagedObjectProvider.h"
#import "ManagedUITextFieldDelegate.h"

static void *IdentifierProviderKey = &IdentifierProviderKey;
static void *IdentifierManagedNameKey = &IdentifierManagedNameKey;
static void *IdentifierManagedPropertyKey = &IdentifierManagedPropertyKey;

@implementation UITextField (Managed)

- (NSString *)managedName {
    return objc_getAssociatedObject(self, IdentifierManagedNameKey);
}

- (void)setManagedName:(NSString *)name {
    objc_setAssociatedObject(self, IdentifierManagedNameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)managedProperty {
    return objc_getAssociatedObject(self, IdentifierManagedPropertyKey);
}

- (void)setManagedProperty:(NSString *)prop {
    objc_setAssociatedObject(self, IdentifierManagedPropertyKey, prop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ManagedObjectProvider *)provider {
    return objc_getAssociatedObject(self, IdentifierProviderKey);
}

- (void)setProvider:(ManagedObjectProvider *)provider {
    objc_setAssociatedObject(self, IdentifierProviderKey, provider, OBJC_ASSOCIATION_ASSIGN);
    if ([self managedName] && [self managedProperty] && [self provider]) {
        [[self provider] registerManaged:self];

        [self setDelegate:[[ManagedUITextFieldDelegate alloc] initWithCompletion:^void(UITextField *field) {
            if ([self managedName] && [self managedProperty] && [self provider]) {
                [[self provider] setValueFor:[self managedName] property:[self managedProperty] value:[self text]];
            }
        }]];
    }

}

- (void)reloadManaged {
    if ([self managedName] && [self managedProperty] && [self provider]) {
        NSString *text = [[self provider] valueFor:[self managedName] property:[self managedProperty]];
        if (text) {
            [self setText:text];
        } else {
            [self setText:@""];
        }
    }
}

@end