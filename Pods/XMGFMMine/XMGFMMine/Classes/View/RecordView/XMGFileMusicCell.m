//
//  XMGFileMusicCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFileMusicCell.h"
#import <AVFoundation/AVFoundation.h>
#import "XMGMusicTool.h"

@interface XMGFileMusicCell ()

@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation XMGFileMusicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
}

+ (instancetype)fileMusicCell {

    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGFileMusicCell" owner:nil options:nil] firstObject];

}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    //设置名称
    NSString *file = filePath.lastPathComponent;
    NSInteger index = file.length - 4;
    file = [file substringToIndex:index];
    self.fileName.text = file;
    
    //获取播放时长
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSInteger duration = (NSInteger)[self durationWithVideo:url];
    NSInteger minutes = duration / 60;
    NSInteger seconds = duration % 60;
    //显示时间
    [self.durationLabel setText:[NSString stringWithFormat:@"%02zd:%02zd",minutes, seconds]];
    
}

//播放点击
- (IBAction)playBtnClick:(UIButton *)btn {
    
    if (self.playBtnTask) {
        self.playBtnTask(self.indexPath);
    }

    if (btn.selected) {
        //播放
        [[XMGMusicTool shareInstance] playAudioWithPath:self.filePath];
    }else  {
        //停止
        [[XMGMusicTool shareInstance] stopCurrentAudio];
    }
    
    
    
}

//添加按钮点击
- (IBAction)addBtnClick:(id)sender {

}

//获取音频播放时长
- (long long)durationWithVideo:(NSURL *)videoUrl{
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts]; // 初始化视频媒体文件
    long long second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
    return second;
}


@end
