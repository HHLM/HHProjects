//
//  NSArray+HHExt.m
//  HHExercise
//
//  Created by Now on 2019/4/10.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "NSArray+HHExt.h"
#import <objc/runtime.h>
@implementation NSArray (HHExt)
//防止数据越界
+ (void)load {
    Method method1 = class_getInstanceMethod(self, @selector(objectAtIndex:));
    Method method2 = class_getInstanceMethod(self, @selector(hh_objectAtIndex:));
    method_exchangeImplementations(method1, method2);
}
- (id)hh_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return @"";
    }
    return [self hh_objectAtIndex:index];
}
@end
