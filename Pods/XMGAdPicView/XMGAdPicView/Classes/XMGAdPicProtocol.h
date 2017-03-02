//
//  XMGAdPicProtocol.h
//  控件封装
//
//  Created by 王顺子 on 16/9/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

@protocol XMGAdPicProtocol <NSObject>

/**
 *  广告图片URL
 */
@property (nonatomic, copy, readonly) NSURL *adImgURL;


/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickBlock)();

@end
