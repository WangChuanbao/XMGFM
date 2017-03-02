//
//  XMGTracks.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGTrack;

/*
 "pageId": 1,
 "pageSize": 20,
 "maxPageId": 20,
 "totalCount": 384
 */

@interface XMGTracks : NSObject

@property (nonatomic, strong) NSArray <XMGTrack *>*list;
@property (nonatomic, copy) NSString *pageId;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *maxPageId;
@property (nonatomic, copy) NSString *totalCount;

@end
