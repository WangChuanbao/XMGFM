//
//  XMGTitleScrollView.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTitleScrollView.h"
#import "UIView+XMGLayout.h"

@interface XMGTitleScrollView()

@property (nonatomic, weak) UILabel *titleLabel;


@end

@implementation XMGTitleScrollView


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)setShowContent:(NSString *)showContent
{
    _showContent = showContent;

    [self.titleLabel removeFromSuperview];

    // 创建一个label, 添加到资深
    UILabel *contentLabel = [[UILabel alloc] init];
    self.titleLabel = contentLabel;
    contentLabel.text = _showContent;
    [contentLabel sizeToFit];

    [self addSubview:contentLabel];
    self.contentSize = CGSizeMake(contentLabel.frame.size.width, 0);


    [contentLabel.layer removeAnimationForKey:@"yidong"];

    if (self.contentSize.width > self.width) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.values = @[@0, @(-(self.contentSize.width - self.width)), @0];
        animation.duration = showContent.length * 1;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        [contentLabel.layer addAnimation:animation forKey:@"yidong"];
    }


}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.centerY = self.height * 0.5;

}

@end
