//
//  XMGRewardModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRewardModel : NSObject


@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) double paymentTime;
@property (nonatomic, assign) double sn;
@property (nonatomic, copy) NSString *smallLogo;

@end
