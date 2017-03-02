//
//  XMGFMAnchorGroupCell.h
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import <UIKit/UIKit.h>
#import "XMGFMAnchorGroupModel.h"


@interface XMGFMAnchorGroupCell : UITableViewCell

+ (instancetype)cellWithTableView: (UITableView *)tableView;

@property (nonatomic, strong) XMGFMAnchorGroupModel *anchorGroupM;


@end
