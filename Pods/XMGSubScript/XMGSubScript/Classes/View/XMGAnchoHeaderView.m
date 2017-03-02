//
//  XMGAnchoHeaderView.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAnchoHeaderView.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGAnchoHeaderView()
@property (strong, nonatomic) IBOutlet UIButton *attendButton;
@property (strong, nonatomic) IBOutlet UIButton *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *attendNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *fansNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *zanNumLabel;
@end

@implementation XMGAnchoHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.attendButton.layer.cornerRadius = 2;
    self.attendButton.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.width = kScreenWidth;
    self.height = 280.5;
}

// 5 - 关注，6 - 粉丝，7 - 赞过的
- (IBAction)hearderBottomButtonClick {
    
}

// 关注
- (IBAction)attendButtonClick {
}

@end
