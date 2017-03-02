//
//  XMGRankingListModel.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGRankingInfoModel;

@interface XMGRankingListModel : NSObject

@property (nonatomic, assign)NSInteger ret;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong) NSArray <XMGRankingInfoModel *>*list;


@end
