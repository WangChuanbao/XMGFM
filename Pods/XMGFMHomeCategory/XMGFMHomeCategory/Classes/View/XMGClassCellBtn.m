//
//  XMGClassCellBtn.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGClassCellBtn.h"
#import "UIView+XMGLayout.h"

@implementation XMGClassCellBtn


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(self.width * 0.2, self.centerY / 2, 25, 25);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width * 0.4, 0, self.width, self.height);
}


@end
