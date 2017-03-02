//
//  XMGRecordVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecordVC.h"
#import "XMGRecodHeader.h"
#import "XMGRecordTool.h"
#import "XMGMusicTool.h"
#import "XMGAlertTool.h"
#import "XMGAddMusicVC.h"

@interface XMGRecordVC ()
@property (weak, nonatomic) IBOutlet XMGRecodHeader *headerView;
@property (nonatomic, strong) CADisplayLink *link;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeBackBarView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger curTime;
//底部录音 暂停,开始 文字
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
//试听文字
@property (weak, nonatomic) IBOutlet UILabel *listionLabel;
//试听按钮
@property (weak, nonatomic) IBOutlet UIButton *listionBtn;
//保存录音按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
//录音按钮
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
//恢复录音按钮
@property (weak, nonatomic) IBOutlet UIButton *backRecordBtn;

@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

//音乐View
@property (weak, nonatomic) IBOutlet UIView *musicView;

//存放的是音乐路径
@property (nonatomic, strong) NSMutableArray *musicArray;

//添加配乐2
@property (weak, nonatomic) IBOutlet UIButton *addBtn2;
//音乐名称1
@property (weak, nonatomic) IBOutlet UILabel *musicLabel1;
//音乐名称2
@property (weak, nonatomic) IBOutlet UILabel *musicLabel2;
//音乐1时长
@property (weak, nonatomic) IBOutlet UILabel *durationLabel1;
//音乐2时长
@property (weak, nonatomic) IBOutlet UILabel *durationLabel2;

@property (nonatomic,weak) UIButton *preBtn;

@end

@implementation XMGRecordVC


- (NSMutableArray *)musicArray {
    
    if (_musicArray == nil) {
        _musicArray = [NSMutableArray array];
    }
    return _musicArray;
}


- (CADisplayLink *)link {
    
    if (_link == nil) {
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        link.paused = YES;
        _link = link;
    }
    return _link;
}
//返回上一级
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录音";
    self.musicView.hidden = YES;
}
//试听按钮点击
- (IBAction)playRecord:(UIButton *)btn {

    btn.selected = !btn.selected;
    if (btn.selected) {
        NSString *filePath = [XMGRecordTool shareInstance].recordPath;
        [[XMGMusicTool shareInstance] playAudioWithPath:filePath];
    }else {

        [[XMGMusicTool shareInstance] pauseCurrentAudio];
    }
    
}

//录音按钮点击
- (IBAction)recordBtnClick:(UIButton *)sender {
    
    [self.headerView setLoginHidden:self.link.paused];
    
    //试听按钮取消选中状态
    self.listionBtn.selected = NO;
    
    //显示底部时间条
    if (self.timeBackBarView.hidden) {
        self.timeBackBarView.hidden = NO;
    }
    self.link.paused = !self.link.paused;
    
    //切换状态
    sender.selected = !sender.selected;
    //添加旋转核心动画
    CATransition *anim = [CATransition animation];
    anim.type = @"oglFlip";
    anim.subtype = @"fromLeft";
    anim.duration = 0.5;
    [sender.imageView.layer addAnimation:anim forKey:nil];
    
    if (self.link.paused) {
        //暂停
        [self.timer invalidate];
        self.stateLabel.text = @"录音已暂停";
        //显示试听按钮
        self.listionBtn.hidden = NO;
        self.listionLabel.hidden = NO;
        //停止录音
        [[XMGRecordTool shareInstance] endRecord];
        
    }else {
        //停止播放
        [[XMGMusicTool shareInstance] stopCurrentAudio];
        
        //开始录音
        [[XMGRecordTool shareInstance] beginRecord];
        
        //开始录音
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        self.stateLabel.text = @"麦克风正在录制";
        //隐藏试听按钮
        self.listionBtn.hidden = YES;
        self.listionLabel.hidden = YES;
    }
}
//更新时间
- (void)updateTime {
    [self updateWithNewTime: self.curTime += 1];
}
//更新时间
- (void)updateWithNewTime:(NSInteger)newTime {
    
    NSInteger minutes = newTime / 60;
    NSInteger seconds = newTime % 60;
    [self.timeLabel setText:[NSString stringWithFormat:@"%02zd:%02zd",minutes, seconds]];
}

//定时器方法,更新头部时间线
- (void)update {
    [self.headerView updateTime];
}

