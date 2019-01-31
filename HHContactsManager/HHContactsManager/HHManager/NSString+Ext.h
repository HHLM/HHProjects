//
//  NSString+Ext.h
//  HiGuestProject
//
//  Created by Mac on 2019/1/9.
//  Copyright © 2019 Chris.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Ext)

/** 格式化手机号*/
+ (NSString *)filterSpecialString:(NSString *)string;

/** 转拼音*/
+ (NSString *)pinyinForString:(NSString *)string;

/** 字典/数组转json */
+ (NSString *)jsonStringForData:(id)data;

/** json解析 */
- (id)jsonStringEncode;

/**
 数组转成字符串
 @param array 数组
 @param key 分割符号  nil 默认是 ，
 @return string
 */
+ (NSString *)stringForArray:(NSArray *)array withKey:(NSString *)key;

/**
 字符串分割
 @param key 分割符号
 @return array
 */
- (NSArray *)componentsSeparatedByKey:(NSString *)key;

/** json转成data */
- (NSData *)jsonStringToData;

/** data转成json字符串 */
+ (NSString *)jsonStringFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
