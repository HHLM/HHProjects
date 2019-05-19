//
//  HHPlayer.m
//  HHPlayer
//
//  Created by Now on 2019/5/17.
//  Copyright © 2019 任他疾风起. All rights reserved.
//

#import "HHPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface HHPlayer ()<AVAudioPlayerDelegate>
{
    AVPlayer        *_avPlayer;
    AVURLAsset      *_asset;
    AVPlayerItem    *_playerItem;
}
@end

@implementation HHPlayer

+ (instancetype)sharePlayer {
    static HHPlayer *sharePlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharePlayer) {
            sharePlayer = [[HHPlayer alloc] init];
        }
    });
    return sharePlayer;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/** 开始播放 */
- (void)playURL:(NSString *)urlString {
    if (_avPlayer ) {
        [_avPlayer pause];
        _avPlayer = nil;
        _asset = nil;
        [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
        _playerItem = nil;
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:urlString] options:nil];
    _asset = asset;
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    _playerItem = playerItem;
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    _avPlayer = player;

    
    /// 添加监听.以及回调
    __weak typeof(self) weakSelf = self;
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        /// 更新播放进度
//        NSLog(@"总时间%d---当前进度%lld",time.timescale,time.value);
        weakSelf.allTime =  player.currentItem.duration.value/player.currentItem.duration.timescale;
        weakSelf.currentTime = player.currentTime.value/player.currentTime.timescale;
        NSLog(@"总时间：%ld",weakSelf.allTime);
        NSLog(@"当前时间：%ld",weakSelf.currentTime);
//        NSLog(@"当前时间1：%d",player.currentItem.currentTime);
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(audioPlayerAllTime:currentTime:)]) {
            [weakSelf.delegate audioPlayerAllTime:weakSelf.allTime currentTime: weakSelf.currentTime];
        }
    }];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_avPlayer.currentItem];
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"-----%@",object);
        AVPlayerItem *item = (AVPlayerItem *)object;
        if (item.status == AVPlayerItemStatusReadyToPlay) {
            [_avPlayer play];
            //对播放界面的一些操作，时间、进度等
        }else if (item.status == AVPlayerItemStatusUnknown) {
            NSLog(@"未知错误");
            if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerFailPlay)]) {
                [self.delegate audioPlayerFailPlay];
            }
        } else if (item.status == AVPlayerItemStatusFailed) {
            NSLog(@"播放错误");
            if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerFailPlay)]) {
                [self.delegate audioPlayerFailPlay];
            }
        }
    }
}
- (void)playbackFinished:(NSNotification *)info {
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerDidFinishPlay)]) {
        [self.delegate audioPlayerDidFinishPlay];
    }
}
/** 暂停播放 */
- (void)pausePlayer {
    [_avPlayer pause];
}

/** 停止播放 */
- (void)stopPlayer {
    [_avPlayer play];
}

/** 播放进度 */
- (void)playerProgress:(NSInteger)progress {
    CMTime changedTime = CMTimeMakeWithSeconds(progress, 1.0);
    [_avPlayer seekToTime:changedTime completionHandler:^(BOOL finished) {
        
    }];
    
}
@end
