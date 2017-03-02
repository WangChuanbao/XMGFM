//
//  XMGSubscribleDataTool.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMGRecommends.h"
#import "XMGSubscribe.h"

#import "XMGAlbumMenu.h"
#import "XMGAlbum.h"
#import "XMGTracks.h"
#import "XMGTrack.h"

#import "XMGAlbumDetail.h"
#import "XMGOtherRecommands.h"
#import "XMGDownLoadModel.h"


@interface XMGSubscribleDataTool : NSObject
+ (instancetype)shareInstance;

/**
 *  推荐
 */
- (void)getRecommandList:(void(^)(NSArray <NSString *>*recommendList, NSError *error))result ;

/**
 *  订阅
 */
- (void)getSubscribleList:(void(^)(NSArray <NSString *>*subscribleList, NSError *error))result ;

/**
 *  专辑详情 - 详情
 */
- (void)getAlbumDetailWithAlbumId:(NSString *)albumId result:(void(^)(XMGAlbumDetail *albumDetail, NSError *error))result;

/**
 *  专辑详情 - 节目
 */
- (void)getAlbumMenuWithAlbumId:(NSString *)albumId result:(void(^)(XMGAlbumMenu *albumMenu, NSError *error))result;

/**
 专辑节目列表

 @param albumId <#albumId description#>
 @param result <#result description#>
 */
- (void)getAlbumTrackListWithAlbumId:(NSString *)albumId result:(void(^)(XMGTracks *tracks, NSError *error))result;
/**
 *  批量下载
 */
-(void)getDownLoadListAlbumId:(NSString *)albumId position:(NSInteger)position result:(void(^)(NSArray <NSString *>*downLoadList, NSError *error))result ;

@end
