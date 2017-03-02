//
//  XMGClassItemCell.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGClassItemCell.h"
#import "XMGClassItemModel.h"
#import "UIButton+WebCache.h"

@interface XMGClassItemCell()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation XMGClassItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModels:(NSArray *)models
{
    
    _models = models;
    XMGClassItemModel *leftModel = self.models[0];
    XMGClassItemModel *rightModel = self.models[1];
    
    [self.leftBtn setTitle:leftModel.title forState:UIControlStateNormal];
    [self.leftBtn sd_setImageWithURL:[NSURL URLWithString:leftModel.coverPath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"findCategory_default"]];
    
    [self.rightBtn setTitle:rightModel.title forState:UIControlStateNormal];
    [self.rightBtn sd_setImageWithURL:[NSURL URLWithString:rightModel.coverPath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"findCategory_default"]];
    
}


@end
