//
//  XMGRecodHeader.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGRecodHeader : UIView

//更新时间
- (void)updateTime;
//设置logo图标
- (void)setLoginHidden:(BOOL)isHidden;
//设置声音
- (void)setVoice;

//重录
- (void)restoreAll;


@end

