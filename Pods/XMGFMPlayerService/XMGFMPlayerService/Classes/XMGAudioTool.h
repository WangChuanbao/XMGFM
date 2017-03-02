//
//  XMGAudioTool.h
//  01-QQ音乐
//
//  Created by xiaomage on 15/11/4.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XMGAudioTool : NSObject

@property (nonatomic, assign) BOOL isPlaying;


- (void)playAudioWithPath:(NSURL *)filePath stateBlock:(void(^)(BOOL isPlaying))stateBlock;


- (void)playCurrentAudio;
- (void)pauseCurrentAudio;

- (float)currentPlayTime;
- (float)currentTotalTime;

- (void)seekBack: (unsigned int)time;
- (void)seekFast: (unsigned int)time;
- (void)seekProgress: (float)progress;

- (void)changeRate: (float)rate;


@end
