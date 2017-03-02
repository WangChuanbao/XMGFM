//
//  XMGAnchorInfo.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "uid": 9887414,
 "nickname": "十点读书",
 "isVerified": true,
 "smallLogo": "http://fdfs.xmcdn.com/group12/M04/04/FC/wKgDXFbFbXnjZ_4OAAFcrzBsb0I016_mobile_small.jpg",
 "isFollowed": false,
 "followers": 695397,
 "followings": 14,
 "tracks": 403,
 "albums": 4,
 "ptitle": "十点读书官方电台",
 "personDescribe": "深夜十点，每天读点好书",
 "personalSignature": "十点读书新浪微博、微信号：十点读书（duhaoshu） 。商业广告合作加QQ：2943406559。"
 */
@interface XMGAnchorInfo : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, copy) NSString *smallLogo;

@property (nonatomic, assign) BOOL isFollowed;
@property (nonatomic, assign) CGFloat followers;
@property (nonatomic, assign) NSInteger followings;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger albums;


@property (nonatomic, copy) NSString *ptitle;
@property (nonatomic, copy) NSString *personDescribe;
@property (nonatomic, copy) NSString *personalSignature;

@property (nonatomic, assign) CGFloat anchorCellHeight;

@end
