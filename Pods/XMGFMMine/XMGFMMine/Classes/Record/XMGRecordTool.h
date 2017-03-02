//
//  XMGAudioTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LameTool.h"


typedef void(^Success)(BOOL ret);
typedef void(^UpdatePower)(float power);
#define KFILESIZE (1 * 1024 * 1024)

@interface XMGRecordTool : NSObject
+ (instancetype)shareInstance;


/**
 *  开始录音
 */
- (void)beginRecord;
/**
 *  结束录音
 */
- (void)endRecord;
/**
 *  暂停录音
 */
- (void)pauseRecord;

/**
 *  删除录音
 */
- (void)deleteRecord;

/**
 *  重新录音
 */
- (void)reRecord;

/**
 *  刷新能量值
 *
 *  @param timeInterval 时间间隔, 每隔多少秒获取一次能量值
 *  @param resultBlock  用于接收, 数值的block
 */
- (void)beginRefreshPowerWithTimeInterval:(NSTimeInterval)timeInterval resultBlock:(UpdatePower)resultBlock;
/**
 *  结束刷新能量值
 */
- (void)endRefreshPower;

/**
 *  获取单次能量值
 *
 *  @return 单次值
 */
- (float)getPeakPowerOnce;


/**
 *  录音文件路径
 */
@property (nonatomic, readonly) NSString *recordPath;




#pragma mark - 编辑录音


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
     withStartTime:(CMTimeValue)startTime
       withEndTime:(CMTimeValue)endTime
         withBlock:(Success)handle;

@end
