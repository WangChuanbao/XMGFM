//
//  XMGMusicTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


/**
 *  当播放完成之后, 会发送播放完成的通知
 */
#define kPlayFinishNotification @"playFinishNotification"


@interface XMGMusicTool : NSObject
+ (instancetype)shareInstance;
/**
 *  播放歌曲
 */
- (AVAudioPlayer *)playAudioWith:(NSString *)audioName;

/**
 *  根据路径播放音乐
 */
- (AVAudioPlayer *)playAudioWithPath:(NSString *)pathName;

/**
 *  恢复当前歌曲
 */
- (void)resumeCurrentAudio;

/**
 *  暂停歌曲
 */
- (void)pauseCurrentAudio;

/**
 *  停止歌曲
 */
- (void)stopCurrentAudio;

/**
 *  声音
 */
@property (nonatomic, assign) float volumn;

/**
 *  播放进度
 */
@property (nonatomic, assign, readonly) float progress;




@end
