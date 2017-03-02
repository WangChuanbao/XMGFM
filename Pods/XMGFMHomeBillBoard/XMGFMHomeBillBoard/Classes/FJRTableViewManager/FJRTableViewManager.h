//
//  FJRTableViewManager.h
//  FJRTableViewManager
//
//  Created by 张九州 on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITableView+FJRTableViewManager.h"
#import "FJRTableSection.h"
#import "FJRTableRow.h"
#import "FJRTableViewManagerProtocols.h"
#import "FJRTableStaticCellContext.h"
#import "FJRTableBlankSectionViewContext.h"

@interface FJRTableViewManager : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype) initWithTableView:(UITableView *)tableView;

@end
