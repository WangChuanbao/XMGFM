//
//  FJRTableRow.m
//  FengjrMobile
//
//  Created by 张九州 on 16/2/25.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import "FJRTableRow.h"

@interface FJRTableRow ()

@property (nonatomic, strong) id<FJRTableRowContext> context;
@property (nonatomic, weak) FJRTableSection *section;

@end

@implementation FJRTableRow

+ (instancetype)rowWithContext:(id<FJRTableRowContext>)context
{
    return [[self alloc] initWithContext:context];
}

- (instancetype)initWithContext:(id<FJRTableRowContext>)context
{
    NSAssert(context != nil, nil);

    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

@end
