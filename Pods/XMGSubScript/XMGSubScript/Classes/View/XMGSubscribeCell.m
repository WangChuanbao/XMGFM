//
//  XMGSubscribeCell.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

/*
 "albumCover": "http://fdfs.xmcdn.com/group18/M05/85/48/wKgJJVerAeTiBW33AAI1cEIloKY605_mobile_large.jpg",
 "albumId": 3576345,
 "albumTitle": "下班陪聊",
 "avatar": "http://fdfs.xmcdn.com/group14/M02/93/D1/wKgDZFdg7RfwA-bwAAGbZ7LSgRU189_mobile_small.jpg",
 "dynamicType": 1,
 "isPaid": false,
 "isTop": false,
 "lastUpdateAt": 1470132000000,
 "nickname": "喜马拉雅资讯日历",
 "serialState": 0,
 "timeline": 1.471074483E13,
 "trackId": 19371206,
 "trackTitle": "【田艺苗】她把古典音乐拉下高不可攀的神坛",
 "trackType": 1,
 "uid": 30495264,
 "unreadNum": 0
 */

#import "XMGSubscribeCell.h"
#import "XMGSubscribe.h"
#import "UIImageView+XMGExtension.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGSubscribeCell()

@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *isPaidLabel;

@end

@implementation XMGSubscribeCell

-(void)setSubscribe:(XMGSubscribe *)subscribe{
    _subscribe = subscribe;
    
    [self.albumCoverImageView setURLImageWithURL:[NSURL URLWithString:subscribe.albumCover] placeHoldImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] isCircle:NO];
    self.albumTitleLabel.text = subscribe.albumTitle;
    self.trackTitleLabel.text = subscribe.trackTitle;
    self.nicknameLabel.text = subscribe.nickname;
    self.isPaidLabel.text = subscribe.isPaid;
    
    [self.albumTitleLabel sizeToFit];
    [self.trackTitleLabel sizeToFit];
    [self.nicknameLabel sizeToFit];
    subscribe.cellHeight = self.albumTitleLabel.height + self.trackTitleLabel.height + self.nicknameLabel.height + 40;
}

- (IBAction)downButtonClick {
    if ([self.delegate respondsToSelector:@selector(subscribeCellDidClickDownButton)]) {
        [self.delegate subscribeCellDidClickDownButton];
    }
}



@end
