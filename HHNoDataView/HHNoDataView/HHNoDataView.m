//
//  HHNoDataView.m
//  HHNoDataView
//
//  Created by Now on 2019/3/28.
//  Copyright © 2019 你在哪里呀. All rights reserved.
//

#import "HHNoDataView.h"


@interface HHNoDataView ()
@property (nonatomic, copy) HHClicked kclicked;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *msgLab;
@property (nonatomic, strong) NSString *message;
@end

const CGFloat kAinimateDuration = 0.25f;

@implementation HHNoDataView

+ (HHNoDataView *)shareNoDataView {
    static HHNoDataView *nodataView;
    if (!nodataView) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            nodataView = [[HHNoDataView alloc] init];
        });
    }
    return nodataView;
}

+ (instancetype)noDataView {
    return [[self alloc] init];
}

- (void)clear {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}


- (void)clicked {
    if (self.kclicked) {
        self.kclicked();
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.iconView];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    self.iconView.center = self.center;
}
- (void)showView:(UIView *)view icon:(NSString *)icon {
    self.frame = view.frame;
    if (!view) {
        return;
    }
    icon = icon ?:@"";
    self.message = @"暂无数据~~";
    self.backgroundColor = view.backgroundColor;
    [view insertSubview:self atIndex:0];
    self.iconView.image = [UIImage imageNamed:icon];
    if (self.message) {
        [self addSubview:self.msgLab];
        CGRect rect = self.msgLab.frame;
        self.msgLab.text = self.message;
        [self.msgLab sizeToFit];
        rect.origin.y = CGRectGetMaxY(self.iconView.frame) + 10;
        self.msgLab.frame = rect;
        
        if (icon.length < 1) {
            self.msgLab.center = self.center;
        }
    }
}

- (void)showView:(UIView *)view frame:(CGRect)frame icon:(NSString *)icon
{
    [self showView:view icon:icon];
    self.frame = frame;
}

- (void)showCenterView:(UIView *)view icon:(NSString *)icon
{
    [self showView:view icon:icon];
    self.frame = view.frame;
}

- (void)showCenterView:(UIView *)view icon:(NSString *)icon clicked:( HHClicked )clicked
{
    self.kclicked = clicked;
    [self showView:view icon:icon];
}
- (void)showCenterView:(UIView *)view icon:(NSString *)icon message:(NSString *)message {
    self.message = message;
    [self showView:view icon:icon];
}
- (void)showCenterView:(UIView *)view icon:(NSString *)icon message:(NSString *)message clicked:(HHClicked)clicked
{
    [self showCenterView:view icon:icon message:message];
    self.kclicked = clicked;
}

- (void)showCenterView:(UIView *)view
                 frame:(CGRect)frame
                  icon:(NSString *)icon
               message:(NSString *)message
               clicked:(HHClicked )clicked {
    [self showCenterView:view icon:icon message:message clicked:clicked];
    self.frame = view.frame;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _iconView.backgroundColor = [UIColor redColor];
        _iconView.image = [UIImage imageNamed:@"noData"];
    }
    return _iconView;
}

- (UILabel *)msgLab {
    if (!_msgLab) {
        _msgLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame)-20, 20)];
        _msgLab.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
        [_msgLab addGestureRecognizer:tap];
        _msgLab.userInteractionEnabled = YES;
    }
    return _msgLab;
}

@end
