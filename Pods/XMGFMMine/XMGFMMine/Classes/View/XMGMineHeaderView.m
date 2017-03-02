//
//  XMGMineHeaderView.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMineHeaderView.h"

@interface XMGMineHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation XMGMineHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 40;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 3;
    self.iconImageView.layer.borderColor = [UIColor grayColor].CGColor;
}

+ (instancetype)mineHeaderView {
    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGMineHeaderView" owner:nil options:nil] firstObject];
}
//节目管理
- (IBAction)programMangeClick:(id)sender {
    if (self.programClickTask) {
        self.programClickTask();
    }
}

- (IBAction)settingClick:(id)sender {
    if (self.settingClickTask) {
        self.settingClickTask();
    }
}

//录音
- (IBAction)recordClick:(id)sender {
    if (self.recordClickTask) {
        self.recordClickTask();
    }
}



@end
