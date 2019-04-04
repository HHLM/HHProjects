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
    [model setValue:@"HHHH" forKey:@"name"];
    NSLog(@"%@",[model valueForKey:@"name"]);
    
    [model hh_setValue:@"11" forKey:@"__age"];
    NSLog(@"age = %@",model->age);
//    NSLog(@"_age = %@",model->_age);
    
//    NSLog(@"isAge = %@",model->isAge);
//    NSLog(@"_isAge = %@",model->isAge);
}


@end
