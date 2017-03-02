//
//  XMGUpDownBtn.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGUpDownBtn.h"

@interface XMGUpDownBtn()

@property (nonatomic, assign) CGFloat radio;

@end

@implementation XMGUpDownBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];

    }
    return self;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

-(CGFloat)radio {
    return 0.7;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{

    return CGRectMake(0, contentRect.size.height * self.radio, contentRect.size.width, contentRect.size.height * (1 - self.radio));

}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{

    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * self.radio);

}




@end
