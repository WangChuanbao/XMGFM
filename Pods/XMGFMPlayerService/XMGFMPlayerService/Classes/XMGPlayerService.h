//
//  XMGPlayerService.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGAudioTool.h"
#import "XMGRemoteAudioTool.h"

@interface XMGPlayerService : NSObject

+ (instancetype)shareInstance;

- (void)playWithURL:(NSURL *)url withStateBlock: (void(^)(AudioState state))stateBlock;

@property (nonatomic, assign) AudioState state;
@property (nonatomic, copy) NSURL *currentPlayURL;

- (void)playCurrentAudio;
- (void)pauseCurrentAudio;

- (float)currentPlayTime;
- (float)currentTotalTime;

- (void)seekBack: (unsigned int)time;
- (void)seekFast: (unsigned int)time;
- (void)seekProgress: (float)progress;

- (void)changeRate: (float)rate;


@end
