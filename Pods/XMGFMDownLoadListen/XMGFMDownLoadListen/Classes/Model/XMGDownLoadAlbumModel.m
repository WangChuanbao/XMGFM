//
//  XMGDownLoadAlbumModel.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadAlbumModel.h"
#import "XMGFileTool.h"

@implementation XMGDownLoadAlbumModel

-(NSString *)fileFormatSize
{

    float downloadSize = 0;
    for (XMGDownLoadVoiceModel *voiceM in self.voiceMs) {
        downloadSize += voiceM.downloadSize;
    }

    float size = [XMGFileTool calculateFileSizeInUnit:downloadSize];
    NSString *unit = [XMGFileTool calculateUnit:downloadSize];
    return [NSString stringWithFormat:@"%.1f %@", size, unit];

    
}

-(NSMutableArray<XMGDownLoadVoiceModel *> *)voiceMs
{
    if (_voiceMs == nil) {
        _voiceMs = [NSMutableArray array];
    }
    return _voiceMs;
}

@end
