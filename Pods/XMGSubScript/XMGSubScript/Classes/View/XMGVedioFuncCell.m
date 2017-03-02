//
//  XMGVedioFuncCell.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGVedioFuncCell.h"

@interface XMGVedioFuncCell()
@property (strong, nonatomic) IBOutlet UILabel *setNumLabel;
@property (strong, nonatomic) IBOutlet UIButton *sortButton;

@end

@implementation XMGVedioFuncCell

// 选集
- (IBAction)chooseButtonClick:(UIButton *)sender {
    if (sender.selected) {
        self.sortButton.userInteractionEnabled = NO;
    }else
    {
        self.sortButton.userInteractionEnabled = YES;
    }
    
}

// 排序
- (IBAction)sortButtonClick:(UIButton *)sender {
    
}

@end
