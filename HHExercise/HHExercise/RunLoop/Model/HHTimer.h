//
//  HHTimer.h
//  GCDTimer
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef dispatch_source_t(^TimerBlock)(void);
@interface HHTimer : NSObject
@property (nonatomic, copy) TimerBlock block;
@property (nonatomic, strong) dispatch_source_t timer;

- (void)creatTime:(NSInteger)tiem WithBlock:(TimerBlock)block;

@end

NS_ASSUME_NONNULL_END
