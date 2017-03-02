//
//  XMGAdPicModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGFocusImageModel.h"
#import "XMGLiveModel.h"
#import "XMGTuiguangModel.h"
#import "XMGClassItemModel.h"


@interface XMGAdPicModel : NSObject

@property (nonatomic, strong) XMGFocusImageModel *focusImageM;

@property (nonatomic, strong) XMGLiveModel *liveM;

@property (nonatomic, strong) XMGTuiguangModel *tuiguangM;

@property (nonatomic, strong) XMGClassItemModel *classItemM;



/**
 *  广告图片URL
 */
@property (nonatomic, copy) NSURL *adImgURL;

/**
 *  点击广告, 需要跳转的URL
 */
@property (nonatomic, copy) NSURL *adLinkURL;

/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickBlock)();

@end
