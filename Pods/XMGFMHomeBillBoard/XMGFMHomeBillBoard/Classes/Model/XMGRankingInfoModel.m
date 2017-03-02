//
//  XMGRankingInfoModel.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRankingInfoModel.h"

@implementation XMGRankingInfoModel

- (Class)cellClass
{
    return NSClassFromString(@"XMGRankingListCell");
}

- (CGFloat)rowHeight
{
    return 88;
}

@end
