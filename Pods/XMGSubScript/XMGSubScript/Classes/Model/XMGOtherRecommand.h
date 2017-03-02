//
//  XMGOtherRecommand.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "albumId": 2911138,
 "title": "十点新书：疲惫生活中的英雄梦想",
 "coverSmall": "http://fdfs.xmcdn.com/group8/M08/66/CC/wKgDYVXgaZ3TS9jjAAL3xWXRQ8I105_mobile_small.jpg",
 "coverMiddle": "http://fdfs.xmcdn.com/group8/M08/66/CC/wKgDYVXgaZ3TS9jjAAL3xWXRQ8I105_mobile_large.jpg",
 "updatedAt": 1459099149000,
 "uid": 9887414,
 "intro": "我们一起，以梦想的力量，抵御世事无常。",
 "tracks": 12,
 "playTimes": 17993804,
 "playsCounts": 17993804,
 "commentsCount": 0,
 "recSrc": "cf1",
 "recTrack": "ra"
 */
@interface XMGOtherRecommand : NSObject

@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *coverSmall;  // 图片
@property (nonatomic, copy) NSString *playsCounts;
@property (nonatomic, copy) NSString *tracks;

@property (nonatomic, assign) CGFloat recommandCellHeight;

@end
