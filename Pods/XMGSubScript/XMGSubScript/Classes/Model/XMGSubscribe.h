//
//  XMGSubscribe.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "albumCover": "http://fdfs.xmcdn.com/group18/M05/85/48/wKgJJVerAeTiBW33AAI1cEIloKY605_mobile_large.jpg",
 "albumId": 3576345,
 "albumTitle": "下班陪聊",
 "avatar": "http://fdfs.xmcdn.com/group14/M02/93/D1/wKgDZFdg7RfwA-bwAAGbZ7LSgRU189_mobile_small.jpg",
 "dynamicType": 1,
 "isPaid": false,
 "isTop": false,
 "lastUpdateAt": 1470132000000,
 "nickname": "喜马拉雅资讯日历",
 "serialState": 0,
 "timeline": 1.471074483E13,
 "trackId": 19371206,
 "trackTitle": "【田艺苗】她把古典音乐拉下高不可攀的神坛",
 "trackType": 1,
 "uid": 30495264,
 "unreadNum": 0
 */

@interface XMGSubscribe : NSObject

@property (nonatomic, copy) NSString *albumCover;
@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *albumTitle;
@property (nonatomic, copy) NSString *dynamicType;
@property (nonatomic, copy) NSString *isPaid;
@property (nonatomic, copy) NSString *isTop;
@property (nonatomic, copy) NSString *lastUpdateAt;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *serialState;
@property (nonatomic, copy) NSString *timeline;
@property (nonatomic, copy) NSString *trackId;
@property (nonatomic, copy) NSString *trackTitle;
@property (nonatomic, copy) NSString *trackType;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *unreadNum;

@property (nonatomic, assign) CGFloat cellHeight;

@end
