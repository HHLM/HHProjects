//
//  HHKVOViewController.m
//  HHExercise
//
//  Created by Now on 2019/4/3.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHKVOViewController.h"
#import <objc/runtime.h>
@interface HHKVOViewController ()

@end

@implementation HHKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(UITextField.class, &count);
    for (int i =0 ; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *varName = ivar_getName(ivar);
        NSString *keyName = [NSString stringWithUTF8String:varName];
        NSLog(@"%@",keyName);
    }
    
//    Ivar *ivarp = class_copyPropertyList([UITextField class], &count);
//    for (int i = 0; i < count; i ++) {
//        Ivar ivar = ivarp[i];
//        const char *varName = ivar_getName(ivar);
//        NSString *keyName = [NSString stringWithUTF8String:varName];
//        NSLog(@"---------%@",keyName);
//    }
    
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
