//
//  XMGOpenTipView.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGOpenTipView.h"
#import "XqCoverView.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGOpenTipView()

@property (weak, nonatomic) IBOutlet UILabel *ipAddress;


@end

@implementation XMGOpenTipView


- (void)setIP:(NSString *)IP {
    
    _IP = IP;
    self.ipAddress.text = IP;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)closeBtnClick:(id)sender {
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[XMGOpenTipView class]]) {
            [UIView animateWithDuration:0.25 animations:^{
                view.y = kScreenHeight;
            }completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
        if ([view isKindOfClass:[XqCoverView class]]) {
            [UIView animateWithDuration:0.25 animations:^{
                view.alpha = 0;
            }completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }
    
    //点击关闭了
    if (self.didCloseTask) {
        self.didCloseTask();
    }
    
    
}

+ (instancetype)showTipView {

    XMGOpenTipView *tipView = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGOpenTipView" owner:nil options:nil] firstObject];

    tipView.width = kScreenWidth;
    tipView.y = kScreenHeight;
    [UIView animateWithDuration:0.25 animations:^{
        tipView.y = kScreenHeight - tipView.height;
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:tipView];
    return tipView;
}






@end
