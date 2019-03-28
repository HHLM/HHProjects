//
//  ViewController.m
//  HHNoDataView
//
//  Created by Now on 2019/1/31.
//  Copyright © 2019 你在哪里呀. All rights reserved.
//

#import "ViewController.h"
#import "HHNoDataView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[HHNoDataView shareNoDataView] showCenterView:self.view icon:@"" clicked:^{
        NSLog(@"点我干啥~~~~");
    }];;
}


@end
