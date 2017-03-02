//
//  XMGDanmuProtocol.h
//  控件封装
//
//  Created by 王顺子 on 16/9/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

@protocol XMGDanmuProtocol <NSObject>

/** 头像地址 */
@property (nonatomic, copy) NSString *headerIconUrl;

/** 弹幕内容, 可展示富文本 */
@property (nonatomic, copy) NSMutableAttributedString *attributeContent;


/** 开始时间 */
@property (nonatomic, assign) NSTimeInterval beginTime;

/** 存活时间 */
@property (nonatomic, assign, readonly) NSTimeInterval liveTime;

@end
