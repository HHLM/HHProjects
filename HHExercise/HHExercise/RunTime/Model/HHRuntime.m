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
    return [super resolveInstanceMethod:sel];
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s",__func__);
    return [super forwardingTargetForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
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
