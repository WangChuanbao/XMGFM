//
//  XMGMyOrderReader.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGAudioListModel : NSObject

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) NSInteger serialState;

@property (nonatomic, assign) NSInteger tracks;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger updatedAt;


@property (nonatomic, assign) BOOL hasNew;


@property (nonatomic, assign) BOOL isPaid;



@property (nonatomic, copy) NSString *coverMiddle;

@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, copy) NSString *lastUptrackTitle;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *trackTitle;


+ (NSArray *)historyList;


+ (NSArray *)supportList;



@end
