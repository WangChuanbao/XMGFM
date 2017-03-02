//
//  XMGAlbum.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "albumId": 265897,
 "categoryId": 9,
 "categoryName": "历史人文",
 "title": "十点读书",
 "coverOrigin": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279.jpg",
 "coverSmall": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279_mobile_small.jpg",
 "coverMiddle": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279_mobile_meduim.jpg",
 "coverLarge": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279_mobile_large.jpg",
 "coverWebLarge": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279_web_large.jpg",
 "coverLargePop": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279_large_pop.jpg",
 "createdAt": 1405220425000,
 "updatedAt": 1471442637000,
 "uid": 9887414,
 "nickname": "十点读书",
 "isVerified": true,
 "avatarPath": "http://fdfs.xmcdn.com/group12/M04/04/FC/wKgDXFbFbXnjZ_4OAAFcrzBsb0I016_mobile_small.jpg",
 "intro": "深夜十点，抽空读点书，放松一会，抚慰我们疲惫的心灵。",
 "introRich": "深夜十点，抽空读点书，放松一会，抚慰我们疲惫的心灵。",
 "tags": "读书,阅读,心灵,放松,深夜",
 "tracks": 384,
 "shares": 0,
 "hasNew": false,
 "isFavorite": false,
 "playTimes": 350605973,
 "lastUptrackAt": 1471442637000,
 "status": 1,
 "serializeStatus": 0,
 "serialState": 0,
 "playTrackId": 20082188,
 "isRecordDesc": true,
 "isPaid": false,
 "detailCoverPath": "http://fdfs.xmcdn.com/group14/M03/06/9F/wKgDY1bFaify4osAAADtk9VhGbs279_large_pop.jpg"
 */

@interface XMGAlbum : NSObject

@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *coverSmall;  // 图片
@property (nonatomic, assign) CGFloat playTimes;
@property (nonatomic, copy) NSString *nickname;

@end
