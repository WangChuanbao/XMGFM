//
//  XMGCategoriesCell.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCategoriesCell.h"

@interface XMGCategoriesCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *imageView;

@end


@implementation XMGCategoriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_radio_hide"]];
    
    
}


- (void)up
{
    self.imageView.image = [UIImage imageNamed:@"icon_radio_hide"];
}

- (void)down
{
    self.imageView.image = [UIImage imageNamed:@"icon_radio_show"];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.center = self.contentView.center;
}

- (void)setModel:(XMGCategorieModel *)model
{
    
    
    _model = model;
    
    
    
    if (model.isLast) {
        [self.contentView addSubview:self.imageView];
        
    }else{
        
        [self.imageView removeFromSuperview];
        
    }
    
    self.nameLabel.text = model.name;
    
}

@end
