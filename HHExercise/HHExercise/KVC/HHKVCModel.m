//
//  HHKVCModel.m
//  HHExercise
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHKVCModel.h"

@implementation HHKVCModel
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setAge:(NSString *)age {
    NSLog(@"%s--%@",__func__,age);
}
- (void)_setAge:(NSString *)age {
     NSLog(@"%s--%@",__func__,age);
}
- (void)setIsAge:(NSString *)age {
    NSLog(@"%s--%@",__func__,age);
}
//是否直接访问成员变量 默认是YES
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}
@end
