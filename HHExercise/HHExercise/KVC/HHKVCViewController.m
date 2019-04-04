//
//  HHKVCViewController.m
//  HHExercise
//
//  Created by Now on 2019/4/3.
//  Copyright © 2019 where are you. All rights reserved.
//

#import "HHKVCViewController.h"
#import "HHKVCModel.h"
#import "NSObject+HHKVC.h"
@interface HHKVCViewController ()

@end

@implementation HHKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HHKVCModel *model = [[HHKVCModel alloc] init];
    model.count = 10;
    NSLog(@"------%@",[model valueForKey:@"Books"]);
    
    [self hh_kvcSelector];
}
- (void)hh_kvcSelector {
    //kvc 简洁访问属性
    HHKVCModel *model = [[HHKVCModel alloc] init];
    [model hh_setValue:@"HHHH" forKey:@"name"];
    
    NSLog(@"%@",[model valueForKey:@"name"]);
    NSLog(@"%@",[model hh_valueForKey:@"name"]);
    NSLog(@"%@",[model hh_valueForKey:@"_name"]);
    NSLog(@"%@",[model hh_valueForKey:@"age"]);
    [model hh_setValue:@"12" forKey:@"age"];
    NSLog(@"age = %@",model.age);
    [model hh_setValue:@"12" forKey:@"__age"];
    
    NSLog(@"name = %@",model->name);
    NSLog(@"_age = %@",model.age);
}

- (void)hh_kvc_dict {
    HHKVCModel *model = [[HHKVCModel alloc] init];
    NSDictionary *dic = @{@"age":@"111",@"dogName":@"hali",@"sonName":@"son",@"nickName":@"Now"};
    [model setValuesForKeysWithDictionary:dic];
    NSDictionary *info = [model dictionaryWithValuesForKeys:@[@"age",@"nickName"]];
    NSLog(@"info:%@",info);
}
//KVC消息传递
- (void)hh_kvc_array {
    NSArray *array = @[@"age",@"nickName",@"sonName",@"dogName"];
    NSArray *lengthArray = [array valueForKey:@"length"];
    NSArray *lowerArray = [array valueForKey:@"length"];
}
@end
