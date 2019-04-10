//
//  UIControl+HHExt.h
//  HHExercise
//
//  Created by Now on 2019/4/10.
//  Copyright © 2019 where are you. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (HHExt)
/** 是否能被点击 */
@property (nonatomic, assign) BOOL ignore;
/** 间隔时间 */
@property (nonatomic, assign) NSTimeInterval timeInterval;
@end

NS_ASSUME_NONNULL_END
