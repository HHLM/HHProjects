//
//  NSString+Ext.m
//  HiGuestProject
//
//  Created by Mac on 2019/1/9.
//  Copyright © 2019 Chris.Chen. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)
+ (NSString *)filterSpecialString:(NSString *)string
{
    if (string == nil) {
        return @"";
    }
    
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}
+ (NSString *)pinyinForString:(NSString *)string
{
    if (string.length == 0) {
        return nil;
    }
    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSMutableString *pinyinString = [[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]] mutableCopy];
    
    NSString *str = [string substringToIndex:1];
    
    // 多音字处理http://blog.csdn.net/qq_29307685/article/details/51532147
    if ([str isEqualToString:@"长"])
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([str isEqualToString:@"沈"])
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([str isEqualToString:@"厦"])
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([str isEqualToString:@"地"])
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 2) withString:@"di"];
    }
    if ([str isEqualToString:@"重"])
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    return [[pinyinString lowercaseString] copy];
}
+ (NSString *)jsonStringForData:(id)data {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (id)jsonStringEncode {
    if (!self) {
        return nil;
    }
    NSData *jsonData  = [self dataUsingEncoding:NSUTF8StringEncoding];
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}

+ (NSString *)stringForArray:(NSArray *)array withKey:(NSString *)key {
    return [array componentsJoinedByString:key?:@","];
}

- (NSArray *)componentsSeparatedByKey:(NSString *)key {
    if (!self) {
        return @[];
    }
    return [self componentsSeparatedByString:key?:@""];
}
- (NSData *)jsonStringToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
+ (NSString *)jsonStringFromData:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
