//
//  XMGAlbumDetail.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGAlbumDetailInfo;
@class XMGAnchorInfo;
@class XMGOtherRecommands;

@interface XMGAlbumDetail : NSObject

@property (nonatomic, strong) XMGAlbumDetailInfo *detail;
@property (nonatomic, strong) XMGAnchorInfo *user;
@property (nonatomic, strong) XMGOtherRecommands *recs;

@end

