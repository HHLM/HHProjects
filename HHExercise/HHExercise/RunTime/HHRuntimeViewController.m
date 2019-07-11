//
//  HHRuntimeViewController.m
//  HHExercise
//
//  Created by Now on 2019/4/3.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHRuntimeViewController.h"
#import "HHRuntimeModel.h"
#import "HHRuntime.h"
#import <objc/runtime.h>
#import "HHRuntime+HHExt.h"
// 数据库中常见的几种类型
#define SQL_TEXT     @"TEXT"    //文本
#define SQL_REAL     @"REAL"    //浮点
#define SQL_BLOB     @"BLOB"    //data
#define SQL_INTEGER  @"INTEGER" //int long integer ...

@interface HHRuntimeViewController ()<HHRuntimeModelDelegate>

@end

@implementation HHRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hh_getVarsList];
}
- (void)hh_getVarsList {
    HHRuntimeModel *model = [HHRuntimeModel new];
    HHRuntime *run = [[HHRuntime alloc] init];
    run.talent = @"hhhh";
    NSLog(@"%@",run.talent);
    model.delegate = self;
    [model todoSomething:@"eat foot",@"sleep",@"hit dou dou",nil];
    unsigned int count = 0;
    /** 成员 */
    Ivar *ivars = class_copyIvarList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *varName = ivar_getName(ivar);
        NSString *keyName = [NSString stringWithUTF8String:varName];
        NSLog(@"copyIvarName : %@",keyName);
    }
    free(ivars);
    NSLog(@"------------------------分割线 成员变量-----------------------------");
}
- (void)hh_getMethodList {
     HHRuntimeModel *model = [HHRuntimeModel new];
    /** 方法 */
    unsigned int count = 0;
    Method *methods = class_copyMethodList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        NSString *keyName = NSStringFromSelector(method_getName(method));
        NSLog(@"copyMethodName : %@",keyName);
    }
    free(methods);
    NSLog(@"------------------------分割线 方法列表----------------------------");
}
- (void)hh_getProperyList {
    /** 属性 */
    HHRuntimeModel *model = [HHRuntimeModel new];
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList([model class], &count);
    for (int i = 0;i < count ; i ++) {
        
        objc_property_t property = propertys[i];
        /** property_getName 用来查找属性的名称，返回 c 字符串 */
        const char *varName  = property_getName(property);
        NSString *keyName = [NSString stringWithUTF8String:varName];
        NSLog(@"copyPropertyName : %@",keyName);
        
        /** property_getAttributes 函数挖掘属性的真实名称和 @ encode 类型，返回 C字符串 */
        const char *varAttributesName = property_getAttributes(property);
        NSString *attributes = [NSString stringWithUTF8String:varAttributesName];
        [self propertTypeConvert:attributes];
        NSLog(@"attributes : %@",attributes);
    }
    free(propertys);
    NSLog(@"------------------------属性列表-------------------------------");
}
- (void)hh_getProtocolList {
    unsigned int count = 0;
    __unsafe_unretained  Protocol **protocols =  class_copyProtocolList([self class], &count);
    NSLog(@"%u",count);
    for (int i = 0; i < count; i ++) {
        Protocol *protocol = protocols[i];
        const char *protocolName = protocol_getName(protocol);
        NSString *keyName = [NSString stringWithUTF8String:protocolName];
        NSLog(@"copyProtocolName：%@",keyName);
    }
    free(protocols);
    NSLog(@"------------------------分割线 协议列表-----------------------------");
}
- (NSString *)propertTypeConvert:(NSString *)typeStr {
    NSString *resultStr = nil;
    if ([typeStr hasPrefix:@"T@\"NSString\""]) {
        resultStr = SQL_TEXT;
    } else if ([typeStr hasPrefix:@"T@\"NSData\""]) {
        resultStr = SQL_BLOB;
    } else if ([typeStr hasPrefix:@"Ti"]||
               [typeStr hasPrefix:@"TI"]||
               [typeStr hasPrefix:@"Ts"]||
               [typeStr hasPrefix:@"TS"]||
               [typeStr hasPrefix:@"TB"]||
               [typeStr hasPrefix:@"Tq"]||
               [typeStr hasPrefix:@"TQ"]||
               [typeStr hasPrefix:@"T@\"NSNumber\""]) {
        resultStr = SQL_INTEGER;
    } else if ([typeStr hasPrefix:@"Tf"] ||
               [typeStr hasPrefix:@"Td"]) {
        resultStr= SQL_REAL;
    }
    NSLog(@"%@",resultStr);
    return resultStr;
}
- (void)hh_encode {
    NSLog(@"int        : %s", @encode(int));
    NSLog(@"float      : %s", @encode(float));
    NSLog(@"float *    : %s", @encode(float*));
    NSLog(@"char       : %s", @encode(char));
    NSLog(@"char *     : %s", @encode(char *));
    NSLog(@"BOOL       : %s", @encode(BOOL));
    NSLog(@"NSNumber   : %s", @encode(NSNumber*));
    NSLog(@"void       : %s", @encode(void));
    NSLog(@"void *     : %s", @encode(void *));
    NSLog(@"NSString   : %s", @encode(NSString*));
    NSLog(@"NSArray    : %s", @encode(NSArray*));
    NSLog(@"NSObject * : %s", @encode(NSObject *));
    NSLog(@"NSObject   : %s", @encode(NSObject));
    NSLog(@"[NSObject] : %s", @encode(typeof([NSObject class])));
    NSLog(@"NSError ** : %s", @encode(typeof(NSError **)));
    NSLog(@"NSDictionary    : %s", @encode(NSDictionary*));
}
- (void)runtimeShowMethod {
    
}
@end
