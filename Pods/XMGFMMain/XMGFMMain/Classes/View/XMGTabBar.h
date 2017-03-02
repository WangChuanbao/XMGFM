//
//  XMGTbabBar.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGMiddleView;
@interface XMGTabBar : UITabBar

@property (nonatomic, weak) XMGMiddleView *middleView;

/**
 点击中间按钮的执行代码块
 */
@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);



@end
