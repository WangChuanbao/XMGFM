//
//  FJRTableBlankHeaderViewContext.m
//  FengjrMobile
//
//  Created by 张九州 on 16/2/29.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import "FJRTableBlankSectionViewContext.h"

@interface FJRTableBlankSectionViewContext ()

@property (nonatomic, assign) CGFloat height;

@end

@implementation FJRTableBlankSectionViewContext

+ (instancetype)contextWithHeight:(CGFloat)height
{
    FJRTableBlankSectionViewContext *context = [FJRTableBlankSectionViewContext new];
    context.height = height;
    return context;
}

- (CGFloat)viewHeight
{
    return self.height;
}

@end
