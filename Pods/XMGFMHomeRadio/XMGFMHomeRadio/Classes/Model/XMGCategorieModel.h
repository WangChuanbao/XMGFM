//
//  XMGcategorieModel.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGCategorieModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isLast; // 用于表示是否最后一个

@end
