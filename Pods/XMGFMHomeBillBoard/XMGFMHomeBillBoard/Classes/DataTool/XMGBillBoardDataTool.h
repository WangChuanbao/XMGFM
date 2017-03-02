//
//  XMGAnchorDataTool.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGAdPicModel;
@class XMGFocusImages;
@class XMGRankingListModel;

@interface XMGBillBoardDataTool : NSObject
+ (instancetype)shareInstance;

/**
 *  获取榜单模块广告列表
 *
 *  @param result 广告列表
 */
- (void)getFocusList:(void(^)(NSArray <XMGAdPicModel *>*adMs, NSError *error))result;
- (void)getRankingList:(void(^)(NSArray <XMGRankingListModel *>*listMs, NSError *error))result;

@end
