//
//  XMGSupportCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSupportCell.h"
#import "UIImageView+WebCache.h"
#import "XMGSupportModel.h"


#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGSupportCell ()

@property (weak, nonatomic) IBOutlet UIButton *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *listionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeLabael;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *agoLabel;

@end

@implementation XMGSupportCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 2;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.iconImageView.layer.shadowOpacity = 1;
    

    self.iconView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 2;
    self.iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
}

+ (instancetype)supportCell {
    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGSupportCell" owner:nil options:nil] firstObject];
}

- (void)setSupportM:(XMGSupportModel *)supportM {
    
    _supportM = supportM;
    self.titleLabel.text = supportM.title;
    self.nameLabel.text = supportM.nickname;
    [self.listionLabel setTitle:[NSString stringWithFormat:@"%d",supportM.likes] forState:UIControlStateNormal];
    
    
    [self.likeLabael setTitle:[NSString stringWithFormat:@"%d",supportM.comments] forState:UIControlStateNormal];
    NSURL *url = [NSURL URLWithString:supportM.coverSmall];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
