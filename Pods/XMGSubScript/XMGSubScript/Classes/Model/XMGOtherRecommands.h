//
//  XMGOtherRecommands.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGOtherRecommand;
/*
 "pageId": 1,
 "pageSize": 3,
 "maxPageId": 4,
 "totalCount": 10
 */

@interface XMGOtherRecommands : NSObject

@property(nonatomic, strong)NSArray <XMGOtherRecommand *>* list;
@property(nonatomic, assign)NSInteger pageId;
@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, assign)NSInteger maxPageId;
@property(nonatomic, assign)NSInteger totalCount;
@end
