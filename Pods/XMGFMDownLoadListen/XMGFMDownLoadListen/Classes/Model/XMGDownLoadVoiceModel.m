//
//  XMGDownLoadVoiceModel.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadVoiceModel.h"
#import "XMGFileTool.h"
#import "XMGDownLoadManager.h"


@implementation XMGDownLoadVoiceModel


- (float)downLoadProgress {
    float progress = [[XMGDownLoadManager shareInstance] loaderWithURL:[NSURL URLWithString:self.downloadUrl]].progress;
    if (progress == 0.0) {
        progress = 1.0 * [XMGDownLoader cacheFileSizeWithURL:[NSURL URLWithString:self.downloadUrl]] / self.downloadSize;
    }
    return progress;
}

- (BOOL)isDownLoading {
    return  [[XMGDownLoadManager shareInstance] loaderWithURL:[NSURL URLWithString:self.downloadUrl]].isDowning;
}


-(NSString *)fileFormatSize
{
    float size = [XMGFileTool calculateFileSizeInUnit:self.downloadSize];
    NSString *unit = [XMGFileTool calculateUnit:self.downloadSize];
    return [NSString stringWithFormat:@"%.1f %@", size, unit];

}

-(NSString *)downLoadFormatSize
{
    float size = [XMGFileTool calculateFileSizeInUnit:self.downloadSize * self.downLoadProgress];
    NSString *unit = [XMGFileTool calculateUnit:self.downloadSize * self.downLoadProgress];
    return [NSString stringWithFormat:@"%.1f %@", size, unit];
}



@end
