//
//  XMGItemCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGItemCell.h"
#import "UIImageView+XMGExtension.h"

@interface XMGItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *payIcon;

@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation XMGItemCell


-(void)setItemInCellModel:(XMGItemInCellModel *)itemInCellModel
{
    _itemInCellModel = itemInCellModel;


    self.payIcon.hidden = [itemInCellModel.isPaid boolValue];
    NSURL *url = [NSURL URLWithString:itemInCellModel.albumCoverUrl290];
    [self.albumCoverImageView setURLImageWithURL:url placeHoldImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] isCircle:NO];
    self.titleLabel.text = itemInCellModel.trackTitle;
    self.detailLabel.text = itemInCellModel.title;


}

@end
