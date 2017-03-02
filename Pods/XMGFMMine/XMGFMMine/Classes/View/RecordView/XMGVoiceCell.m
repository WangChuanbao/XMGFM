//
//  XMGVoiceCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGVoiceCell.h"

@interface XMGVoiceCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;

@end

@implementation XMGVoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setVoiceNum:(CGFloat)height {
    
    self.heightCons.constant = height;
    [self setNeedsLayout];
}

@end
