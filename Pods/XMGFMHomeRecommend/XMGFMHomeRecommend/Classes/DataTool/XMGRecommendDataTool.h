//
//  XMGRecommendDataTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGAdPicModel;
@class XMGMenueModel;
#import "XMGGroupModel.h"
#import "XMGNominateEditorModel.h"


@interface XMGRecommendDataTool : NSObject

+ (instancetype)shareInstance;


/**
 *  获取发现模块的菜单列表
 *
 *  @param result 菜单列表
 */
- (void)getDiscoverMenueList:(void(^)(NSArray <NSString *>*menueList, NSError *error))result;


/**
 *  获取发现模块的  "广告列表"
 *
 *  @param result 广告列表
 */
- (void)getAdList:(void(^)(NSArray <XMGAdPicModel *>*adMs, NSError *error))result;


/**
 *  获取发现模块的 "图文菜单"
 *
 *  @param result 图文菜单列表
 */
- (void)getPicMenueList:(void(^)(NSArray <XMGMenueModel *>*menuePicMs, NSError *error))result;

/**
 *  获取发现模块的  "小编推荐"
 *
 *  @param result 小编推荐
 */
- (void)getEditorRecommendAlbums:(void(^)(XMGGroupModel *groupM, NSError *error))result;

/**
 *  获取小编推荐更多数据
 *
 *  @param result 小编推荐更多数据
 */
- (void)getRecommendEditorList:(void (^)(NSArray <XMGNominateEditorModel *>*editorMs, NSError *error))result;

/**
 *  获取发现模块的  "现场直播"
 *
 *  @param result 现场直播
 */
- (void)getLiveMs:(void(^)(XMGGroupModel *groupM, NSError *error))result;


/**
 *  获取发现模块的  "精品听单"
 *
 *  @param result 精品听单
 */
- (void)getSpecialColumnMs:(void(^)(XMGGroupModel *groupM, NSError *error))result;


/**
 *  获取发现模块的  "推广"
 *
 *  @param result 推广
 */
- (void)getTuiGuangMs:(void(^)(XMGGroupModel *groupM, NSError *error))result;

/**
 *  获取发现模块的  "听广州"
 *
 *  @param result 听广州
 */
- (void)getCityAlbums:(void(^)(XMGGroupModel *groupM, NSError *error))result;

/**
 *  获取发现模块的  "热门推荐-听其他"
 *
 *  @param result "热门推荐-听其他"
 */
- (void)getHotRecommendsAlbums:(void(^)(NSArray <XMGGroupModel *> *groupMs, NSError *error))result;

@end
