//
//  HHRuntime+HHExt.m
//  HHExercise
//
//  Created by Now on 2019/4/10.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHRuntime+HHExt.h"
#import <objc/runtime.h>
@implementation HHRuntime (HHExt)

/** 添加成员变量 */
- (void)setTalent:(NSString *)talent {
    objc_setAssociatedObject(self, @selector(setTalent:), @"HHH",  OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)talent {
    return objc_getAssociatedObject(self, @selector(talent));
}
@end
