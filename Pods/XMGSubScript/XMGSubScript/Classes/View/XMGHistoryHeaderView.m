//
//  XMGHistoryHeaderView.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import "XMGHistoryHeaderView.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@implementation XMGHistoryHeaderView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.width = kScreenWidth;
    self.height = 44;
}

- (IBAction)headerButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(historyHeaderViewDidClickHeaderButton:)]) {
        [self.delegate historyHeaderViewDidClickHeaderButton:sender.titleLabel.text];
    }
}


@end
