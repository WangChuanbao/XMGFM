//
//  XMGSupportModel.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSupportModel : NSObject

@property (nonatomic, assign) int albumId;

@property (nonatomic, assign) int categoryId;

@property (nonatomic, assign) int comments;

@property (nonatomic, assign) int likes;

@property (nonatomic, assign) int playtimes;

@property (nonatomic, assign) int shares;

@property (nonatomic, assign) int trackId;

@property (nonatomic, assign) int uid;

@property (nonatomic, assign) int userSource;

@property (nonatomic, copy) NSString *coverLarge;

@property (nonatomic, copy) NSString *coverMiddle;

@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, copy) NSString *playPathAacv164;

@property (nonatomic, copy) NSString *playPathAacv224;

@property (nonatomic, copy) NSString *playPathHq;

@property (nonatomic, copy) NSString *playUrl32;

@property (nonatomic, copy) NSString *playUrl64;

@property (nonatomic, copy) NSString *smallLogo;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *nickname;

+ (NSArray *)supportList;

@end
