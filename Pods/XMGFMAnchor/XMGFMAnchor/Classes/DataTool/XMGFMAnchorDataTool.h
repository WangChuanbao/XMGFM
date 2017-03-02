//
//  XMGFMAnchorDataTool.h
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import <Foundation/Foundation.h>
#import "XMGFMAnchorGroupModel.h"


@interface XMGFMAnchorDataTool : NSObject
+ (instancetype)shareInstance;

- (void)getAnchorMs:(void(^)(NSArray <XMGFMAnchorGroupModel *>*anchorMs))resultBlock;

@end
