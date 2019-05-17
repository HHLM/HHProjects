//
//  HHPlayer.h
//  HHPlayer
//
//  Created by Now on 2019/5/17.
//  Copyright © 2019 任他疾风起. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHPlayerDelegate <NSObject>

- (void)audioPlayerBeiginLoadVoice;

- (void)audioPlayerBeiginPlay;

- (void)audioPlayerDidFinishPlay;


@end

@interface HHPlayer : NSObject

@property (nonatomic, weak) id <HHPlayerDelegate> delegate;
/** 所有时间 */
@property (nonatomic, assign) long allTime;
/** 当前播放时间 */
@property (nonatomic, assign) long currentTime;

+(instancetype)sharePlayer;



/** 开始播放 */
- (void)playURL:(NSString *)urlString;

/** 暂停播放 */
- (void)pausePlayer;

/** 停止播放 */
- (void)stopPlayer;

/** 播放进度 */
- (void)playerProgress:(CGFloat)progress;


@end

NS_ASSUME_NONNULL_END
