//
//  HHAudioModel.m
//  HHPlayer
//
//  Created by Now on 2019/5/17.
//  Copyright © 2019 任他疾风起. All rights reserved.
//

#import "HHAudioModel.h"
#import "YYModel/YYModel.h"
@implementation HHAudioModel
+ (NSArray *)audioArray {
    NSArray *array = @[@{@"name":@"水墨兰庭",
                         @"url":@"http://www.ytmp3.cn/down/54723.mp3"},
                       @{@"name":@"下一次爱情来的时候-蔡健雅",
                         @"url":@"http://www.ytmp3.cn/down/53147.mp3"},
                       @{@"name":@"Take me Hand",
                         @"url":@"http://www.ytmp3.cn/down/61894.mp3"},
                       @{@"name":@"东南西北风-黄安",
                         @"url":@"http://www.ytmp3.cn/down/60413.mp3"},
                       @{@"name":@"不仅仅只是喜欢-萧全&孙语赛",
                         @"url":@"http://www.ytmp3.cn/down/47049.mp3"},
                       @{@"name":@"不甘朋友-薛之谦",
                         @"url":@"http://www.ytmp3.cn/down/68930.mp3"},
                       @{@"name":@"I Just Wanna Run",
                         @"url":@"http://www.ytmp3.cn/down/56544.mp3"},
                       @{@"name":@"暧昧-薛之谦",
                         @"url":@"http://www.ytmp3.cn/down/37384.mp3"},
                       @{@"name":@"半山听雨",
                         @"url":@"http://www.ytmp3.cn/down/50776.mp3"},
                       @{@"name":@"爱死了昨天",
                         @"url":@"http://www.ytmp3.cn/down/43690.mp3"},
                       @{@"name":@"浪子的心声",
                         @"url":@"http://www.ytmp3.cn/down/50123.mp3"},
                       @{@"name":@"你的酒馆对我打了烊",
                         @"url":@"http://www.ytmp3.cn/down/59770.mp3"},
                       @{@"name":@"无处可逃",
                         @"url":@"http://www.ytmp3.cn/down/31602.mp3"}];
   
    return [NSArray yy_modelArrayWithClass:[self class] json:array];
}
@end
