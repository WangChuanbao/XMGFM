//
//  XMGPlayerPane.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayerPane.h"
#import "XMGPlayerService.h"
#import "XMGPlayListSheetView.h"
//#import "XMGFriendsDetailVC.h"
//#import "XMGFriendListM.h"
//#import "XMGDownLoadDataTool.h"
#import "XMGPlayerVC.h"
#import "XMGDanmuBackView.h"
#import "XMGDanmuView.h"
#import "XMGPlayerDataTool.h"
#import "UIView+XMGLayout.h"
#import "Base.h"
#import "UIImageView+XMGExtension.h"

@interface XMGPlayerPane ()<XMGDanmuBackViewRequiredProtocol>
{
    NSInteger _controlPaneCloseSec;
}


@property (strong, nonatomic) XMGDanmuBackView *danmuBackView;


@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *VIcon;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

@property (weak, nonatomic) IBOutlet UIButton *playListBtn;

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;


@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@property (weak, nonatomic) IBOutlet UILabel *costTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

// 控制面板
@property (weak, nonatomic) IBOutlet UIView *controllerPane;


@property (nonatomic, weak) NSTimer *updateTimer;

// 速率切换
@property (nonatomic, strong) NSArray <NSString *> *rateStrs;
@property (nonatomic, strong) NSArray *rate;
@property (nonatomic, assign) NSInteger rateIndex;

@property (nonatomic, strong) UIWindow *playWindow;
@property (nonatomic, strong) XMGPlayListSheetView *playListView;

@end



@implementation XMGPlayerPane

-(XMGDanmuBackView *)danmuBackView
{
    if (_danmuBackView == nil) {
        _danmuBackView = [[XMGDanmuBackView alloc] initWithFrame:self.middleImageView.bounds];
        _danmuBackView.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:0.5];
        _danmuBackView.requireDelegate = self;
    }
    return _danmuBackView;
}


-(XMGPlayListSheetView *)playListView
{
    if (_playListView == nil) {

        _playListView = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGPlayListSheetView" owner:nil options:nil].firstObject;

    }
    return _playListView;
}

-(UIWindow *)playWindow
{
    if (_playWindow == nil) {
        _playWindow= [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.playListView.frame = CGRectMake(0, 0, kScreenWidth, 400);
        [_playWindow addSubview:self.playListView];
        _playWindow.windowLevel = UIWindowLevelAlert + 1;
        [_playWindow makeKeyAndVisible];
    }
    return _playWindow;
}

-(void)setRateIndex:(NSInteger)rateIndex
{
    if (rateIndex < 0) {
        rateIndex = self.rate.count - 1;
    }
    if (rateIndex > (self.rate.count - 1)) {
        rateIndex = 0;
    }
    _rateIndex = rateIndex;
}

-(NSArray *)rate
{
    if (_rate == nil) {
        _rate = @[@1.0, @1.5, @2.0, @0.5];
    }
    return _rate;
}

-(NSArray<NSString *> *)rateStrs
{
    if (_rateStrs == nil) {
        _rateStrs = @[@"x 1.0倍", @"x 1.5倍", @"x 2.0倍", @"x 0.5倍"];
    }
    return _rateStrs;
}

- (NSTimer *)updateTimer {
    if (_updateTimer == nil) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil  repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _updateTimer = timer;
    }
    return _updateTimer;
}

-(void)awakeFromNib {
    [super awakeFromNib];

    self.autoresizingMask = UIViewAutoresizingNone;

    self.headIcon.layer.cornerRadius = self.radius;
    self.headIcon.layer.masksToBounds = YES;



    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"player_slider_playback_thumb@2x.png" ofType:nil inDirectory:@"XMGFMPlayer.bundle"];

    [self.progressSlider setThumbImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    [self updateTimer];
}

-(void)setUserInfoM:(XMGUserInfoModel *)userInfoM
{
    _userInfoM = userInfoM;
    NSURL *headURL = [NSURL URLWithString:userInfoM.smallLogo];
    [self.headIcon setURLImageWithURL:headURL placeHoldImage:nil isCircle:NO];
    self.titleLabel.text = userInfoM.nickname;
    self.VIcon.hidden = !userInfoM.isVerified;

    
}


