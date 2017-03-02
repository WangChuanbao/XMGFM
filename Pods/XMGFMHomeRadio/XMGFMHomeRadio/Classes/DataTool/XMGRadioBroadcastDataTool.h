//
//  XMGRadioBroadcastDataTool.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGCategorieModel.h"
#import "XMGRadioModels.h"
#import "XMGRadioModel.h"


@interface XMGRadioBroadcastDataTool : NSObject
+ (instancetype)shareInstance;


/**
 *  获取广播模块 "分类列表"
 *
 *  @param result 分类列表
 */
- (void) getCategoriesList:(void (^)(NSMutableArray <XMGCategorieModel *>*categorieMs, NSError *error))result;

/**
 *  获取广播模块 "当地电台列表"
 *
 *  @param result 当地电台列表
 */
- (void)getLocalRadioList:(void(^)(XMGRadioModels *radioMs, NSError *error))result;

/**
 *  获取广播模块 "排行榜列表"
 *
 *  @param result 排行榜列表
 */
- (void)getTopRadioList:(void(^)(XMGRadioModels *radioMs, NSError *error))result;



/**
 *  获取广播模块 "各个电台的详细数据"
 *
 *  @param result 各个电台的详细数据
 */
- (void) getRadioCategoriesListWithId:(NSInteger) Id resultBlock: (void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result;

/**
 *  获取本地更多列表
 *
 *  @param result 更多列表
 */
- (void) getRadioLocalMore:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result;

/**
 *  获取排行榜更多列表
 *
 *  @param result 更多列表
 */
- (void) getRadioHotMore:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result;

/**
 *  获取本地台数据列表
 *
 *  @param result 本地台数据列表
 */

- (void) getRadioProvince:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result;
/**
 *  获取国家台数据列表
 *
 *  @param result 国家台数据列表
 */

- (void) getRadioNational:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result;

/**
 *  获取网络台数据列表
 *
 *  @param result 网络台数据列表
 */

- (void) getRadioNetwork:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result;
@end
