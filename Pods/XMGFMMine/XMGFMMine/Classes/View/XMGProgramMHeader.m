//
//  XMGProgramMHeader.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGProgramMHeader.h"

@interface XMGProgramMHeader ()

@property (nonatomic,weak) IBOutlet UIImageView *iconImageview;

@end

@implementation XMGProgramMHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageview.layer.cornerRadius = 25;
    self.iconImageview.layer.masksToBounds = YES;
    self.iconImageview.layer.borderWidth = 2;
    self.iconImageview.layer.borderColor = [UIColor whiteColor].CGColor;

}


+ (instancetype)programHeader {

    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGProgramMHeader" owner:nil options:nil] firstObject];

}


@end
