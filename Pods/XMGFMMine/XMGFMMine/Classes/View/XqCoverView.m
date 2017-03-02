//
//  XqCoverView.m
//  觅城
//
//  Created by 弓虽_子 on 16/6/19.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import "XqCoverView.h"

@implementation XqCoverView
/**
 *  显示遮盖
 */
+ (instancetype)show {
    //添加到窗口
    XqCoverView *cover =  [[self alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
       cover.alpha = 0.5;
    }];
    //添加到窗口
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;
}


/**
 *  隐藏遮盖
 */
+ (void)hiddenCover {
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[XqCoverView class]]) {
            
            [UIView animateWithDuration:0.25 animations:^{
                //让遮盖成为透明.
                view.alpha = 0;
            }completion:^(BOOL finished) {
                //透明完成时,移除遮盖
                [view removeFromSuperview];
            }];
        }
    }
}


//点击遮盖
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //调用代理方法.
    if ([self.delegate respondsToSelector:@selector(coverViewClick:)]) {
        [self.delegate coverViewClick:self];
    }
}
@end
