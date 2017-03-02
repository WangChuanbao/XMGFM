//
//  XMGRadioInfoCell.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRadioInfoCell.h"
#import "XMGRadioModel.h"
#import "UIImageView+WebCache.h"

@interface XMGRadioInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *programNameLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;

@end

@implementation XMGRadioInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.coverImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.coverImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.coverImageView.layer.shadowOpacity = 0.5;
}


- (void)setModel:(XMGRadioModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.programNameLable.text = [NSString stringWithFormat:@"直播中: %@", model.programName];
    self.playCountLable.text = [NSString stringWithFormat:@"收听人数: %.1f万人", model.playCount / 10000.0];
}
@end
