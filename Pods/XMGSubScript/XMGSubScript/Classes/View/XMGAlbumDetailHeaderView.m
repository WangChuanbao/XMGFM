//
//  XMGAlbumDetailHeaderView.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumDetailHeaderView.h"
#import "XMGAlbum.h"
#import "UIView+XMGLayout.h"
#import "Base.h"
#import "UIImageView+XMGExtension.h"
@interface XMGAlbumDetailHeaderView()

@property (strong, nonatomic) IBOutlet UIButton *subscribeButton;
@property (strong, nonatomic) IBOutlet UIButton *downloadButton;

@property (weak, nonatomic) IBOutlet UIImageView *coverSmallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *categoryNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;

@property (weak, nonatomic) IBOutlet UIButton *nickNameBtn;



@end

@implementation XMGAlbumDetailHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    

    self.subscribeButton.layer.masksToBounds = YES;
    self.downloadButton.layer.borderColor = XMGColor(139, 195, 74).CGColor;
    self.downloadButton.layer.borderWidth = .5;

    self.downloadButton.layer.masksToBounds = YES;
}

- (void)setAlbum:(XMGAlbum *)album{
    _album = album;
    
    self.titleLabel.text = album.title;
    [self.coverSmallImageView setURLImageWithURL:[NSURL URLWithString:album.coverSmall] progress:nil complete:nil];
    [self.nickNameBtn setTitle:album.nickname forState:UIControlStateNormal];
    self.playTimesLabel.text = [NSString stringWithFormat:@"播放：%.1f万",album.playTimes/10000];
    [self.categoryNameBtn setTitle:album.categoryName forState:UIControlStateNormal];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.width = kScreenWidth;
    self.height = 205;
    self.subscribeButton.layer.cornerRadius = 4;
    self.downloadButton.layer.cornerRadius = 4;
}

- (IBAction)gotoSubPageButtonClick:(UIButton *)sender {
    if (sender.tag == 2) {
        sender.selected = !sender.selected;
    }
    self.callBackClickAlbum(sender.tag);
}

@end
