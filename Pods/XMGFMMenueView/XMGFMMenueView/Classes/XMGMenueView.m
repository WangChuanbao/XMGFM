//
//  XMGMenueView.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMenueView.h"
#import "XMGUpDownBtn.h"

#define kMenueWidth 60
#define kMenueMargin 20


@implementation XMGMenueView

-(void)setMenueModels:(NSArray<id<XMGMenueModelProtocol>> *)menueModels
{
    _menueModels = menueModels;

    // 1. 移除所有之前的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSInteger count = menueModels.count;
    for(int i = 0;i < count; i++)
    {
        id<XMGMenueModelProtocol> model= menueModels[i];
        XMGUpDownBtn *btn = [[XMGUpDownBtn alloc] init];
        if (self.loadBlock) {
            self.loadBlock(btn, [NSURL URLWithString:model.imageURL]);
        }
        [btn setTitle:model.title forState:UIControlStateNormal];
        btn.tag = self.subviews.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

        [self addSubview:btn];

    }

    [self setNeedsLayout];


}

- (void)btnClick: (XMGUpDownBtn *)upDownBtn {

    NSInteger tag = upDownBtn.tag;
    id<XMGMenueModelProtocol> menueModel = self.menueModels[tag];
    if(menueModel.clickBlock != nil)
    {
        menueModel.clickBlock();
    }

}



-(void)layoutSubviews {
    [super layoutSubviews];

    NSInteger count = self.menueModels.count;
    CGFloat h = self.frame.size.height;
    for(int i = 0; i < count; i++)
    {
        UIView *subView = self.subviews[i];
        subView.frame = CGRectMake(i * (kMenueWidth + kMenueMargin) + kMenueMargin, 0, kMenueWidth, h);
    }

    self.contentSize = CGSizeMake((kMenueWidth + kMenueMargin) * count + kMenueMargin, 0);
}


@end
