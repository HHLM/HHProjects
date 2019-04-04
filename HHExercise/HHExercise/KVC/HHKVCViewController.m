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
    //kvc 简洁访问属性
    HHKVCModel *model = [[HHKVCModel alloc] init];
    [model hh_setValue:@"HHHH" forKey:@"name"];
    NSLog(@"%@",[model valueForKey:@"name"]);
     NSLog(@"%@",[model hh_valueForKey:@"name"]);
    NSLog(@"%@",[model hh_valueForKey:@"_name"]);
    NSLog(@"%@",[model hh_valueForKey:@"age"]);
     [model hh_setValue:@"12" forKey:@"age"];
     NSLog(@"age = %@",model.age);
//
    [model hh_setValue:@"12" forKey:@"__age"];
//    [model hh_setValue:@"11" forKey:@"_age"];
//    [model setValue:@"13" forKey:@"name"];
    NSLog(@"name = %@",model->name);
    NSLog(@"_age = %@",model.age);
    
//    NSLog(@"isAge = %@",model->isAge);
//    NSLog(@"_isAge = %@",model->isAge);
}


@end
