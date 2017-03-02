//
//  XMGDanmuView.h
//  弹幕测试
//
//  Created by 王顺子 on 16/9/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGDanmuProtocol.h"


typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@interface XMGDanmuView : UIView

+ (instancetype)danmuViewWithDanmuM:(id<XMGDanmuProtocol>)danmuM;

@property (nonatomic, strong) id<XMGDanmuProtocol> danmuM;

/**
 *  用于加载图片的代码块, 必须赋值
 */
@property (nonatomic, copy) LoadImageBlock loadBlock;

// 在某个位置显示星星
- (void)showStars:(CGPoint)point;


@end
