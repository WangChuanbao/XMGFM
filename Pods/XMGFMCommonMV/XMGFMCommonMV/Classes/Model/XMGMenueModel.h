//
//  XMGMenueModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMGMenueModel : NSObject

@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy, getter=imageURL) NSString *coverPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void(^clickBlock)();

@end
