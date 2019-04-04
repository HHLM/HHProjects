//
//  HHTimer.m
//  GCDTimer
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 tz. All rights reserved.
//

#import "HHTimer.h"

@implementation HHTimer

- (dispatch_source_t)timer {
    if (!_timer) {
        dispatch_queue_t queue = dispatch_get_main_queue();
       _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }return _timer;
}

- (void)creatTime:(NSInteger)tiem WithBlock:(TimerBlock)block {
    _block = [block copy];
    // 队列
    // dispatch_queue_t queue = dispatch_get_main_queue();
    // dispatch_queue_t queue = dispatch_queue_create("timer_serial_label", DISPATCH_QUEUE_SERIAL);
    
    // 创建定时器
    __block dispatch_source_t timer = _block();
    //    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时的开始时间、间隔时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), tiem*NSEC_PER_SEC, 0);
    
    // 设置定时器回调
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"你好");
        
        block();
        //        [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //            NSLog(@"hello");
        //        }];
        
    });
    
    // 启动定时器，默认是关闭的
    dispatch_resume(timer);
    
    self.timer = timer;
}


@end
