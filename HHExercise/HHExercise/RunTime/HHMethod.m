//
//  HHMethod.m
//  HHExercise
//
//  Created by Now on 2019/4/26.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHMethod.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation HHMethod
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method1 = class_getInstanceMethod(self, @selector(run:));
        Method method2 = class_getInstanceMethod(self, @selector(getMethod));
        
        IMP imp = imp_implementationWithBlock(^(id self){
            NSLog(@"方法被交换了");
        });

        /** 方法交换 */
        method_exchangeImplementations(method1, method2);
        class_replaceMethod([self class], @selector(getMethod), imp, sel_getName(@selector(getMethod)));
        
    });
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getMethod];
        [self getMethodList];
    }
    return self;
}
/** 获取方法列表 */
- (void)getMethodList {
    
    unsigned int count = 0;
    
    Method *list = class_copyMethodList(self.class, &count);
    
    for (int i = 0; i < count; i ++) {
        Method method = list[i];
        /** 得到方法名 */
        SEL sel = method_getName(method);
        const char *cName = sel_getName(sel);
        NSString *name = [NSString stringWithUTF8String:cName];
        name = NSStringFromSelector(sel);
        
        char *type = method_copyReturnType(method);
        NSString *typeName = [NSString stringWithUTF8String:type];
        
        /** 函数指针 */
        IMP imp = method_getImplementation(method);
        NSLog(@"方法名：%@\t\t type：%@\t\t%p\t\t",name,typeName,imp);
       //class_replaceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
    }
    objc_msgSend(self, @selector(run:),@"你向要的到底是什么~~");
    
}
- (void)getMethod {
    
    SEL seleter = NSSelectorFromString(@"run");
   
    IMP imp = [self methodForSelector:seleter];
    
    imp = [[self class] instanceMethodForSelector:seleter];
    
    imp = imp_implementationWithBlock(^(id self, NSString *text){
        NSLog(@"block 被调用了");
        
        return @"block 被调用了";
    });
    
    /** 定义个一个方法 */
    void(*function)(id self ,SEL _cmd,NSObject *objc) = (void (*)(id,SEL,NSObject*))[self methodForSelector:@selector(run:)];
    
    /** 交换了执行方法 */
    class_replaceMethod(self.class, @selector(run:), imp, sel_getName(@selector(run:)));
    
    /** 执行方法 */
    function(self,seleter,@"sssss");
    
    [self run:@"ss"];
}

- (void)run:(NSString *)hh {
    
    NSLog(@"%s--%@",__func__,hh);
}
@end
