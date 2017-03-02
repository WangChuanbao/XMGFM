//
//  XMGBaseSettingVC.h
//  彩票
//
//  Created by 弓虽_子 on 16/3/6.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMGArrowRowItem.h"
#import "XMGSwitchItem.h"

#import "XMGSettingGroupItem.h"
#import "XMGSettingRowItem.h"
#import "XMGSettingCell.h"

@interface XMGBaseSettingVC : UITableViewController

//存放组模型的数组
@property (nonatomic , strong) NSMutableArray *groupArray;


@end
