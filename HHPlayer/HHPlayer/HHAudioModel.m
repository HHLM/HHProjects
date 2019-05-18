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
    NSArray *array = @[@{@"name":@"水墨兰庭",@"url":@"http://www.ytmp3.cn/down/54723.mp3"},
                       @{@"name":@"下一次爱情来的时候-蔡健雅",@"url":@"http://www.ytmp3.cn/down/53147.mp3"},
                       @{@"name":@"牡丹亭外-任博然",@"url":@"http://www.ytmp3.cn/down/31855.mp3"},
                       @{@"name":@"东南西北风-黄安",@"url":@"http://www.ytmp3.cn/down/60413.mp3"},
                       @{@"name":@"不仅仅只是喜欢-萧全&孙语赛",@"url":@"http://www.ytmp3.cn/down/47049.mp3"},
                       @{@"name":@"菊花台",@"url":@"http://www.ytmp3.cn/down/31853.mp3"},
                       @{@"name":@"如果时光倒流-汪苏泷",@"url":@"http://www.ytmp3.cn/down/32503.mp3"},
                       @{@"name":@"妹妹背着洋娃娃",@"url":@"http://www.ytmp3.cn/down/68528.mp3"},
                       @{@"name":@"半山听雨",@"url":@"http://www.ytmp3.cn/down/50776.mp3"}];
    return [NSArray yy_modelArrayWithClass:[self class] json:array];
}
@end
