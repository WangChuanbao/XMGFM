//
//  XMGSettingCell.h
//  彩票
//
//  Created by 弓虽_子 on 16/3/6.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGSettingRowItem;
@interface XMGSettingCell : UITableViewCell

//传一个TableView,和指定类型创建一个XMGSettingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)style;

//根据传入的模型决定Cell显示什么样的内容
@property (nonatomic, strong) XMGSettingRowItem *rowItem;

@end
