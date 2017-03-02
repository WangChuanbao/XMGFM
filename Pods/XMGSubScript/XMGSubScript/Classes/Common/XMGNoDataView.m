//
//  XMGNoDataView.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import "XMGNoDataView.h"

@implementation XMGNoDataView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.gotoRecommendButton.layer.cornerRadius = 4;
    self.gotoRecommendButton.layer.masksToBounds = YES;
}

@end
