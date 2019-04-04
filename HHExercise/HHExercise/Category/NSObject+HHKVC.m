//
//  NSObject+HHKVC.m
//  HHExercise
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "NSObject+HHKVC.h"
#import <objc/runtime.h>
@implementation NSObject (HHKVC)
/**
 赋值过程：
 
 先找相关方法  set<Key>:, _set<Key>:, setIs<Key>:
 
 2. 若没有相关方法 + (BOOL)accessInstanceVariablesDirectly，判断是否可以直接方法成员变量
 
 3. 如果是判断是NO,直接执行KVC的setValue:forUndefinedKey:(系统抛出一个异
 常，未定义key)
 
 4. 如果是YES，继续找相关变量_<key>、 _is<Key>、 <key>、 is<Key>
 
 5. 方法或成员都不存在，setValue: forUndefinedKey: 方法，默认是抛出异常
 */
- (void)hh_setValue:(nullable id)value forKey:(NSString *)key;{
   /** 判断是否合法 */
    if (key == nil || key.length == 0) {
        return;
    }
    if (!value) {
        value = @"";
    }
    /** 查找相关方法 */
    NSString *Key = key.capitalizedString;
    NSString *selectorName = [NSString stringWithFormat:@"set%@",Key];
    if ([self respondsToSelector:NSSelectorFromString(selectorName)]) {
        [self performSelector:NSSelectorFromString(selectorName) withObject:value];
        return;
    }
    NSString *_selectorName = [NSString stringWithFormat:@"_set%@",Key];
    if ([self respondsToSelector:NSSelectorFromString(_selectorName)]) {
        [self performSelector:NSSelectorFromString(_selectorName) withObject:value];
        return;
    }
    NSString *isSelectorName = [NSString stringWithFormat:@"setIs%@",Key];
    if ([self respondsToSelector:NSSelectorFromString(isSelectorName)]) {
        [self performSelector:NSSelectorFromString(isSelectorName) withObject:value];
        return;
    }
    /** 若没有找到相关方法 判断是否可以访问成员变量 accessInstanceVariablesDirectly  == YES */
    if (![[self class] accessInstanceVariablesDirectly]) {
        NSException *exception = [NSException exceptionWithName:@"NSUnknowForUndefineKey" reason:@"accessInstanceVariablesDirectly 设置为了NO" userInfo:nil];
        @throw exception;
    }
    
    /** 再去查找成员变量 */
   unsigned int count = 0;
    /** 获取成员变量 runtime */
    NSMutableArray *array = [NSMutableArray array];
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *varName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:varName];
        [array addObject:name];
    }
    
    for (int i = 0; i< count ; i++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    for (int i = 0; i< count ; i++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@",Key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    for (int i = 0; i< count ; i++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@",key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    for (int i = 0; i< count ; i++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@",Key]]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    [self setValue:value forUndefinedKey:key];
    free(ivars);
}
/**
 取值过程：
 
 1. 按照这个顺序查找相关方法  get<Key>，<key>，is<Key>，或者_<key>，
 
 2. 若没有相关方法 + (BOOL)accessInstanceVariablesDirectly，判断是否可以直接方法成员变量
 
 3. 如果是判断是NO,直接执行KVC的valueForUndefinedKey:(系统抛出一个异
 常，未定义key)
 
 4. 如果是YES，继续找相关变量_<key> 、_is<Key> 、 <key> 、is<Key>
 
 5. 方法或成员都不存在，valueForUndefinedKey:方法，默认是抛出异常
 */
- (nullable id)hh_valueForKey:(NSString *)key {
    
    if (!key || key.length == 0) {
        return nil;
    }
    
    NSString *Key = key.capitalizedString;
    
    
    
    if ([self respondsToSelector:NSSelectorFromString(key)]) {
        NSLog(@"value:forkey:---%@",key);
      return   [self performSelector:NSSelectorFromString(key)];
        
    }
    if ([self respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"get%@",Key])]) {
        NSLog(@"value:forkey:---%@",[NSString stringWithFormat:@"get%@",Key]);
       return  [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"get%@",Key])];
    }
    if ([self respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"is%@",Key])]) {
        NSLog(@"value:forkey:---%@",[NSString stringWithFormat:@"is%@",Key]);
        return  [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"is%@",Key])];
    }
    if ([self respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"_%@",key])]) {
        NSLog(@"value:forkey:---%@",[NSString stringWithFormat:@"_%@",key]);
        return  [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"_%@",key])];
    }
    if (![[self class] accessInstanceVariablesDirectly]) {
        NSException *exception = [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
        @throw exception;
    }
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *keyName = [NSString stringWithUTF8String:ivarName];
        [array addObject:keyName];
    }
    //继续顺序查找找相关变量 _<key> 、_is<Key> 、 <key> 、is<Key>
    for (int i = 0; i < count; i ++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
          return   object_getIvar(self, ivars[i]);
//            free(ivars);
        }
    }
    for (int i = 0; i < count; i ++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@",Key]]) {
        return  object_getIvar(self, ivars[i]);
//            free(ivars);
        }
    }
    for (int i = 0; i < count; i ++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"_is%@",Key]]) {
           return  object_getIvar(self, ivars[i]);
//            free(ivars);
        }
    }
    for (int i = 0; i < count; i ++) {
        NSString *keyName = array[i];
        if ([keyName isEqualToString:[NSString stringWithFormat:@"%@",key]]) {
           return  object_getIvar(self, ivars[i]);
//            free(ivars);
        }
    }
    return  [self valueForUndefinedKey:key];
//    free(ivars);
    
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"key = %@ 不存在",key);
    return;
}
- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"key = %@ 不存在",key);
    return nil;
}
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"%@ 值不能为空",key);
    return;
}
@end
