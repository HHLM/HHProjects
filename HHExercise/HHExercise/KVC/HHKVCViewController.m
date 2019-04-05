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
    
//    [self hh_kvcSelector];
    [self hh_kvc_array ];
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
    /*
     @property (readonly, copy) NSString *uppercaseString;      //大写
     @property (readonly, copy) NSString *lowercaseString;      //小写
     @property (readonly, copy) NSString *capitalizedString;    //首字符大写
     */

    NSArray *array = @[@"age",@"nickName",@"sonName",@"dogName"];
    NSArray *lengthArray = [array valueForKey:@"length"];
    NSArray *upperArray = [array valueForKey:@"uppercaseString"];
    NSArray *lowerArray = [array valueForKey:@"lowercaseString"];
    NSArray *capitaArray = [array valueForKey:@"capitalizedString"];
    NSLog(@"%@",lengthArray);
    NSLog(@"%@",upperArray);
    NSLog(@"%@",lowerArray);
    NSLog(@"%@",capitaArray);
    HHKVCModel *mode1 = [[HHKVCModel alloc] init];
    NSDictionary *dic1 = @{@"age":@"101",@"dogName":@"hali",@"sonName":@"son",@"nickName":@"Now"};
    [mode1 setValuesForKeysWithDictionary:dic1];
    HHKVCModel *mode2 = [[HHKVCModel alloc] init];
    NSDictionary *di2 = @{@"age":@"111",@"dogName":@"hali",@"sonName":@"son",@"nickName":@"Now"};
    [mode2 setValuesForKeysWithDictionary:di2];
    HHKVCModel *model3 = [[HHKVCModel alloc] init];
    NSDictionary *dic3 = @{@"age":@"121",@"dogName":@"hali",@"sonName":@"son",@"nickName":@"Now"};
    [model3 setValuesForKeysWithDictionary:dic3];
    NSArray *modelArray = @[mode1,mode2,model3];
    NSArray *models = [modelArray valueForKey:@"_age"];
    NSLog(@"%@",models);
}
@end
