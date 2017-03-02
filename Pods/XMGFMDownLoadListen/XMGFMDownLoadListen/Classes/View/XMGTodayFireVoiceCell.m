//
//  XMGTodayFireVoiceCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceCell.h"
#import "UIView+XMGLayout.h"
#import "XMGPlayerService.h"
#import "DownLoadAPIDefine.h"
#import "XMGDownLoadDataTool.h"

@implementation XMGTodayFireVoiceCell


static NSString *const cellID = @"todayFireVoice";

+ (instancetype)cellWithTableView:(UITableView *)tableView {

    XMGTodayFireVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {

        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGTodayFireVoiceCell" owner:nil options:nil] firstObject];
        [cell addObserver:cell forKeyPath:@"sortNumLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }

    return cell;
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"sortNumLabel.text"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)downLoad {

    if (self.clickBlock && self.downLoadState == XMGCellDownLoadStateWait) {
        self.clickBlock();
        self.downLoadState = XMGCellDownLoadStateDownLoaded;
    }

}

-(void)setDownLoadState:(XMGCellDownLoadState)downLoadState
{
    _downLoadState = downLoadState;

    NSBundle *_currentBundle = [NSBundle bundleForClass:[self class]];

    NSString *bundleName = [[_currentBundle bundleIdentifier].pathExtension stringByAppendingString:@".bundle"];

    NSString *normalPath = [_currentBundle pathForResource:@"cell_download@3x.png" ofType:nil inDirectory:bundleName];

    NSString *selectedPath = [_currentBundle pathForResource:@"cell_download_loading@3x.png" ofType:nil inDirectory:bundleName];

    NSString *downLoadedPath = [_currentBundle pathForResource:@"cell_downloaded@3x.png" ofType:nil inDirectory:bundleName];

    if (downLoadState == XMGCellDownLoadStateWait) {
        [self.downLoadBtn.imageView.layer removeAllAnimations];
        [self.downLoadBtn setImage:[UIImage imageWithContentsOfFile:normalPath] forState:UIControlStateNormal];

    }else if (downLoadState == XMGCellDownLoadStateDownLoading) {
        [self.downLoadBtn setImage:[UIImage imageWithContentsOfFile:selectedPath] forState:UIControlStateNormal];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = @(0);
        animation.toValue = @(M_PI * 2.0);
        animation.duration = 10;
        [self.downLoadBtn.imageView.layer addAnimation:animation forKey:@"rotation"];
    } else if (downLoadState == XMGCellDownLoadStateDownLoaded) {

        [self.downLoadBtn.imageView.layer removeAllAnimations];
        [self.downLoadBtn setImage:[UIImage imageWithContentsOfFile:downLoadedPath] forState:UIControlStateNormal];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.autoresizingMask = UIViewAutoresizingNone;

    self.playOrPauseBtn.layer.masksToBounds = YES;
    self.playOrPauseBtn.layer.borderWidth = 3;
    self.playOrPauseBtn.layer.borderColor = [[UIColor whiteColor] CGColor];


    // 监听播放状态通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChange:) name:@"playState" object:nil];

}

-(void)playStateChange:(NSNotification *)notification {

    BOOL isPlaying = [notification.object boolValue];

    if ([[XMGPlayerService shareInstance].currentPlayURL isEqual:self.playURL] || [XMGDownLoadDataTool shareInstance].currentTrackID == self.trackID) {
        self.playOrPauseBtn.selected = isPlaying;
    }else {
        self.playOrPauseBtn.selected = NO;
    }


}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.playOrPauseBtn.layer.cornerRadius = self.playOrPauseBtn.width * 0.5;
}

- (IBAction)playOrPause:(UIButton *)sender {

    sender.selected = !sender.selected;

     [[NSNotificationCenter defaultCenter] postNotificationName:@"playImage" object:[sender backgroundImageForState:UIControlStateNormal]];


    if (sender.selected) {
        kLoadTrackInfo(@(self.trackID))
        [[XMGPlayerService shareInstance] playWithURL:self.playURL withStateBlock:^(AudioState state) {
            if (state == AudioPlaying) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playState" object:@(YES)];
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"playState" object:@(NO)];
            }
            
        }];
    }else {
        [[XMGPlayerService shareInstance] pauseCurrentAudio];
    }




}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"sortNumLabel.text"]) {
        NSInteger sort = [change[@"new"] integerValue];
        if (sort == 1) {
            self.sortNumLabel.textColor = [UIColor redColor];
        }else if (sort == 2) {
            self.sortNumLabel.textColor = [UIColor orangeColor];
        }else if (sort == 3) {
            self.sortNumLabel.textColor = [UIColor greenColor];
        }else {
            self.sortNumLabel.textColor = [UIColor grayColor];
        }

        return;
    }

}

@end
