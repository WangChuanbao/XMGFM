//
//  XMGDanmuView.m
//  弹幕测试
//
//  Created by 王顺子 on 16/9/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDanmuView.h"
#import "CALayer+Aimate.h"
#import "DMHeartFlyView.h"


static NSMutableArray *danDaos;

@interface XMGDanmuView ()

@property (strong, nonatomic) IBOutlet UIImageView *userIcon;

@property (strong, nonatomic) IBOutlet UIButton *contentBtn;


@end


@implementation XMGDanmuView


+ (instancetype)danmuViewWithDanmuM:(id<XMGDanmuProtocol>)danmuM {
    XMGDanmuView *danmuView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGDanmuView" owner:nil options:nil] firstObject];


    [danmuView.contentBtn setAttributedTitle:danmuM.attributeContent forState:UIControlStateNormal]
    ;

    CGSize size = [danmuM.attributeContent.string sizeWithAttributes:@{
                                         NSFontAttributeName: [danmuView.contentBtn.titleLabel font]
                                         }];

    danmuView.bounds = CGRectMake(0, 0, 80 + size.width, danmuView.bounds.size.height);
    danmuView.danmuM = danmuM;

    return danmuView;

}

-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    NSURL *iconURL = [NSURL URLWithString:self.danmuM.headerIconUrl];

    if (self.loadBlock) {
        self.loadBlock(self.userIcon, iconURL);
    }
}

- (void)showStars:(CGPoint)point {

    CGFloat _heartSize = 36;
    DMHeartFlyView *heart = [[DMHeartFlyView alloc] initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
    [self.superview addSubview:heart];
    heart.center = point;
    [heart animateInView:self.superview];

}


-(void)dealloc {
    NSLog(@"释放");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)danmuStateChange:(NSNotification *)notification {

    if ([notification.object  isEqual: @(YES)]) {
        [self.layer resumeAnimate];
    }else {
        [self.layer pauseAnimate];
    }

}


-(void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    UIImage *backImg = [self.contentBtn backgroundImageForState:UIControlStateNormal];
    UIImage *resultImage = [backImg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 10) resizingMode:UIImageResizingModeTile];
    [self.contentBtn setBackgroundImage:resultImage forState:UIControlStateNormal];
}






@end
