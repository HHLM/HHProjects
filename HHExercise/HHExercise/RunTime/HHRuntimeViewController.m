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
@interface HHRuntimeViewController ()

@end

@implementation HHRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HHRuntimeModel *model = [HHRuntimeModel new];
    unsigned int count = 0;
    /** 成员 */
    Ivar *ivars = class_copyIvarList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *varName = ivar_getName(ivar);
        NSString *keyName = [NSString stringWithUTF8String:varName];
        NSLog(@"copyIvarName : %@",keyName);
    }
    NSLog(@"------------------------分割线-----------------------------");
    /** 属性 */
    objc_property_t *propertys = class_copyPropertyList([model class], &count);
    for (int i = 0;i < count ; i ++) {
        objc_property_t property = propertys[i];
        const char *varName  = property_getName(property);
        NSString *keyName = [NSString stringWithUTF8String:varName];
        NSLog(@"copyPropertyName : %@",keyName);
    }
    NSLog(@"-------------------------------------------------------");
    /** 方法 */
    Method *methods = class_copyMethodList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        SEL  methodName = method_getName(method);
        NSString *keyName = NSStringFromSelector(methodName);
        NSLog(@"copyMethodName : %@",keyName);
    }
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
