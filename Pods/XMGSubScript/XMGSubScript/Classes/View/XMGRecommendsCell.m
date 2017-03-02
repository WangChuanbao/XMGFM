//
//  XMGRecommendsCell.h.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

/*
 albumId = 4710695;
 basedRelativeAlbumId = 0;
 coverLarge = "http://fdfs.xmcdn.com/group20/M03/19/63/wKgJLFeDN-DQK_p1AARf7-JK7d0646_mobile_large.png";
 coverMiddle = "http://fdfs.xmcdn.com/group20/M03/19/63/wKgJLFeDN-DQK_p1AARf7-JK7d0646_mobile_large.png";
 info = "\U7aa5\U7834\U4e00\U672c\U6570\U767e\U5e74\U6765\U88ab\U4eba\U8bef\U8bfb\U6700\U591a\U6700\U6df1\U7684\U5947\U4e66";
 lastUptrackAt = 1470744001000;
 lastUptrackId = 19714173;
 lastUptrackTitle = "19\U897f\U95e8\U5e86\U6b3a\U9a97\U5973\U6027\U7684\U4f0e\U4fe9";
 nickname = "\U5609\U5e86\U8bf4\U6545\U4e8b";
 playsCounts = 912755;
 recReason = "\U6839\U636e\U4f60\U7684\U5174\U8da3\U63a8\U8350";
 recSrc = HotRec;
 recTrack = "classic:101";
 serialState = 0;
 tags = "";
 title = "\U95f2\U8bdd\U91d1\U74f6\U6885";
 trackId = 19714173;
 trackTitle = "19\U897f\U95e8\U5e86\U6b3a\U9a97\U5973\U6027\U7684\U4f0e\U4fe9";
 tracks = 21;
 uid = 3205937;
 */

#import "XMGRecommendsCell.h"
#import "XMGRecommends.h"
#import "XMGOtherRecommand.h"
#import "UIImageView+XMGExtension.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGRecommendsCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverMiddleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *recReasonLabel;
@property (weak, nonatomic) IBOutlet UIButton *playsCountsButton;
@property (weak, nonatomic) IBOutlet UIButton *tracksButton;

@end

@implementation XMGRecommendsCell

-(void)setRecommends:(XMGRecommends *)recommends{
    _recommends = recommends;
    
    [self.coverMiddleImageView setURLImageWithURL:[NSURL URLWithString:recommends.coverMiddle] placeHoldImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] isCircle:NO];
    self.titleLabel.text = recommends.title;
    self.recReasonLabel.text = recommends.recReason;
    [self.playsCountsButton setTitle:recommends.playsCounts forState:UIControlStateNormal];
    [self.tracksButton setTitle:recommends.tracks forState:UIControlStateNormal];
    
    [self.titleLabel sizeToFit];
    [self.recReasonLabel sizeToFit];
    recommends.cellHeight = self.titleLabel.height + self.recReasonLabel.height + 56;
    
}


- (void)setOtherRecommand:(XMGOtherRecommand *)otherRecommand{
    _otherRecommand = otherRecommand;
    
    [self.coverMiddleImageView setURLImageWithURL:[NSURL URLWithString:otherRecommand.coverSmall] placeHoldImage:[UIImage imageNamed:@"find_albumcell_cover_bg"] isCircle:NO];
    self.titleLabel.text = otherRecommand.title;
    self.recReasonLabel.text = otherRecommand.intro;
    [self.playsCountsButton setTitle:otherRecommand.playsCounts forState:UIControlStateNormal];
    [self.tracksButton setTitle:otherRecommand.tracks forState:UIControlStateNormal];
    
    [self.titleLabel sizeToFit];
    [self.recReasonLabel sizeToFit];
    otherRecommand.recommandCellHeight = self.titleLabel.height + self.recReasonLabel.height + 56;
}

@end
