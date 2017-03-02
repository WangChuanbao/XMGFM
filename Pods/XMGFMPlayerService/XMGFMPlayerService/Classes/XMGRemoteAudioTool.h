//
//  XMGRemoteAudioTool.h
//  Pods
//
//  Created by 王顺子 on 16/10/28.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AudioPlaying,
    AudioPause,
    AudioLoading,
} AudioState;


@interface XMGRemoteAudioTool : NSObject


- (void)playWithURL:(NSURL *)url withStateBlock: (void(^)(AudioState state))stateBlock;

@property (nonatomic, assign) AudioState state;

- (void)playCurrentAudio;
- (void)pauseCurrentAudio;

- (float)currentPlayTime;
- (float)currentTotalTime;

- (void)seekBack: (unsigned int)time;
- (void)seekFast: (unsigned int)time;
- (void)seekProgress: (float)progress;

- (void)changeRate: (float)rate;


@end
