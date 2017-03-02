//
//  XMGOpenTipView.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGOpenTipView : UIView


+ (instancetype)showTipView;

@property (nonatomic, copy) void(^didCloseTask)();

@property (nonatomic, copy) NSString *IP;


@end
