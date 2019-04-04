//
//  NSObject+HHKVC.m
//  HHExercise
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "NSObject+HHKVC.h"

@implementation NSObject (HHKVC)
- (void)hh_setValue:(nullable id)value forKey:(NSString *)key;{
    if (key == nil || key.length == 0) {
        return;
    }
    NSString *Key = key.capitalizedString;
    NSString *selectorName = [NSString stringWithFormat:@"%@",Key];
    if ([self respondsToSelector:NSSelectorFromString(selectorName)]) {
        [self performSelector:NSSelectorFromString(Key) withObject:value];
    }
    NSString *_selectorName = [NSString stringWithFormat:@"_%@",Key];
    if ([self respondsToSelector:NSSelectorFromString(_selectorName)]) {
        [self performSelector:NSSelectorFromString(_selectorName) withObject:value];
    }
    NSString *isSelectorName = [NSString stringWithFormat:@"is%@",Key];
    if ([self respondsToSelector:NSSelectorFromString(isSelectorName)]) {
        [self performSelector:NSSelectorFromString(isSelectorName) withObject:value];
    }
    
    if ([[self class] accessInstanceVariablesDirectly]) {
        NSException *exception = [NSException exceptionWithName:@"发现了错误" reason:@"故意错误" userInfo:nil];
        @throw exception;
    }
    
}
@end
