//
//  XMGFNAnchorGroupModel.h
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import <Foundation/Foundation.h>
#import "XMGFMAnchorModel.h"

@interface XMGFMAnchorGroupModel : NSObject

@property (nonatomic, assign) NSInteger id;

// 1. 六个, 2, 列表
@property (nonatomic, assign) NSInteger displayStyle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong, getter=anchorMs) NSArray <XMGFMAnchorModel *>*list;


/// 计算属性, 可以快速获取对应行的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
