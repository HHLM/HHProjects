//
//  UIControl+HHExt.m
//  HHExercise
//
//  Created by Now on 2019/4/10.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "UIControl+HHExt.h"
#import <objc/runtime.h>

@implementation UIControl (HHExt)
+ (void)load {
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(hh_sendAction:to:forEvent:));
    //方法交换
    method_exchangeImplementations(method1, method2);
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, @selector(setTimeInterval:), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)timeInterval {
    return [objc_getAssociatedObject(self, @selector(setTimeInterval:)) floatValue];
}

- (void)setIgnore:(BOOL)ignore {
    objc_setAssociatedObject(self, @selector(setIgnore:), @(ignore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)ignore {
    return [objc_getAssociatedObject(self, @selector(setIgnore:)) boolValue];
}
- (void)hh_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    //被忽略就不能点击
    if (self.ignore) return;
    if (self.timeInterval > 0) {
        self.ignore = YES;
        //延迟多少时间后在改变bool状态
        [self performSelector:@selector(setIgnore:) withObject:@(NO)  afterDelay:self.timeInterval];
    }
    [self hh_sendAction:action to:target forEvent:event];
}
@end
