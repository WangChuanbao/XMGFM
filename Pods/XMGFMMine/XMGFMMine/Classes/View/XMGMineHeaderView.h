//
//  XMGMineHeaderView.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGMineHeaderView : UIView

/**
 *  从xib中创建一个nib视图
 */
+ (instancetype)mineHeaderView;

//节目管理
@property (nonatomic, copy) void(^programClickTask)();

//录音
@property (nonatomic, copy) void(^recordClickTask)();

//设置点击
@property (nonatomic, copy) void(^settingClickTask)();

@end
