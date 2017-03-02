//
//  XMGHomeTabModel.h
//  XMGFM
//
//  Created by 王顺子 on 16/10/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMGSegmentModelProtocol;
@interface XMGHomeTabModel : NSObject<XMGSegmentModelProtocol>

/** 选项卡的ID, 如果不设置, 默认是索引值(从0开始) */
@property (nonatomic, assign) NSInteger segID;

/**
 内容类型
 */
@property (nonatomic, copy) NSString *contentType;

/**
 标题
 */
@property (nonatomic, copy, getter=segContent) NSString *title;

@end
