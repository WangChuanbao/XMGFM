//
//  XMGCellInCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGSpecialColumnModel.h"

@interface XMGCellInCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) XMGSpecialColumnModel *specialColumnM;

@end
