//
//  HHRunLoopViewController.m
//  HHExercise
//
//  Created by Now on 2019/4/3.
//  Copyright © 2019 where are you. All rights reserved.

//  RunLoop 好文章： https://www.jianshu.com/p/4994a99d9c06
// http://weslyxl.coding.me/2018/03/18/2018/3/RunLoop%E4%BB%8E%E6%BA%90%E7%A0%81%E5%88%B0%E5%BA%94%E7%94%A8%E5%85%A8%E9%9D%A2%E8%A7%A3%E6%9E%90/

#import "HHRunLoopViewController.h"
#import "HHThread.h"
@interface HHRunLoopViewController ()
@property (nonatomic, assign) BOOL stop;
@end

@implementation HHRunLoopViewController
/*
 RunLoop 就是一个运行循环，一般情况线程完成后就会停止，但是程序是不能这样的，
 当有交互或者定时器，请求时候就要执行的。
 接受消息-> 等待消息-> 处理消息 循环 ，一直到循环结束
 1、runloop和线程是一一对应的
 2、自动释放池 原理是什么
 3、
 
√————————————————————————————— 我是分割线 —————————————————————————————————√

runloop作用：
1、保存程序的持续运行
2、处理app各种时间（时钟、交互、PerformSelector）
3、节省CPU资源、提高程序性能--（该做事做事，该休息休息）

runloop休眠的原理：
1、调用了内核API(mach_msg()),进入内核，有内核来将线程至于休眠
2、有消息就唤醒线程，回到用户态，来处理消息
 
√————————————————————————————— 我是分割线 —————————————————————————————————√
 
 Run Loop Observer Activities
    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    kCFRunLoopEntry = (1UL << 0),
    kCFRunLoopBeforeTimers = (1UL << 1),
    kCFRunLoopBeforeSources = (1UL << 2),
    kCFRunLoopBeforeWaiting = (1UL << 5),
    kCFRunLoopAfterWaiting = (1UL << 6),
    kCFRunLoopExit = (1UL << 7),
    kCFRunLoopAllActivities = 0x0FFFFFFFU
    };
    或操作 值越小优先级越高
 0b 0000 0001
 0b 0000 0100
 ————————————
 0b 0000 0101
 
√————————————————————————————— 我是分割线 —————————————————————————————————√
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"runloop:%@",[NSRunLoop currentRunLoop]);
    [self addHHThread];
    [self addCFRunLoop];
    [self addPerformSelecter];
}
- (void)addPerformSelecter {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
        NSLog(@"sss-%@",currentRunLoop);
        [currentRunLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        NSLog(@"sss-%@",currentRunLoop.currentMode);
        [self performSelector:@selector(performMain) withObject:nil afterDelay:1];
        //所以如果当前线程没有 RunLoop，则这个方法会失效。
        [currentRunLoop run]; // CFRunLoopRun();用这个也可以
        
        
    });
}
- (void)performMain {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"sss-%s",__func__);
    });
}
- (void)addHHThread {
    //当线程结束的时候 就结束了 不让线程结束
    HHThread *thread = [[HHThread alloc] initWithBlock:^{
        NSLog(@"Hello world");
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"线程持续中~~~");
            if (self.stop) {
                [NSThread exit]; //退出线程
            }
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        //开启runloop
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
}
- (void)addCFRunLoop {
    
    /**
     struct __CFRunLoop {
     CFRuntimeBase _base;
     pthread_mutex_t _lock;           locked for accessing mode list
    __CFPort _wakeUpPort;           // used for CFRunLoopWakeUp
    Boolean _unused;
    volatile _per_run_data *_perRunData;              // reset for runs of the run loop
    pthread_t _pthread; //runloop对应的线程
    uint32_t _winthread;
    CFMutableSetRef _commonModes;//存储的是字符串，记录所有标记为common的mode
    CFMutableSetRef _commonModeItems;//存储所有commonMode的item(source、timer、observer)
    CFRunLoopModeRef _currentMode;//当前运行的mode
    CFMutableSetRef _modes;//存储的是CFRunLoopModeRef，
    struct _block_item *_blocks_head;
    struct _block_item *_blocks_tail;
    CFAbsoluteTime _runTime;
    CFAbsoluteTime _sleepTime;
    CFTypeRef _counterpart;
     };
     */
    
    CFRunLoopRef mainRunLoop = CFRunLoopGetMain();
    
    CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
    
    CFRunLoopMode mode = CFRunLoopCopyCurrentMode(currentRunLoop);
    NSLog(@"model--:%@",mode);
    
    CFArrayRef arrayRef = CFRunLoopCopyAllModes(currentRunLoop);
    
    NSLog(@"arrayRef--:%@",arrayRef);
    /**
     mode四种方式：
     kCFRunLoopCommonModes,     //一个集合 包含其他模式 被标记为common的mode集合（source/observe/timer）
     UITrackingRunLoopMode,     //UI跟踪 模式
     GSEventReceiveRunLoopMode, //接收系统事件
     kCFRunLoopDefaultMode,     //默认的运行循环模式几乎涵盖了所有来源。如果没有特殊原因，您应该始终将源和计时器添加到此模式。
                                可以使用符号kCFRunLoopDefaultMode和NSDefaultRunLoopMod
     */
/**
    * 切换mode必须要退出当前runloop 然后再指定一个mode进入
    * 为了区分分割不同的source/timer/observer，使其不会相互影响
    * runloop其中有一个commomModes的数组，里面保存的是被标记为common的model。
        - 这种标记为common的model有种特性，那就是当 RunLoop 的内容发生变化时，RunLoop 都会自动将 commonModeItems 里的 Source/Observer/Timer 同步到具有"Common" 标记的所有Model里。
 */
}
- (void)addNSRunLoop {
    NSRunLoop *mianRunLoop = [NSRunLoop mainRunLoop];
    NSRunLoop *currnetRunLoop = [NSRunLoop currentRunLoop];
    NSLog(@"currentMode-:%@",currnetRunLoop.currentMode);
 }
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-3-%s",__func__);
//    self.stop = YES;
    [self addNSRunLoop];
}

@end
