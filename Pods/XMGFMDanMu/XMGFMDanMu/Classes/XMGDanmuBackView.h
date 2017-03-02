//
//  XMGDanmuBackView.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/9/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGDanmuProtocol.h"

#define kDanmuStateChangeNotification @"danmuStateChange"

@protocol XMGDanmuBackViewRequiredProtocol <NSObject>

/** 当前时间, 内部会每隔一秒读取一次这个数值, 来决定弹幕的展示 */
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;

/** 根据弹幕模型 获取弹幕视图来展示 */
- (UIView *)danmuViewWithDanmuM: (id<XMGDanmuProtocol>)danmuM;;

/** 点击了某个弹幕,需要做的事情 */
- (void)danmuViewDidClick: (UIView *)danmuView pointInBackView: (CGPoint)point;

@end


@interface XMGDanmuBackView : UIView

@property (nonatomic, strong) id<XMGDanmuBackViewRequiredProtocol> requireDelegate;

@property (nonatomic, strong) NSMutableArray <id<XMGDanmuProtocol>>*danmuMs;

- (void)clear;
- (void)pause;
- (void)resume;




@end