- (void)update {

    float currentTime = [XMGPlayerService shareInstance].currentPlayTime;
    float totalTime = [XMGPlayerService shareInstance].currentTotalTime;

    self.progressSlider.value = currentTime / totalTime;

    self.costTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", (int)currentTime / 60, (int)currentTime % 60];
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", (int)totalTime / 60, (int)totalTime % 60];


    // 刷新控制面板显示状态
    _controlPaneCloseSec -= 1;
    if (_controlPaneCloseSec <= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.controllerPane.alpha = 1;
        } completion:^(BOOL finished) {
            self.controllerPane.hidden = YES;
        }];

    }

    static int page = -1;
    if (page != ((int)currentTime / 10)) {
        page = ((int)currentTime / 10);


        [[XMGPlayerDataTool shareInstance] getDanMuMsWithTrackId:self.trackM.trackId result:^(NSMutableArray<XMGDanmuModel *> *danmuMs, BOOL isNewData) {
            // 代表加载的是新数据
            if (isNewData) {
                [self.danmuBackView clear];
//                self.danmuBackView.danmuMs = self.danmuBackView.danmuMs;
            }
            [self.danmuBackView.danmuMs addObjectsFromArray:danmuMs];

        }];

    }


    // 刷新播放按钮的状态
//    self.playOrPauseBtn.selected = [[XMGPlayerService shareInstance] isPlaying];


    // 刷新速率按钮显示状态
//    float rateValue = [self.rate[self.rateIndex] floatValue];
//    [[XMGPlayerService shareInstance] changeRate:rateValue];

}




-(void)setTrackM:(XMGTrackInfoModel *)trackM
{
    if (trackM.trackId == _trackM.trackId) {
        [[XMGPlayerService shareInstance] playCurrentAudio];
        return;
    }
    _trackM = trackM;




    [self.playListView setAlbumID:trackM.albumId trackID:trackM.trackId];
    self.playListView.clickItemBlock = ^(XMGTrackInfoModel *trackM) {
        [XMGPlayerVC shareInstanceWithAlbumId:trackM.albumId trackUid:trackM.trackId isUseCache:NO];
    };


    NSURL *url = [NSURL URLWithString:[trackM.images firstObject]];
    UIImage *image = self.middleImageView.image;
    [self.middleImageView setURLImageWithURL:url progress:nil complete:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playImage" object:self.middleImageView.image];
    }];

    // 先检测本地, 是否有对应的缓存信息, 如果有, 直接加载, 如果没有, 则从网络加载
//    NSString *filePath = [XMGDownLoadDataTool getLocalFilePathWithID:trackM.trackId];

    // 缓存路径 ()


    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:self.trackM.playPathAacv164.lastPathComponent];

    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        filePath = self.trackM.playPathAacv164;
    }

//    filePath = @"http://live.xmcdn.com/live/999/64.m3u8";

    if ([filePath containsString:@"m3u8"]) {
        // 广播
//        [[XMGRadioService shareInstance] setURL:filePath];
//        [[XMGRadioService shareInstance] playCurrentAudio];
    }else {


        [[XMGPlayerService shareInstance] playWithURL:[NSURL URLWithString:filePath] withStateBlock:^(AudioState state) {
            switch (state) {
                case AudioPlaying:
                    self.playOrPauseBtn.selected = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"playState" object:@(YES)];
                    break;
                case AudioPause:
                    self.playOrPauseBtn.selected = NO;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"playState" object:@(NO)];
                default:
                    break;
            }
        }];

    }




}

- (IBAction)clickUserMessage:(UIButton *)sender {

//    XMGFriendsDetailVC *friendDetailVC = [[XMGFriendsDetailVC alloc] init];
//
//    XMGFriendListM *frindsM = [[XMGFriendListM alloc] init];
//    friendDetailVC.frindsM = frindsM;
//    frindsM.nickname = self.userInfoM.nickname;
//    frindsM.personDescribe = self.userInfoM.personDescribe;
//    frindsM.followers = self.userInfoM.followers;
//    frindsM.followings = 99;
//    frindsM.tracks = self.userInfoM.tracks;
//    frindsM.smallLogo = self.userInfoM.smallLogo;
//
//    [self.currentViewController.navigationController pushViewController:friendDetailVC animated:YES];

}



- (IBAction)sliderDown {

    [self.updateTimer setFireDate:[NSDate distantFuture]];
}

- (IBAction)sliderUpInside:(UISlider *)slider {

    [[XMGPlayerService shareInstance] seekProgress:slider.value];

    [self.updateTimer setFireDate:[NSDate distantPast]];

}
- (IBAction)valueChange:(UISlider *)sender {

    float currentTime = sender.value * [[XMGPlayerService shareInstance] currentTotalTime];

    self.costTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", (int)currentTime / 60, (int)currentTime % 60];

}


- (IBAction)playOrPause:(UIButton *)sender {

    sender.selected = !sender.selected;

    if (sender.selected) {

        NSLog(@"select");
        [[XMGPlayerService shareInstance] playCurrentAudio];
        [self.danmuBackView resume];

    }else {
        NSLog(@"deselect");
        [[XMGPlayerService shareInstance] pauseCurrentAudio];
        [self.danmuBackView pause];
    }


}


