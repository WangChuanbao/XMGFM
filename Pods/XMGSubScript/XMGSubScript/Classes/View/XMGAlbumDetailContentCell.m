//
//  XMGAlbumDetailContentCell.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumDetailContentCell.h"
#import "XMGAlbumDetailInfo.h"
@interface XMGAlbumDetailContentCell()

@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation XMGAlbumDetailContentCell

- (void)setAlbumDetailInfo:(XMGAlbumDetailInfo *)albumDetailInfo{
    _albumDetailInfo = albumDetailInfo;
    self.introLabel.text = albumDetailInfo.intro;
}

@end
