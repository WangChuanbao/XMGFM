//
//  XMGFocusImageModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGFocusImageModel : NSObject


@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *shortTitle;
@property (nonatomic, copy) NSString *longTitle;
@property (nonatomic, copy) NSString *pic;

/**
 *  type == 2 : 跳转到简介
 *  type == 9 : 听单
 *  type == 3 : 播放专辑
 *  
 */
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) BOOL isShare;
@property (nonatomic, assign) BOOL is_External_url;
@property (nonatomic, copy) NSString *url;

@end
