//
//  XMGFMHomeDataTool.h
//  XMGFM
//
//  Created by 王顺子 on 16/10/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "XMGHomeTabModel.h"

@interface XMGFMHomeDataTool : NSObject
+ (instancetype)shareInstance;

- (void)getHomeTabs: (void(^)(NSArray <XMGHomeTabModel *>*tabMs))resultBlock;

@end
