//
//  XMGDownLoadService.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadService.h"
#import "XMGDownLoadDataTool.h"
#import "Sington.h"
#import "XMGDownLoadManager.h"

@interface XMGDownLoadService()


@end

@implementation XMGDownLoadService

singtonImplement(XMGDownLoadService);


+ (void)downLoadVoiceM:(XMGDownLoadVoiceModel *)downLoadVoiceM {

    // 1. 创建本地缓存, 记录已经下载的数据记录
    [[XMGDownLoadDataTool shareInstance] saveDownLoadVoiceModel:downLoadVoiceM];


    // 2. 执行下载操作
    [[XMGDownLoadManager shareInstance] downLoadWithURL:[NSURL URLWithString:downLoadVoiceM.downloadUrl] progressBlock:^(float progress) {
        NSLog(@"progress--%f", progress);

    } successBlock:^(NSString *fileFullPath) {
        NSLog(@"path - %@", fileFullPath);
        [[XMGDownLoadDataTool shareInstance] setVoiceMDownLoaded:YES withURL:downLoadVoiceM.downloadUrl];

        // 当下载状态发生变化时, 告知外界, 外界可以更新显示列表
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownLoadStateChangeNotification object:nil];

    } failBlock:^{
        NSLog(@"下载失败");
    }];




}

+ (void)pauseVoiceM:(XMGDownLoadVoiceModel *)downLoadVoiceM {

    [[XMGDownLoadManager shareInstance] pauseDownLoadWithURL:[NSURL URLWithString:downLoadVoiceM.downloadUrl]];

}

+ (void)stopVoiceM:(XMGDownLoadVoiceModel *)downLoadVoiceM
{

 [[XMGDownLoadManager shareInstance] cancelDownLoadWithURL:[NSURL URLWithString:downLoadVoiceM.downloadUrl]];

}


+ (BOOL)isExsists:(NSString *)filePath {

//    TYDownloadSessionManager *manager = [TYDownloadSessionManager manager];
//
//    // 查找对应的下载模型
//    TYDownloadModel *model = [manager downLoadingModelForURLString:filePath];
//
//    return [manager isDownloadCompletedWithDownloadModel:model];

    return YES;
}

@end
