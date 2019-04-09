//
//  HHRuntimeModel.m
//  HHExercise
//
//  Created by Now on 2019/4/8.
//  Copyright © 2019 where are you. All rights reserved.
/*  runtime 文章：
    https://www.cnblogs.com/ioshe/p/5489086.html
    https://www.toutiao.com/i6225720353860092417/
    https://www.jianshu.com/p/45db86af7b60
 */
//

#import "HHRuntimeModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation HHRuntimeModel

- (void)walk {
    NSLog(@"--%s--",__func__);
}
- (void)study {
    NSLog(@"--%s--",__func__);
}
+ (void)sleep {
    NSLog(@"--%s--",__func__);
}
+ (void)sleeps {
    NSLog(@"--%s--",__func__);
}
/**
 找不到调用函数时候 第一次掉用 resolveInstanceMethod 动态方法解析，动态方法解析优先于消息转发。若没有进行动态绑定才会进行消息转发，消息转发时候会再次调用
 第一步：调用函数 resolveInstanceMethod:sel （给个机会去提供函数的实现 ） 若返回为NO 执行第二步
    -| 动态绑定新的函数
 第二步：调用函数 forwardingTargetForSelector:aSelector 若返回为nil 执行第三步
    -| 可以通过returen其他对象 ，实现消息转发；
 第三步：调用函数 methodSignatureForSelector:aSelector 若返回nil 找不到调用函数，抛出异常
    -| 消息转发，消息获得函数的参数和返回值类型 ，调用resolveInstanceMethod 方法。若返回是nil 抛出异常；非nil ，Runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象
 第四步：调用新目标 forwardInvocation:anInvocation
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    NSLog(@"%s",__func__);
#if 1
    return  [super resolveInstanceMethod:sel];
#else
    if (sel  == @selector(study)) {
        //方法动态绑定
        Method method = class_getInstanceMethod(self, @selector(walk));
        IMP imp = method_getImplementation(method);
        const char* types = method_getTypeEncoding(method);
        //添加方法
        return class_addMethod(self , sel, imp, types);
    }
#endif
   
}
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"%s",__func__);
    return  [super resolveClassMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    id forward = [super forwardingTargetForSelector:aSelector];
    if (forward == nil) {
        //执行 methodSignatureForSelector: 方法
#if 0
        NSException *exception = [NSException exceptionWithName:@"崩溃了" reason:@"没有找到这个方法" userInfo:nil];
        @throw exception;
#else
        return forward;  //返回个HHRuntimeModel 让他去执行 aSelector方法
#endif
    }
    return forward;
}
- (BOOL)respondsToSelector:(SEL)aSelector {
     NSLog(@"%s",__func__);
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }else {
        NSLog(@"%s",__func__);
        return NO;
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    NSMethodSignature *methodSigna = [super methodSignatureForSelector:aSelector];
    if (methodSigna == nil) {
        const char *type ="v@:";
        //    return nil;
        //    if (methodSigna == nil) {
        //        //就结束崩溃
        //        NSException *exception = [NSException exceptionWithName:@"崩溃了" reason:@"没有找到这个方法" userInfo:nil];
        //        @throw exception;
        //    }
        return  [NSMethodSignature signatureWithObjCTypes:type];;
    }else {
        return methodSigna;
    }
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = @selector(runError);
    anInvocation.selector = sel;
    [anInvocation invokeWithTarget:self.class];
}
+ (void)runError {
    NSLog(@"没有这个方法");
}
@end
