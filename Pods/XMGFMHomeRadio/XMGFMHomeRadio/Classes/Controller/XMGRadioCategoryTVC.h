//
//  XMGRadioCategoryTVC.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGCategorieModel;

typedef NS_ENUM (NSInteger, LoadDataType){
    LoadDataRadioCategories,        //各个电台的详细数据
    LoadDataRadioLocalMore,         // 当地更多列表
    LoadDataRadioHotMore,           // 排行榜更多列表
    LoadDataRadioProvince,          // 本地台列表
    LoadDataRadioNational,          //国家台列表
    LoadDataProvince,               //省市台
    LoadDataRadioNetwork            //网络台
};

@interface XMGRadioCategoryTVC : UITableViewController

@property (nonatomic, strong)XMGCategorieModel *model;

@property (nonatomic, copy)NSString *navTitle;

/**
 *  需要加载的数据类型
 */
@property (nonatomic, assign)LoadDataType type;

@end
