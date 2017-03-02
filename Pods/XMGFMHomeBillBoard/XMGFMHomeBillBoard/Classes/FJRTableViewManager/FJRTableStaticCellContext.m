//
//  FJRTableStaticCellContext.m
//  FengjrMobile
//
//  Created by 张九州 on 16/2/29.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import "FJRTableStaticCellContext.h"

@interface FJRTableStaticCellContext ()

@property (nonatomic, assign) Class class;
@property (nonatomic, assign) CGFloat height;

@end

@implementation FJRTableStaticCellContext

+ (instancetype)contextWithCellClass:(Class)cellClass height:(CGFloat)height
{
    FJRTableStaticCellContext *context = [FJRTableStaticCellContext new];
    context.class = cellClass;
    context.height = height;
    return context;
}

- (Class)cellClass
{
    return self.class;
}

- (CGFloat)height
{
    return self.height;
}

@end
