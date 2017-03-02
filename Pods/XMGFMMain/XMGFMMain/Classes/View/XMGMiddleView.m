//
//  XMGMiddleView.m
//  XMGFM
//
//  Created by 王顺子 on 16/10/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMiddleView.h"
#import "CALayer+PauseAimate.h"

@interface XMGMiddleView()

/**
 中间的播放内容视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

/**
 播放按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end



@implementation XMGMiddleView

static XMGMiddleView *_shareInstance;

+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [XMGMiddleView middleView];
    }
    return _shareInstance;
}


+ (instancetype)middleView {
    
    XMGMiddleView *middleView = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGMiddleView" owner:nil options:nil] firstObject];
    return middleView;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    self.middleImageView.layer.masksToBounds = YES;

//    [self.playBtn setImage:[UIImage new] forState:UIControlStateHighlighted];
//    [self.playBtn setImage:[UIImage new] forState:UIControlStateSelected];




    [self.middleImageView.layer removeAnimationForKey:@"playAnnimation"];
    CABasicAnimation *basicAnnimation = [[CABasicAnimation alloc] init];
    basicAnnimation.keyPath = @"transform.rotation.z";
    basicAnnimation.fromValue = @0;
    basicAnnimation.toValue = @(M_PI * 2);
    basicAnnimation.duration = 30;
    basicAnnimation.repeatCount = MAXFLOAT;
    basicAnnimation.removedOnCompletion = NO;
    [self.middleImageView.layer addAnimation:basicAnnimation forKey:@"playAnnimation"];

    [self.middleImageView.layer pauseAnimate];


    [self.playBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayerPlay:) name:@"playState" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPlayImage:) name:@"playImage" object:nil];
}

- (void)isPlayerPlay:(NSNotification *)notification {
    BOOL isPlay = [notification.object boolValue];
    self.isPlaying = isPlay;
}

- (void)setPlayImage:(NSNotification *)notification {
    UIImage *image = notification.object;
    self.middleImg = image;
}

- (void)btnClick:(UIButton *)btn {

    if (self.middleClickBlock) {
        self.middleClickBlock(self.isPlaying);
    }

}


- (void)setIsPlaying:(BOOL)isPlaying {

    if (_isPlaying == isPlaying) {
        return;
    }
    _isPlaying = isPlaying;
    if (isPlaying) {
        [self.playBtn setImage:nil forState:UIControlStateNormal];
        [self.middleImageView.layer resumeAnimate];

    }else {
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundleName = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
        NSString *path = [currentBundle pathForResource:@"tabbar_np_play@2x.png" ofType:nil inDirectory:bundleName];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [self.playBtn setImage:image forState:UIControlStateNormal];

        [self.middleImageView.layer pauseAnimate];
    }
}

-(void)setMiddleImg:(UIImage *)middleImg {
    _middleImg = middleImg;
    self.middleImageView.image = middleImg;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.middleImageView.layer.cornerRadius = self.middleImageView.frame.size.width * 0.5;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
