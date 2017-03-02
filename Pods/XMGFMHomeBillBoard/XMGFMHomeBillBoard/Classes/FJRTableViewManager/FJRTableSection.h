//
//  FJRTableSection.h
//  FengjrMobile
//
//  Created by 张九州 on 16/2/25.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FJRTableViewManagerProtocols.h"

@interface FJRTableSection : NSObject

@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) id<FJRTableSectionViewContext> headerContext;
@property (nonatomic, strong, readonly) id<FJRTableSectionViewContext> footerContext;

+ (instancetype)section;
+ (instancetype)sectionWithHeaderContext:(id<FJRTableSectionViewContext>)headerContext footerContext:(id<FJRTableSectionViewContext>)footerContext;

@end