//暂停按钮点击
- (IBAction)pauseBtnClick:(UIButton *)btn {
    
    
    if (btn.selected == YES) {
        
        [XMGAlertTool alertTitle:@"确定要重录嘛" type:UIAlertControllerStyleAlert message:nil didTask:^{
            
            self.saveBtn.hidden = YES;
            self.stateLabel.hidden = YES;
            self.backRecordBtn.hidden = YES;
            self.recordBtn.hidden = NO;
            self.pauseBtn.hidden = YES;
            self.timeBackBarView.hidden = YES;
            
            [self.headerView restoreAll];
            self.curTime = 0;
            
            self.logoImageView.hidden = NO;
            
        }];
        
        return;
    }
    
    btn.selected = YES;
    
    //暂停定时器
    self.link.paused = YES;
    [self.headerView setLoginHidden:NO];
    [self.timer invalidate];
    //暂停录音
    [[XMGRecordTool shareInstance] pauseRecord];
    
    //隐藏录音按钮
    self.recordBtn.hidden = YES;
    //显示恢复按钮
    self.backRecordBtn.hidden = NO;
    
    //添加旋转核心动画
    CATransition *anim = [CATransition animation];
    anim.type = @"oglFlip";
    anim.subtype = @"fromLeft";
    anim.duration = 0.5;
    [self.backRecordBtn.imageView.layer addAnimation:anim forKey:nil];

}

//保存按钮点击
- (IBAction)saveBtnClick:(id)sender {
    
}

//恢复按钮点击
- (IBAction)backRecordBtnClick:(UIButton *)sender {
    
    sender.hidden = YES;
    self.recordBtn.hidden = NO;
    self.pauseBtn.selected = NO;
   
    if (self.recordBtn.selected) {
        
       self.link.paused = NO;
        
    }
    
}

//添加到添加音乐
- (IBAction)addMusic:(id)sender {
    
    XMGAddMusicVC *musicVC = [[XMGAddMusicVC alloc] init];
    __weak typeof(self) weakSelf = self;
    //选择完音乐调用
    musicVC.didChooseMusic = ^(NSString *filePath){
        
        
        [weakSelf.musicArray addObject:filePath];
        
        NSLog(@"%@",weakSelf.musicArray);
        //如果选择了音乐 ,显示
        if (weakSelf.musicArray.count == 1) {
            weakSelf.musicView.hidden = NO;
            //设置名称
            NSString *file = [(NSString *)weakSelf.musicArray[0] lastPathComponent];
            NSInteger index = file.length - 4;
            file = [file substringToIndex:index];
            weakSelf.musicLabel1.text = file;
            
            //获取播放时长
            NSURL *url = [NSURL fileURLWithPath:filePath];
            NSInteger duration = [self durationWithVideo:url];
            NSInteger minutes = duration / 60;
            NSInteger seconds = duration % 60;
            //显示时间
            [self.durationLabel1 setText:[NSString stringWithFormat:@"%02zd:%02zd",minutes, seconds]];
        }else if (weakSelf.musicArray.count == 2) {
            
            weakSelf.addBtn2.hidden = YES;
            //设置名称
            NSString *file2 = [(NSString *)weakSelf.musicArray[1] lastPathComponent];
            NSInteger index2 = file2.length - 4;
            file2 = [file2 substringToIndex:index2];
            weakSelf.musicLabel2.text = file2;
            
            
            
            //获取播放时长
            NSURL *url = [NSURL fileURLWithPath:filePath];
            NSInteger duration = [self durationWithVideo:url];
            NSInteger minutes = duration / 60;
            NSInteger seconds = duration % 60;
            //显示时间
            [self.durationLabel2 setText:[NSString stringWithFormat:@"%02zd:%02zd",minutes, seconds]];
            
        }else {
            weakSelf.addBtn2.hidden = NO;
        }
    
        
    };
    
    [self.navigationController pushViewController:musicVC animated:YES];
}

//播放配音音乐
- (IBAction)playMusic:(UIButton *)sender {


    sender.selected = !sender.selected;
    if (!sender.selected) {
        self.preBtn.selected = NO;
        self.preBtn = sender;
    }
    if (sender.selected) {
        NSString *musicPath = self.musicArray[sender.tag];
        //获取路径
        [[XMGMusicTool shareInstance] playAudioWithPath:musicPath];
    }else {
        [[XMGMusicTool shareInstance] stopCurrentAudio];
    }
    

    
}

//更换音乐

//获取音频播放时长
- (NSUInteger)durationWithVideo:(NSURL *)videoUrl{
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts]; // 初始化视频媒体文件
    NSUInteger second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
    return second;
}



#pragma -mark 生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

@end
