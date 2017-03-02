//
//  NSArray+XMGPartition.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XMGPartition)

/**
 *  将一个数组切割成多个数组
 *
 *  @param start 从第几个元素开始分割
 *  @param count 每个数组最大个数
 *
 *  @return 切割好的数组
 */
- (NSArray *)partitionArrayWithStart:(NSInteger)start Count:(NSInteger)count;

@end
