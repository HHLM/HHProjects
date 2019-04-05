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
    _age = age; //self.age 才有值 要不然没有值
    NSLog(@"%s--%@",__func__,age);
}
- (void)_setAge:(NSString *)age {
    _age = age;
    NSLog(@"%s--%@",__func__,age);
}
- (void)setIsAge:(NSString *)age {
    _age = age;
    NSLog(@"%s--%@",__func__,age);
}
//是否直接访问成员变量 默认是YES
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}
- (NSString *)getName {
    NSLog(@"%s",__func__);
    return @"name";
}
- (NSString *)name {
    NSLog(@"%s",__func__);
    return @"name";
}

- (NSUInteger)countOfBookSet {
  return   self.count;
}

- (NSEnumerator *)enumeratorOfBooks {
    return [self.bookSet objectEnumerator];
}

- (id )memberOfBookSet:(id)object {
    return [self.bookSet containsObject:object] ? object :  nil;
}

- (NSUInteger)countOfBooks {
    return self.count;
}
- (id)objectInBooksAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"books %ld",index];
}
//- (NSString *)getAge {
//    NSLog(@"%s",__func__);
//    return @"getAge";
//}
//- (NSString *)age {
//    NSLog(@"%s",__func__);
//    return @"age";
//}
@end
