//
//  XMGAudioTool.m
//  01-QQ音乐
//
//  Created by xiaomage on 15/11/4.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGAudioTool.h"


@interface XMGAudioTool()

/** 音乐播放器 */
@property (nonatomic ,strong) AVAudioPlayer  *player;
@property (nonatomic, copy) void(^stateBlock)(BOOL isPlaying);

@end


@implementation XMGAudioTool


- (void)setBackPlay
{
    // 1. 获取音频回话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 2. 设置音频回话类别
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 3. 激活音频回话
    [session setActive:YES error:nil];
}


- (void)playAudioWithPath:(NSURL *)filePath stateBlock:(void(^)(BOOL isPlaying))stateBlock {
    self.stateBlock = stateBlock;
    if ([filePath isEqual:self.player.url]) {
        [self.player play];
        stateBlock(self.player.isPlaying);
        return;
    }

    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:filePath error:nil];
    self.player.enableRate = YES;
    [self.player prepareToPlay];
    [self.player play];
    if (self.stateBlock) {
        self.stateBlock(self.player.isPlaying);
    }

}

- (void)playCurrentAudio {
    [self.player play];
    if (self.stateBlock) {
        self.stateBlock(self.player.isPlaying);
    }
}
- (void)pauseCurrentAudio {
    [self.player pause];
    if (self.stateBlock) {
        self.stateBlock(self.player.isPlaying);
    }
}

- (float)currentPlayTime {
    return self.player.currentTime;
}
- (float)currentTotalTime {
    return self.player.duration;
}

- (void)seekBack: (unsigned int)time {
    self.player.currentTime -= time;
}
- (void)seekFast: (unsigned int)time {
    self.player.currentTime += time;
}
- (void)seekProgress: (float)progress {

    self.player.currentTime = self.player.duration * progress;

}

- (void)changeRate: (float)rate {
    self.player.rate = rate;
}

- (BOOL)isPlaying {
    return self.player.isPlaying;
}

@end
