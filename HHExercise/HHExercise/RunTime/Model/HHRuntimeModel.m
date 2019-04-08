//
//  HHRuntimeModel.m
//  HHExercise
//
//  Created by Now on 2019/4/8.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHRuntimeModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation HHRuntimeModel
- (void)walk {
    NSLog(@"--%s--",__func__);
}
//- (void)study {
//    NSLog(@"--%s--",__func__);
//}
+ (void)sleep {
    NSLog(@"--%s--",__func__);
}
+ (void)sleeps {
    NSLog(@"--%s--",__func__);
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    return [super respondsToSelector:aSelector];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s",__func__);
    if (sel  == @selector(study)) {
//        Method method = class_getInstanceMethod(self, @selector(walk));
//        IMP imp = method_getImplementation(method);
//        const char* types = method_getTypeEncoding(method);
//        //添加方法
//        return class_addMethod(self , sel, imp, types);
    }
    return  [super resolveInstanceMethod:sel];
}
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"%s",__func__);
    return  [super resolveClassMethod:sel];
}
@end
