//
//  XMGSubscribeAlertView.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import "XMGSubscribeAlertView.h"

@implementation XMGSubscribeAlertView

- (IBAction)alertButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subscribeAlertViewDidClickAlertButton:)]) {
        [self.delegate subscribeAlertViewDidClickAlertButton:sender.titleLabel.text];
    }
}

@end
