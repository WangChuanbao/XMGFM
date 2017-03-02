//
//  XMGEmptyView.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGEmptyView.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGEmptyView ()

@property (nonatomic,weak) UIImageView *imageV;

@end

@implementation XMGEmptyView

- (instancetype)initWithEmptyWithImageName:(NSString *)imageName {
    
    if (self = [super init]) {
        
        self.bounds = CGRectMake(0, 0, 170, 250);
        self.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.35);
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:imageName];
        imageV.width = self.width;
        imageV.height = self.height * 0.6;
        [self addSubview:imageV];
        self.imageV = imageV;
        
    }
    return self;
}





@end
