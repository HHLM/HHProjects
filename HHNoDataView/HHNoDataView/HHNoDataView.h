//
//  HHNoDataView.h
//  HHNoDataView
//
//  Created by Now on 2019/3/28.
//  Copyright © 2019 你在哪里呀. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HHClicked)(void);


@interface HHNoDataView : UIView

/**
 创建单利（全局实例）
 */
+ (HHNoDataView *)shareNoDataView;

/**
 可以创建多个
 */
+ (instancetype)noDataView;

/**
 *
 *  展示在父视图中心
 *
 *  @param view 父视图
 *  @param icon 图片名称
 */

- (void)showCenterView:(UIView *)view
                  icon:(NSString *)icon;

- (void)showCenterView:(UIView *)view
                  icon:(NSString *)icon
               clicked:(HHClicked )clicked;

- (void)showCenterView:(UIView *)view
                  icon:(NSString *)icon
               message:(NSString *)message;


- (void)showCenterView:(UIView *)view
                  icon:(NSString *)icon
               message:(NSString *)message
               clicked:(HHClicked )clicked;

- (void)showCenterView:(UIView *)view
                 frame:(CGRect)frame
                  icon:(NSString *)icon
               message:(NSString *)message;

- (void)showCenterView:(UIView *)view
                 frame:(CGRect)frame
                  icon:(NSString *)icon
               message:(NSString *)message
               clicked:(HHClicked )clicked;

- (void)clear;

- (void)wipeOut;
@end

NS_ASSUME_NONNULL_END
