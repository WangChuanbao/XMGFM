//
//  XMGRadioModels.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XMGRadioModel;
@interface XMGRadioModels : NSObject

@property (nonatomic, assign) int sortID;
@property (nonatomic, copy)NSString *location;
@property (nonatomic, strong)NSArray <XMGRadioModel *>*models;

@end