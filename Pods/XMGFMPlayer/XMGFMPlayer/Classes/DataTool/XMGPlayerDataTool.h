//
//  XMGPlayerDataTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGTrackInfoModel.h"
#import "XMGAlbumInfoModel.h"
#import "XMGUserInfoModel.h"
#import "XMGCommentInfoModel.h"
#import "XMGTrackRewardInfoModel.h"

#import "XMGPlayerGroupModel.h"
#import "XMGPlayerCommentGroupModel.h"
#import "XMGAlubmnDetailModel.h"
#import "XMGDanmuModel.h"


@interface XMGPlayerDataTool : NSObject
+ (instancetype)shareInstance;


- (void)getPlayerDataWithAlbumId:(NSInteger)albumId trackUid: (NSInteger)trackUid  result: (void(^)(XMGTrackInfoModel *trackM, XMGAlbumInfoModel *albumInfoM, XMGPlayerGroupModel *associationAlbumGroupM, XMGUserInfoModel *userInfoM, XMGPlayerCommentGroupModel *commentGroupM, XMGTrackRewardInfoModel *rewardInfoM))resultBlock;


- (void)getRecommendMsWithAlbumId:(NSInteger)albumId result: (void(^)(NSArray <XMGAlbumInfoModel *>*albumInfoMs))result;


- (void)getCommentMsWithTrackId:(NSInteger)trackId retuslt: (void(^)(NSArray <XMGCommentInfoModel *>*commentMs))result;


- (void)getTrackDetailWithTrackID: (NSInteger)trackID result:(void(^)(XMGAlubmnDetailModel *alubmnDetailM))resultBlock;


- (void)getRewardList:(void(^)())resultBlock;


- (void)getTrackMsWithAlbumId: (NSInteger)albumId trackId:(NSInteger)trackId result:(void(^)(NSMutableArray <XMGTrackInfoModel *>*))resultBlock;

/**
 *  获取弹幕模型
 *
 */
- (void)getDanMuMsWithTrackId:(NSInteger)trackId result:(void(^)(NSMutableArray <XMGDanmuModel *>*danmuMs, BOOL isNewData))resultBlock;



@end
