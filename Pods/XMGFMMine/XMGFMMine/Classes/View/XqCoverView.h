//
//  XqCoverView.h
//  觅城
//
//  Created by 弓虽_子 on 16/6/19.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XqCoverView;
@protocol XqCoverViewDelegate <NSObject>

- (void)coverViewClick:(XqCoverView *)coverView;

@end



@interface XqCoverView : UIView
/**
 *  显示遮盖
 */
+ (instancetype)show;

/**
 *  隐藏遮盖
 */
+ (void)hiddenCover;

@property(nonatomic, weak) id<XqCoverViewDelegate> delegate;


@end