- (IBAction)preAudio {

    // 上一首
    XMGTrackInfoModel *trackM = self.playListView.trackInfoMs[self.playListView.currentIndex --];
    [XMGPlayerVC shareInstanceWithAlbumId:trackM.albumId trackUid:trackM.trackId isUseCache:NO];
}

- (IBAction)nextAudio {

    // 下一首
    XMGTrackInfoModel *trackM = self.playListView.trackInfoMs[self.playListView.currentIndex ++];
    [XMGPlayerVC shareInstanceWithAlbumId:trackM.albumId trackUid:trackM.trackId isUseCache:NO];

}

- (IBAction)danmu: (UIButton *)btn {

    btn.selected = !btn.selected;

    if (btn.selected) {

        self.danmuBackView.frame = self.middleImageView.bounds;
        [self.middleImageView addSubview:self.danmuBackView];
        self.danmuBackView.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.danmuBackView.alpha = 1;
        }];


    }else {
        self.danmuBackView.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            self.danmuBackView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.danmuBackView removeFromSuperview];
        }];
    }



}

- (IBAction)seekBack {

    [[XMGPlayerService shareInstance] seekBack:15];
    _controlPaneCloseSec = 5;

}
- (IBAction)seekFast {

    [[XMGPlayerService shareInstance] seekFast:15];
    _controlPaneCloseSec = 5;

}
- (IBAction)changeRate:(UIButton *)sender {

    self.rateIndex ++;
    [sender setTitle:self.rateStrs[self.rateIndex] forState:UIControlStateNormal];
    float rateValue = [self.rate[self.rateIndex] floatValue];
    [[XMGPlayerService shareInstance] changeRate:rateValue];
    _controlPaneCloseSec = 5;
    
}
- (IBAction)swip:(UISwipeGestureRecognizer *)sender {

    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self seekFast];
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self seekBack];
    }

}
- (IBAction)showOrHideControllerPane:(UITapGestureRecognizer *)sender {

    self.controllerPane.alpha = self.controllerPane.hidden ? 0 : 1;

    [UIView animateWithDuration:0.5 animations:^{

        if (self.controllerPane.alpha == 0) {
            self.controllerPane.alpha = 1;
        }else {
            self.controllerPane.alpha = 0;
        }


    } completion:^(BOOL finished) {
        self.controllerPane.hidden = !self.controllerPane.hidden;
        if (self.controllerPane.hidden == NO) {
            _controlPaneCloseSec = 5;
        }
    }];


}

- (IBAction)showPlayListView:(UIButton *)sender {

    // 添加蒙版
    UIView *backView = [[UIView alloc] initWithFrame:self.playWindow.bounds];
    backView.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:0.6];

    // 添加dismiss手势
    UITapGestureRecognizer *tapGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [backView addGestureRecognizer:tapGester];

    self.playListView.y = kScreenHeight;
    kWeakSelf
    self.playListView.closeBlock = ^{
        [weakSelf dismiss:nil];
    };


    [self.playWindow insertSubview:backView atIndex:0];
    [UIView animateWithDuration:0.5 animations:^{
        self.playListView.y = kScreenHeight - self.playListView.height;
    }];

}

- (void)dismiss: (UITapGestureRecognizer *)tapGester {


    [UIView animateWithDuration:0.5 animations:^{
        self.playListView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self.playWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.playWindow resignKeyWindow];
        self.playWindow = nil;
    }];

}


#pragma mark - 弹幕代理
/** 当前时间, 内部会每隔一秒读取一次这个数值, 来决定弹幕的展示 */
-(NSTimeInterval)currentTime {

    return [XMGPlayerService shareInstance].currentPlayTime;

}

/** 根据弹幕模型 获取弹幕视图来展示 */
- (UIView *)danmuViewWithDanmuM: (id<XMGDanmuProtocol>)danmuM {

    XMGDanmuView *danmuView = [XMGDanmuView danmuViewWithDanmuM:danmuM];
    danmuView.loadBlock = ^(UIImageView *imageView, NSURL *url) {
        [imageView setURLImageWithURL:url placeHoldImage:imageView.image isCircle:YES];
    };

    return danmuView;

}

/** 点击了某个弹幕,需要做的事情 */
- (void)danmuViewDidClick: (UIView *)danmuView pointInBackView: (CGPoint)point {

    if ([danmuView isKindOfClass:[XMGDanmuView class]]) {
        XMGDanmuView *danmuV = (XMGDanmuView *)danmuView;
        [danmuV showStars:point];
    }
    
}



@end
