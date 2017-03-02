//
//  XMGFriendListM.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGFriendListM : NSObject

//声音个数
@property (nonatomic, assign) NSInteger albums;
//粉丝
@property (nonatomic, assign) NSInteger followers;
//关注个数
@property (nonatomic, assign) NSInteger followings;

@property (nonatomic, assign) BOOL isFollowed;

@property (nonatomic, assign) BOOL isVerified;

@property (nonatomic, assign) int shares;


@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *personDescribe;

//
@property (nonatomic, copy) NSString *personalSignature;

//描述
@property (nonatomic, copy) NSString *ptitle;

//小图标
@property (nonatomic, copy) NSString *smallLogo;

//声音
@property (nonatomic, assign) NSInteger tracks;

@property (nonatomic, assign) NSInteger uid;

+ (NSArray *)getFriendsList;


@end
