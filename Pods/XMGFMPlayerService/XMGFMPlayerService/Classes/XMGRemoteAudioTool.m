//
//  XMGPlayerService.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRemoteAudioTool.h"
#import "FSAudioStream.h"


@interface XMGRemoteAudioTool()

@property (nonatomic, strong) FSAudioStream *audioStream;


@end

@implementation XMGRemoteAudioTool



- (void)playWithURL:(NSURL *)url withStateBlock: (void(^)(AudioState state))stateBlock {

    if ([url isEqual:self.audioStream.url]) {
        if (!self.audioStream.isPlaying) {
            // 再次暂停, 执行开始动作
            [self.audioStream pause];
        }

        return;
    }


    FSStreamConfiguration *config = [FSStreamConfiguration new];
    config.enableTimeAndPitchConversion = YES;
    config.cacheEnabled = YES;
    config.cacheDirectory = NSTemporaryDirectory();

    config.seekingFromCacheEnabled = YES;


    self.audioStream = [[FSAudioStream alloc] initWithConfiguration:config];
    self.audioStream.url = url;
    __weak XMGRemoteAudioTool *weakSelf = self;
    [self.audioStream setOnStateChange:^(FSAudioStreamState state) {
        if (state == kFsAudioStreamPlaying) {
            weakSelf.state = AudioPlaying;
            if (stateBlock) {
                stateBlock(AudioPlaying);
            }
        }else if (state == kFsAudioStreamFailed || state == kFsAudioStreamPaused || state == kFsAudioStreamRetryingFailed) {
            weakSelf.state = AudioPause;
            if (stateBlock) {
                stateBlock(AudioPause);
            }

        }else {
            weakSelf.state = AudioLoading;
            if (stateBlock) {
                stateBlock(AudioLoading);
            }
        }
    }];


    [self.audioStream preload];
    [self.audioStream play];


}



- (void)seekProgress: (float)progress {

    FSStreamPosition fss;
    fss.position = progress;

    // 播放音频
    self.audioStream.volume = 0;
    [self.audioStream seekToPosition:fss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.audioStream.volume = 1;
    });


}




- (void)playCurrentAudio {

    if (!self.audioStream.isPlaying) {
        [self.audioStream pause];
    }
}

- (void)pauseCurrentAudio
{
    if (self.audioStream.isPlaying) {
        [self.audioStream pause];
    }
}

- (void)seekBack: (unsigned int)time
{


    FSStreamPosition position;
    position.position = (self.currentPlayTime - time) / self.currentTotalTime;
    if (position.position < 0) {
        position.position = 0.0000000001;
    }
    self.audioStream.volume = 0;
    [self.audioStream seekToPosition:position];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.audioStream.volume = 1;
    });


}
- (void)seekFast: (unsigned int)time {



    FSStreamPosition position;
    position.position = (self.currentPlayTime + time) / self.currentTotalTime;
    if (position.position > 1) {
        position.position = 1;
    }
    self.audioStream.volume = 0;
    [self.audioStream seekToPosition:position];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.audioStream.volume = 1;
    });
}

- (void)changeRate: (float)rate {

    [self.audioStream setPlayRate:rate];
    
}


- (float)currentPlayTime {
    return self.audioStream.currentTimePlayed.playbackTimeInSeconds;
}
- (float)currentTotalTime {
    return self.audioStream.duration.playbackTimeInSeconds;
}





@end
