//
//  XMGClassificationDataTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGMenueModel;
@class XMGAdPicModel;
@class XMGClassItemModel;


@interface XMGClassificationDataTool : NSObject

+ (instancetype)shareInstance;

/**
 *  获取分类模块的 "图文菜单"
 *
 *  @param result 图文菜单列表
 */
- (void)getPicMenueList:(void(^)(NSArray <XMGMenueModel *>*menuePicMs, NSError *error))result;


/**
 *  获取分类模块的  "广告列表"
 *
 *  @param result 广告列表
 */
- (void)getAdList:(void(^)(NSArray <XMGAdPicModel *>*adMs, NSError *error))result;

/**
 *  获取分类模块的  "选项列表"
 *
 *  @param result 选项列表
 */
- (void)getClassItemList:(void(^)(NSArray *classItemMs, NSError *error))result;

@end
