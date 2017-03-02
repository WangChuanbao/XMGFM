//
//  XMGAlbumTagCell.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumTagCell.h"
@interface XMGAlbumTagCell()
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (strong, nonatomic) IBOutlet UIView *tagButtonView;
@end

@implementation XMGAlbumTagCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tagButton.layer.borderWidth = 0.5;
    self.tagButton.layer.borderColor = [UIColor orangeColor].CGColor;
    self.tagButton.layer.cornerRadius = 4;
    self.tagButton.layer.masksToBounds = YES;
}

- (IBAction)tagButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(albumTagCellDidClickTagButton)]) {
        [self.delegate albumTagCellDidClickTagButton];
    }
}


@end
