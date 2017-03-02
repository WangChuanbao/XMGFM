//
//  XMGFMSingerGroupCell.h
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import <UIKit/UIKit.h>
#import "XMGFMAnchorGroupModel.h"

@interface XMGFMSingerGroupCell : UITableViewCell

+ (instancetype)cellWithTableView: (UITableView *)tableView;

@property (nonatomic, strong) XMGFMAnchorGroupModel *anchorGroupM;

@end
