//
//  XMGTrackRewardInfoModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGRewardModel.h"


@interface XMGTrackRewardInfoModel : NSObject

@property (nonatomic, assign) NSInteger trackID;

@property (nonatomic, copy) NSString *voiceIntro;

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger numOfRewards;
@property (nonatomic, strong) NSArray <XMGRewardModel *>*rewords;


@end
