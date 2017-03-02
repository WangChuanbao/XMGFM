//
//  XMGSetValueTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSetValueTool.h"
#import "XMGDownLoadVoiceModel.h"
#import "XMGDownLoadAlbumModel.h"

#import "XMGDownLoadVoiceCell.h"
#import "XMGDownLoadAlbumCell.h"
#import "XMGTodayFireVoiceCell.h"

#import "XMGDownLoadDataTool.h"

#import "XMGDownLoadService.h"
#import "UIButton+WebCache.h"
#import "UIImageView+XMGExtension.h"
#import "XMGPlayerService.h"





@implementation XMGSetValueTool

+ (id)setModel: (id)model toCell:(UITableViewCell *)cell {


    // 下载声音模型
    if ([model isKindOfClass:[XMGDownLoadVoiceModel class]]) {
        XMGDownLoadVoiceModel *modelR = (XMGDownLoadVoiceModel *)model;

        if ([cell isKindOfClass:[XMGDownLoadVoiceCell class]]) {
           XMGDownLoadVoiceCell *cellR = (XMGDownLoadVoiceCell *)cell;

            cellR.clickBlock = modelR.clickBlock;
            cellR.downLoadBlock = modelR.downLoadBlock;
            cellR.deleteBlock = modelR.deleteBlock;
            cellR.trackID = modelR.trackId;


            // 赋值
            [cellR.playOrPauseBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:modelR.coverSmall]  forState:UIControlStateNormal];

            cellR.voiceTitleLabel.text = modelR.title;
            cellR.voiceAuthorLabel.text = [NSString stringWithFormat:@"by %@", modelR.nickname];
            [cellR.voicePlayCountBtn setTitle:[NSString stringWithFormat:@"%zd", modelR.playtimes] forState:UIControlStateNormal];
            [cellR.voiceCommentBtn setTitle:[NSString stringWithFormat:@"%zd", modelR.comments] forState:UIControlStateNormal];
            [cellR.voiceDurationBtn setTitle:[NSString stringWithFormat:@"%zd", modelR.duration] forState:UIControlStateNormal];

            cellR.voiceFileSizeLabel.text = modelR.fileFormatSize;
            cellR.voicePlayProgressLabel.text = @"";


            cellR.downLoadProgressV.progress = modelR.downLoadProgress;
            cellR.progressLabel.text = [NSString stringWithFormat:@"%@/%@", modelR.downLoadFormatSize , modelR.fileFormatSize];

            if (modelR.isDownLoaded) {
                cellR.progressBackView.hidden = YES;
                cellR.playURL = [[XMGDownLoadDataTool shareInstance] getCachePathWithWithURL:modelR.downloadUrl orTrackID:modelR.trackId];
            }else {
                cellR.playURL = [NSURL URLWithString:modelR.playPathAacv164];
                cellR.progressBackView.hidden = NO;
                if (modelR.isDownLoading) {
                    cellR.downLoadOrPauseBtn.selected = YES;
                }else {
                    cellR.downLoadOrPauseBtn.selected = NO;
                }
            }


            // 判断是否正在播放
            if ([[XMGPlayerService shareInstance].currentPlayURL isEqual:cellR.playURL] || [XMGDownLoadDataTool shareInstance].currentTrackID == cellR.trackID) {
                cellR.playOrPauseBtn.selected = ([XMGPlayerService shareInstance].state == AudioPlaying);
            }else {
                cellR.playOrPauseBtn.selected = NO;
            }

        }


        if ([cell isKindOfClass:[XMGTodayFireVoiceCell class]]) {
            // 赋值
            XMGTodayFireVoiceCell *cellR = (XMGTodayFireVoiceCell *)cell;
            cellR.voiceTitleLabel.text = modelR.title;
            cellR.voiceAuthorLabel.text = [NSString stringWithFormat:@"by %@", modelR.nickname];

            [cellR.playOrPauseBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:modelR.coverSmall]  forState:UIControlStateNormal];
            cellR.sortNumLabel.text = [NSString stringWithFormat:@"%zd", modelR.sortNum];


            // 判断, 是否存在下载文件
            if ([[XMGDownLoadDataTool shareInstance] isDownLoadedWithURL:modelR.downloadUrl orTrackID:modelR.trackId]) {
                cellR.downLoadState = XMGCellDownLoadStateDownLoaded;
                cellR.playURL = [[XMGDownLoadDataTool shareInstance] getCachePathWithWithURL:modelR.downloadUrl orTrackID:modelR.trackId];
            }else {
                cellR.downLoadState = XMGCellDownLoadStateWait;
                cellR.playURL = [NSURL URLWithString:modelR.playPathAacv164];
            }



            cellR.clickBlock = modelR.clickBlock;


            // 判断是否正在播放
            if ([[XMGPlayerService shareInstance].currentPlayURL isEqual:cellR.playURL] || [XMGDownLoadDataTool shareInstance].currentTrackID == cellR.trackID) {
                cellR.playOrPauseBtn.selected = ([XMGPlayerService shareInstance].state == AudioPlaying);
            }else {
                cellR.playOrPauseBtn.selected = NO;
            }
            cellR.trackID = modelR.trackId;

        }


    }


    if ([model isKindOfClass:[XMGDownLoadAlbumModel class]]) {
        XMGDownLoadAlbumModel *modelR = (XMGDownLoadAlbumModel *)model;
        if ([cell isKindOfClass:[XMGDownLoadAlbumCell class]]) {
            XMGDownLoadAlbumCell *cellR = (XMGDownLoadAlbumCell *)cell;

            // 赋值
            [cellR.albumImageView setURLImageWithURL:[NSURL URLWithString:modelR.albumCoverMiddle] progress:nil complete:nil];
            cellR.albumTitleLabel.text = modelR.albumTitle;
            [cellR.albumPartsBtn setTitle:[NSString stringWithFormat:@"%zd", modelR.trackCount] forState:UIControlStateNormal];
            cellR.albumAuthorLabel.text = [NSString stringWithFormat:@"by %@", modelR.nickname];
            [cellR.albumPartsSizeBtn setTitle:modelR.fileFormatSize forState:UIControlStateNormal];

            cellR.deleteBlock = modelR.deleteBlock;

        }
    }



    return nil;
}


@end
