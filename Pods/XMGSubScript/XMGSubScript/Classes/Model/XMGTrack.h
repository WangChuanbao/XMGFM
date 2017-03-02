//
//  XMGTrack.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "trackId": 20082188,
 "uid": 9887414,
 "playUrl64": "http://audio.xmcdn.com/group20/M0B/99/2A/wKgJLFey4kuTA_SrADqd9A76_lk730.mp3",
 "playUrl32": "http://audio.xmcdn.com/group18/M02/99/20/wKgJKley4j2BZMDbAB1PGSFoSGA911.mp3",
 "playPathHq": "",
 "playPathAacv164": "http://audio.xmcdn.com/group18/M02/99/B2/wKgJJVey4j-CJIFvADtVyXJmMZ0777.m4a",
 "playPathAacv224": "http://audio.xmcdn.com/group18/M02/99/20/wKgJKley4j7C3E8KABax2pUv4SE263.m4a",
 "title": "主播夏萌：我拒绝过凑合的人生-李娜",
 "duration": 480,
 "albumId": 265897,
 "isPaid": false,
 "processState": 2,
 "createdAt": 1471440600000,
 "coverSmall": "http://fdfs.xmcdn.com/group14/M03/06/85/wKgDZFbFaifjILrcAADtk9VhGbs948_web_meduim.jpg",
 "coverMiddle": "http://fdfs.xmcdn.com/group14/M03/06/85/wKgDZFbFaifjILrcAADtk9VhGbs948_web_large.jpg",
 "coverLarge": "http://fdfs.xmcdn.com/group14/M03/06/85/wKgDZFbFaifjILrcAADtk9VhGbs948_mobile_large.jpg",
 "nickname": "十点读书",
 "smallLogo": "http://fdfs.xmcdn.com/group12/M04/04/FC/wKgDXFbFbXnjZ_4OAAFcrzBsb0I016_mobile_small.jpg",
 "userSource": 1,
 "opType": 1,
 "isPublic": true,
 "likes": 79,
 "playtimes": 195858,
 "comments": 44,
 "shares": 0,
 "status": 1
 */

@interface XMGTrack : NSObject
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *playUrl64;
@property (nonatomic, copy) NSString *playUrl32;
@property (nonatomic, copy) NSString *playPathAacv164;
@property (nonatomic, copy) NSString *playPathAacv224;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) BOOL isPaid;
@property (nonatomic, assign) CGFloat createdAt;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) CGFloat playtimes;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) CGFloat cellHeight;
@end
