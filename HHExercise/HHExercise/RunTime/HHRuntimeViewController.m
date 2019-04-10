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
@interface HHRuntimeViewController ()<HHRuntimeModelDelegate>

@end

@implementation HHRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HHRuntimeModel *model = [HHRuntimeModel new];
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
    /** 属性 */
    objc_property_t *propertys = class_copyPropertyList([model class], &count);
    for (int i = 0;i < count ; i ++) {
        
        objc_property_t property = propertys[i];
        /** property_getName 用来查找属性的名称，返回 c 字符串 */
        const char *varName  = property_getName(property);
        NSString *keyName = [NSString stringWithUTF8String:varName];
        NSLog(@"copyPropertyName : %@",keyName);
        
        /** property_getAttributes 函数挖掘属性的真实名称和 @encode 类型，返回 C字符串 */
        const char *varAttributesName = property_getAttributes(property);
        NSString *attributes = [NSString stringWithUTF8String:varAttributesName];;
        NSLog(@"attributes : %@",attributes);
    }
    free(propertys);
    NSLog(@"------------------------属性列表-------------------------------");
    /** 方法 */
    Method *methods = class_copyMethodList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        NSString *keyName = NSStringFromSelector(method_getName(method));
        NSLog(@"copyMethodName : %@",keyName);
    }
    free(methods);
    NSLog(@"------------------------分割线 方法列表----------------------------");
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
    NSLog(@"------------------------ class_getName(model.class)：%s -------------------------------",class_getName(model.class));
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
