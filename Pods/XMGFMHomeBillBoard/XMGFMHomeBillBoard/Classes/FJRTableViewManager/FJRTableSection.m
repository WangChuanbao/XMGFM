//
//  FJRTableSection.m
//  FengjrMobile
//
//  Created by 张九州 on 16/2/25.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import "FJRTableSection.h"

@interface FJRTableSection ()

@property (nonatomic, strong) id<FJRTableSectionViewContext> headerContext;
@property (nonatomic, strong) id<FJRTableSectionViewContext> footerContext;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FJRTableSection

+ (instancetype)section
{
    return [[self alloc] init];
}

+ (instancetype)sectionWithHeaderContext:(id<FJRTableSectionViewContext>)headerContext footerContext:(id<FJRTableSectionViewContext>)footerContext
{
    FJRTableSection *section = [self section];
    section.headerContext = headerContext;
    section.footerContext = footerContext;
    return section;
}

@end
