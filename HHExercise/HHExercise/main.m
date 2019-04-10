//
//  main.m
//  HHExercise
//
//  Created by Now on 2019/3/28.
//  Copyright © 2019 where are you. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HHRuntimeModel.h"
#import <objc/runtime.h>
#import "HHRuntime.h"
#import <objc/message.h>

extern void instrumentObjcMessageSends(BOOL);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        HHRuntimeModel *run = [HHRuntimeModel new];
//        run.age = 100;
        instrumentObjcMessageSends(YES);
        [run study];
        [run walk];
        instrumentObjcMessageSends(NO);
        
        //执行对象 执行方法
        
        objc_msgSend(objc_getClass("HHRuntimeModel"), @selector(sleep));
        objc_msgSend(run.class, @selector(sleep));
//        return 0;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
