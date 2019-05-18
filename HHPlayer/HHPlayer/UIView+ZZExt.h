//
//  UIView+ZZExt.h
//  HiGuestProject
//
//  Created by Mac on 2018/10/14.
//  Copyright © 2018 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>



#pragma mark -- load Nib
@interface UIView (ZZExt)

@end

#pragma mark -- Register
@interface UIView (Register)
+ (instancetype _Nullable )loadInstanceFromNib;

+ (instancetype _Nullable )loadInstanceFromNibWithName:(NSString *_Nullable)nibName;

+ (instancetype _Nullable )loadInstanceFromNibWithName:(NSString *_Nullable)nibName owner:(nullable id)owner;

+ (instancetype _Nullable )loadInstanceFromNibWithName:(NSString *_Nullable)nibName owner:(nullable id)owner bundle:(NSBundle *_Nullable)bundle;

- (void)setRoundingCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

@end


#pragma mark -- CornerRadius
@interface UIView (CornerRadius)

@end

#pragma mark -- frame
@interface UIView (frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end


