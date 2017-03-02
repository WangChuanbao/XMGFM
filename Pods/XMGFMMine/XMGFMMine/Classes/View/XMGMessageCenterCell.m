//
//  XMGMessageCenterCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMessageCenterCell.h"
#import "UIView+XMGLayout.h"

@interface XMGMessageCenterCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation XMGMessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 1;
    self.iconImageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    
}


+ (instancetype)messageCenterCell {

    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGMessageCenterCell" owner:nil options:nil] firstObject];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
