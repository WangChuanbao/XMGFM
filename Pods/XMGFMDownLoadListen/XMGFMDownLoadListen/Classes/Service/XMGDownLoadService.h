//
//  XMGDownLoadService.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMGDownLoadVoiceModel.h"

#define kDownLoadStateChangeNotification @"downLoadStateChangeNotification"

@interface XMGDownLoadService : NSObject

+ (instancetype)shareInstance;

/**
 *  根据给定的音频模型, 下载对应的数据
 *
 *  @param downLoadVoiceM 音频数据模型
 */
+ (void)downLoadVoiceM:(XMGDownLoadVoiceModel *)downLoadVoiceM;
/**
 *  根据给定的音频模型, 暂停对应的数据
 *
 *  @param downLoadVoiceM 音频数据模型
 */
+ (void)pauseVoiceM:(XMGDownLoadVoiceModel *)downLoadVoiceM;
/**
 *  根据给定的音频模型, 停止对应的数据
 *
 *  @param downLoadVoiceM 音频数据模型
 */
+ (void)stopVoiceM:(XMGDownLoadVoiceModel *)downLoadVoiceM;


/**
 *  验证, 是否已经下载
 *
 *  @param filePath 文件路径
 *
 *  @return 是否已经下载
 */
+ (BOOL)isExsists:(NSString *)filePath;


@end
