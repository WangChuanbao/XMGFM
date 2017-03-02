//
//  XMGAudioTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecordTool.h"
#import "Sington.h"

@interface XMGRecordTool()

@property (nonatomic, copy) Success block;
@property (nonatomic, copy) UpdatePower updatePowerBlock;


@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

@property (nonatomic, weak) NSTimer *updatePowerTimer;

@end

@implementation XMGRecordTool
singtonImplement(XMGRecordTool)


-(AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        // 1. 确定录音存放的位置
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"temp.m4a"];
//        NSString *path = @"/Users/wangshunzi/Desktop/record/temp.m4a";
        _recordPath = path;
        NSURL *url = [NSURL URLWithString:path];


        // 2. 设置录音参数
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
        // 设置编码格式
        [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
        // 采样率
        [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];
        // 通道数
        [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
        //音频质量,采样质量
        [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];

        // 3. 创建录音对象
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:nil];

        _audioRecorder.meteringEnabled = YES;
    }
    return _audioRecorder;
}

/**
 *  开始录音
 */
- (void)beginRecord {
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
}
/**
 *  结束录音
 */
- (void)endRecord {
    [self.audioRecorder stop];
}

/**
 *  暂停录音
 */
- (void)pauseRecord {
    [self.audioRecorder pause];
}

/**
 *  删除录音
 */
- (void)deleteRecord {
    [self.audioRecorder stop];
    [self.audioRecorder deleteRecording];
}

/**
 *  重新录音
 */
- (void)reRecord {

    self.audioRecorder = nil;
    [self beginRecord];

}


/**
 *  刷新能量值
 *
 *  @param timeInterval 时间间隔, 每隔多少秒获取一次能量值
 *  @param resultBlock  用于接收, 数值的block
 */
- (void)beginRefreshPowerWithTimeInterval:(NSTimeInterval)timeInterval resultBlock:(void(^)(float power))resultBlock {

    self.updatePowerBlock = resultBlock;
    NSTimer *timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(updatePower) userInfo:nil repeats:YES];
    self.updatePowerTimer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

- (void)endRefreshPower {
    [self.updatePowerTimer invalidate];
    self.updatePowerTimer = nil;
}

- (void)updatePower {
    [self.audioRecorder updateMeters];
    float power = [self.audioRecorder peakPowerForChannel:0];
    self.updatePowerBlock(power + 160);
}

- (float)getPeakPowerOnce {

    [self.audioRecorder updateMeters];
    float power = [self.audioRecorder peakPowerForChannel:0];

    // 音量级别(0...1)
    float   level;                // The linear 0.0 .. 1.0 value we need.
    float   minDecibels = -60.0f; // Or use -60dB, which I measured in a silent room.
    if (power < minDecibels) {
        level = 0.0f;
    } else if (power >= 0.0f)
    {
        level = 1.0f;
    }else
    {

        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * power);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        level = powf(adjAmp, 1.0f / root);
    }

    return level * 100;

}







/**
 *  录音剪切 支持音频:m4a
 *
 *  @param exportPath 输出路径
 *  @param filePath   输入路径
 *  @param startTime  开始时间
 *  @param endTime    结束时间
 *  @param handle     处理回调代码块
 */
- (void)exportPath:(NSString *)exportPath
      withFilePath:(NSString *)filePath
     withStartTime:(int64_t)startTime
       withEndTime:(int64_t)endTime
         withBlock:(Success)handle
{
    _block = handle;

    NSString *presetName;
    NSString *outputFileType;

    if ([filePath.lastPathComponent containsString:@"m4a"]){

        presetName = AVAssetExportPresetAppleM4A;
        outputFileType = AVFileTypeAppleM4A;

    }else{

        _block(NO);
        return;
    }

    // 1.拿到预处理音频文件
    NSURL *songURL = [NSURL fileURLWithPath:filePath];
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:songURL options:nil];

    // 2.创建新的音频文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
    }

    NSError *assetError;
    NSURL *exportURL = [NSURL fileURLWithPath:exportPath];
    [AVAssetWriter assetWriterWithURL:exportURL
                                                          fileType:AVFileTypeCoreAudioFormat
                                                             error:&assetError];
    if (assetError) {
        NSLog (@"创建文件失败 error: %@", assetError);
        _block(NO);
    }


    // 3.创建音频输出会话
    //
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:songAsset
                                                                            presetName:presetName];

    CMTime _startTime = CMTimeMake(startTime, 1);
    CMTime _stopTime = CMTimeMake(endTime, 1);
    CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(_startTime, _stopTime);

    // 4.设置音频输出会话并执行
    exportSession.outputURL = [NSURL fileURLWithPath:exportPath]; // output path
    exportSession.outputFileType = outputFileType;            // output file type AVFileTypeAppleM4A
    exportSession.timeRange = exportTimeRange;                    // trim time range
    [exportSession exportAsynchronouslyWithCompletionHandler:^{

        if (AVAssetExportSessionStatusCompleted == exportSession.status) {

            // 删除老文件
            NSLog(@"成功");
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            _block(YES);

        } else if (AVAssetExportSessionStatusFailed == exportSession.status) {

            NSLog(@"失败");
            _block(NO);

        } else {

            NSLog(@"Export Session Status: %ld", (long)exportSession.status);
            _block(NO);
        }
    }];

}



@end
