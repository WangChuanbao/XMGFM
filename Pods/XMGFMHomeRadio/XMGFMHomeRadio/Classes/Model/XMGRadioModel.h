//
//  XMGLocalRadioModel.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGRadioPlayUrlModel.h"

@interface XMGRadioModel : NSObject

@property (nonatomic, copy)NSString *coverLarge;
@property (nonatomic, copy)NSString *coverSmall;
@property (nonatomic, assign) int fmUid;
@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int playCount;
@property (nonatomic, assign) int programId;
@property (nonatomic, copy)NSString *programName;
@property (nonatomic, assign) int programScheduleId;

@property (nonatomic, strong) XMGRadioPlayUrlModel *playUrl;
@end
