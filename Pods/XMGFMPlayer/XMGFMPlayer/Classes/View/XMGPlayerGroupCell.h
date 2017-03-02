//
//  XMGPlayerGroupCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGPlayerGroupModel.h"
#import "XMGPlayerCommentGroupModel.h"

@interface XMGPlayerGroupCell : UITableViewCell

@property (nonatomic, strong) XMGPlayerGroupModel *associationAlbumGroupM;

@property (nonatomic, strong) XMGPlayerCommentGroupModel *commentGroupM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
