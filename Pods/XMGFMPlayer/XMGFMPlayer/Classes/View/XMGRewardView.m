//
//  XMGRewardView.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRewardView.h"
#import "XMGUpDownBtnPlayer.h"
#import "XMGAlubmnDetailVC.h"
#import "UIView+XMGNib.h"
#import "UIButton+WebCache.h"
#import "UIView+XMGLayout.h"

@interface XMGRewardView()

@property (weak, nonatomic) IBOutlet UILabel *voiceDetailLabel;

@property (weak, nonatomic) IBOutlet XMGUpDownBtnPlayer *rewardCountBtn;

@property (weak, nonatomic) IBOutlet UIView *rewardUserContainerView;


@end


@implementation XMGRewardView

-(void)awakeFromNib {

    [self.rewardCountBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

}

- (IBAction)viewAlubmnDetail {


    //
    XMGAlubmnDetailVC *detailVC = [[XMGAlubmnDetailVC alloc] initWithNibName:@"XMGAlubmnDetailVC" bundle:[NSBundle bundleForClass:[self class]]];
    detailVC.trackID = self.rewardInfoM.trackID;
    [self.currentViewController.navigationController pushViewController:detailVC animated:YES];

    
}



-(void)setRewardInfoM:(XMGTrackRewardInfoModel *)rewardInfoM
{
    _rewardInfoM = rewardInfoM;


    self.voiceDetailLabel.text = [NSString stringWithFormat:@"声音简介: %@", rewardInfoM.voiceIntro];

    [self.rewardCountBtn setTitle:[NSString stringWithFormat:@"%zd人打赏", rewardInfoM.numOfRewards] forState:UIControlStateNormal];

    [self.rewardUserContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    // 添加btn
    NSInteger count = rewardInfoM.rewords.count;
    // 如果多余6个, 只取6个
    if (count > 6) {
        count = 6;
    }

    for (int i = 0; i < count; i++) {
        XMGRewardModel *rewardM = rewardInfoM.rewords[i];
        XMGUpDownBtnPlayer *rewardBtn = [[XMGUpDownBtnPlayer alloc] init];
        [self.rewardUserContainerView addSubview:rewardBtn];
        NSURL *url = [NSURL URLWithString:rewardM.smallLogo];
        [rewardBtn sd_setImageWithURL:url forState:UIControlStateNormal completed:nil];
        [rewardBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [rewardBtn setTitle:[NSString stringWithFormat:@"￥%zd", rewardM.amount] forState:UIControlStateNormal];
    }


    
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    NSInteger count = self.rewardUserContainerView.subviews.count;

    CGFloat btnW = 30;
    CGFloat btnH = self.rewardUserContainerView.height;
    CGFloat btnY = 0;
    CGFloat margin = 10;
    CGFloat baseX = (self.width - count * (btnW + margin)) * 0.5;

    for (int i = 0; i < count; i++) {
        XMGUpDownBtnPlayer *btn = self.rewardUserContainerView.subviews[i];
        btn.frame = CGRectMake(baseX + i * (btnW + margin), btnY, btnW, btnH);
    }



}



@end
