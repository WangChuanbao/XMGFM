//
//  XMGCommentCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGCommentInfoModel.h"


@interface XMGCommentCell : UITableViewCell

@property (nonatomic, strong) XMGCommentInfoModel *commentInfoM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
