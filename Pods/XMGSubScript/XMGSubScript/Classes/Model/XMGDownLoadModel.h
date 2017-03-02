//
//  XMGDownLoadModel.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "tracks": {
 "list": [{
 "albumId": 3404911,
 "albumImage": "http://fdfs.xmcdn.com/group9/M02/1D/77/wKgDZlbifjGxoj7YAAAhU1pGnr8712_mobile_small.jpg",
 "albumTitle": "清华大学：心理学概论",
 "comments": 4674,
 "coverLarge": "http://fdfs.xmcdn.com/group9/M02/1D/77/wKgDZlbifjLRlu30AAAhU1pGnr8772_mobile_large.jpg",
 "coverMiddle": "http://fdfs.xmcdn.com/group9/M02/1D/77/wKgDZlbifjLRlu30AAAhU1pGnr8772_web_large.jpg",
 "coverSmall": "http://fdfs.xmcdn.com/group9/M02/1D/77/wKgDZlbifjLRlu30AAAhU1pGnr8772_web_meduim.jpg",
 "createdAt": 1450954448000,
 "downloadAacSize": 4146261,
 "downloadAacUrl": "http://download.xmcdn.com/group11/M07/E0/47/wKgDbVZ7zYyR52OsAD9EVdeTP4M722.m4a",
 "downloadSize": 5574636,
 "downloadUrl": "http://download.xmcdn.com/group8/M02/D4/C5/wKgDYFZ7zYbyhKjrAFUP7BI7kr8685.aac",
 "duration": 1343.029999999999972715158946812152862548828125,
 "isPublic": true,
 "likes": 3924,
 "nickname": "学堂在线",
 "opType": 1,
 "orderNum": 0,
 "playPathAacv164": "http://audio.xmcdn.com/group11/M07/C7/59/wKgDa1Z7zZLT3ZcwAKW9wSWxAUM889.m4a",
 "playPathAacv224": "http://audio.xmcdn.com/group11/M07/E0/47/wKgDbVZ7zYyR52OsAD9EVdeTP4M722.m4a",
 "playUrl32": "http://fdfs.xmcdn.com/group11/M07/E0/47/wKgDbVZ7zZPijcunAFH5e-mOxoA724.mp3",
 "playUrl64": "http://fdfs.xmcdn.com/group11/M07/E0/47/wKgDbVZ7zYviwdeBAKPyycd6pwM706.mp3",
 "playtimes": 1314804,
 "processState": 2,
 "shares": 0,
 "smallLogo": "http://tp1.sinaimg.cn/5149707292/30/5718529644/0",
 "status": 1,
 "title": "1-8分钟带你了解人体五大感觉系统",
 "trackId": 11044072,
 "uid": 37561485,
 "userSource": 1
 },
 */

@interface XMGDownLoadModel : NSObject
@property (nonatomic, copy) NSString *title;
@end
