//
//  XMGCategoriesBtn.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCategoriesBtn.h"

@interface XMGCategoriesBtn()

@property (nonatomic, assign) CGFloat radio;

@end

@implementation XMGCategoriesBtn

-(void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
}

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
