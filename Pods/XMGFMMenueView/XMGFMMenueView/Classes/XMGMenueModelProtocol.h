
//
//  XMGMenueModelProtocol.h
//  控件封装
//
//  Created by 王顺子 on 16/9/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

@protocol XMGMenueModelProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) void(^clickBlock)();

@end
