//
//  XMGAlbumDetaiVedioCell.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumDetaiVedioCell.h"
#import "XMGTrack.h"
#import "UIButton+WebCache.h"
#import "UIView+XMGLayout.h"
#import "Base.h"

@interface XMGAlbumDetaiVedioCell()
@property (weak, nonatomic) IBOutlet UIButton *vedioButton;
@property (weak, nonatomic) IBOutlet UILabel *vedioTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *vedioDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *vedioNumButton;
@property (weak, nonatomic) IBOutlet UIButton *vedioCommandButton;
@property (weak, nonatomic) IBOutlet UIButton *vedioTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;

// 标签里要用的label
@property (weak, nonatomic) IBOutlet UILabel *byLabel;
/*
 "trackId": 20082188,
 "uid": 9887414,
 "playUrl64": "http://audio.xmcdn.com/group20/M0B/99/2A/wKgJLFey4kuTA_SrADqd9A76_lk730.mp3",
 "playUrl32": "http://audio.xmcdn.com/group18/M02/99/20/wKgJKley4j2BZMDbAB1PGSFoSGA911.mp3",
 "playPathHq": "",
 "playPathAacv164": "http://audio.xmcdn.com/group18/M02/99/B2/wKgJJVey4j-CJIFvADtVyXJmMZ0777.m4a",
 "playPathAacv224": "http://audio.xmcdn.com/group18/M02/99/20/wKgJKley4j7C3E8KABax2pUv4SE263.m4a",
 "title": "主播夏萌：我拒绝过凑合的人生-李娜",
 "duration": 480,
 "albumId": 265897,
 "isPaid": false,
 "processState": 2,
 "createdAt": 1471440600000,
 "coverSmall": "http://fdfs.xmcdn.com/group14/M03/06/85/wKgDZFbFaifjILrcAADtk9VhGbs948_web_meduim.jpg",
 "coverMiddle": "http://fdfs.xmcdn.com/group14/M03/06/85/wKgDZFbFaifjILrcAADtk9VhGbs948_web_large.jpg",
 "coverLarge": "http://fdfs.xmcdn.com/group14/M03/06/85/wKgDZFbFaifjILrcAADtk9VhGbs948_mobile_large.jpg",
 "nickname": "十点读书",
 "smallLogo": "http://fdfs.xmcdn.com/group12/M04/04/FC/wKgDXFbFbXnjZ_4OAAFcrzBsb0I016_mobile_small.jpg",
 "userSource": 1,
 "opType": 1,
 "isPublic": true,
 "likes": 79,
 "playtimes": 195858,
 "comments": 44,
 "shares": 0,
 "status": 1
 */

@end

@implementation XMGAlbumDetaiVedioCell

- (void)setTrack:(XMGTrack *)track
{
    _track = track;
    
    [self.vedioButton sd_setBackgroundImageWithURL:[NSURL URLWithString:track.smallLogo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:track.createdAt];
    NSString *timeF = [formater stringFromDate:date];
    self.vedioDateLabel.text = [NSString stringWithFormat:@"%@",timeF];
    [self.vedioNumButton setTitle:[NSString stringWithFormat:@"%.2f 万", track.playtimes / 10000] forState:UIControlStateNormal];
    [self.vedioCommandButton setTitle:[NSString stringWithFormat:@"评论:%zd",track.comments] forState:UIControlStateNormal];
    [self.vedioTimeButton setTitle:[NSString stringWithFormat:@"时长:%zd:%zd",((int)track.duration) / 60, ((int)track.duration) % 60] forState:UIControlStateNormal];
    self.vedioTitleLabel.text = track.title;

    [self.vedioTitleLabel sizeToFit];
    track.cellHeight = self.vedioTitleLabel.height + 49;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];

    self.vedioButton.layer.masksToBounds = YES;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.vedioButton.layer.cornerRadius = self.vedioButton.width / 2;
}


- (IBAction)vedioOpenButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}


@end;
