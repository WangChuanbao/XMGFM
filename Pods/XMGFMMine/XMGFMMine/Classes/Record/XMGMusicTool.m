//
//  XMGMusicTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMusicTool.h"
#import "Sington.h"

@interface XMGMusicTool()<AVAudioPlayerDelegate>

/** 音乐播放器 */
@property (nonatomic ,strong) AVAudioPlayer *player;

@end

@implementation XMGMusicTool

singtonImplement(XMGMusicTool)


-(instancetype)init
{

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

    return [super init];
}

/**
 *  播放歌曲
 */
- (AVAudioPlayer *)playAudioWith:(NSString *)audioName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:audioName withExtension:nil];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play];
    return self.player;
}
/**
 *  根据路径播放音乐
 */
- (AVAudioPlayer *)playAudioWithPath:(NSString *)pathName
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:pathName];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
//    NSURL *url = [NSURL fileURLWithPath:pathName];
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    [self.player play];
    return self.player;
}


/**
 *  恢复当前歌曲
 */
- (void)resumeCurrentAudio
{
    [self.player play];
}

/**
 *  暂停歌曲
 */
- (void)pauseCurrentAudio
{
    [self.player pause];
}

/**
 *  停止歌曲
 */
- (void)stopCurrentAudio
{
    [self.player stop];
}

-(void)setVolumn:(float)volumn
{
    self.player.volume = volumn;
}

-(float)volumn
{
    return self.player.volume;
}

-(float)progress {
    return self.player.currentTime / self.player.duration;
}


#pragma mark - 音频播放器代理方法

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

    NSLog(@"播放完成");

    // 发送播放完成的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayFinishNotification object:nil];

}



@end
