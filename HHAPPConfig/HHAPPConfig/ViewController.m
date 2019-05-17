//
//  ViewController.m
//  HHAPPConfig
//
//  Created by Now on 2019/1/31.
//  Copyright © 2019 你在哪里呀. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hh_gcdSingle1]
    ;
}
/*
同事执行三个线程，两个执行完毕之后才执行第三个
semaphore_t 创建信号量的最大执行线程数 max
waite 等待时间
signal 发送信号  小max 执行当前线程 == max 等待  >max 执行下面的后面的
*/
- (void)hh_gcdSingle1 {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 2; i++) {
        dispatch_async(quene, ^{
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i+1)*1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"-------");
                dispatch_semaphore_signal(semaphore);
            });
            
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    dispatch_async(quene, ^{
        NSLog(@"😑😑😑😑😑");
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"😑");
}
@end
