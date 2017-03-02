//
//  XMGRankingInfoModel.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJRTableViewManager.h"

@class XMGRankingFirstModel;

@interface XMGRankingInfoModel : NSObject<FJRTableRowContext>


@property (nonatomic, strong) NSString * calcPeriod;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString * contentType;
@property (nonatomic, strong) NSString * coverPath;
@property (nonatomic, assign) NSInteger firstId;
@property (nonatomic, strong) NSArray <XMGRankingFirstModel *>* firstKResults;
@property (nonatomic, strong) NSString * firstTitle;
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSArray * list;
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger period;
@property (nonatomic, assign) NSInteger rankingListId;
@property (nonatomic, strong) NSString * rankingRule;
@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, assign) NSInteger totalCount;

@end
