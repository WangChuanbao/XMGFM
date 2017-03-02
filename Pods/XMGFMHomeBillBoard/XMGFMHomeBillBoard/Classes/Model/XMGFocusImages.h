//
//  XMGFocusImages.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGFocusImageModel;

@interface XMGFocusImages : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <XMGFocusImageModel *>*list;
@property (nonatomic, assign)NSInteger retp;

@property (nonatomic, assign)NSInteger count;

@end
