//
//  HHRuntime.m
//  HHExercise
//
//  Created by Now on 2019/4/8.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHRuntime.h"

@implementation HHRuntime
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s",__func__);
    BOOL resolve = [super resolveInstanceMethod:sel];
    /**
     resolve 为 YES继续执行
     若为NO的时候调用 forwardingTargetForSelector:方法
     */
    return resolve;
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    id forward = [super forwardingTargetForSelector:aSelector];
    if (forward == nil) {
        //执行 methodSignatureForSelector: 方法
    }
    return forward;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    NSMethodSignature *methodSigna = [super methodSignatureForSelector:aSelector];
    if (methodSigna == nil) {
        //就结束崩溃
    }
    return methodSigna;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    [anInvocation invokeWithTarget:self];
    NSLog(@"%s",__func__);
    [super forwardInvocation:anInvocation];
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }else {
        NSLog(@"%s",__func__);
        return NO;
    }
}
@end
