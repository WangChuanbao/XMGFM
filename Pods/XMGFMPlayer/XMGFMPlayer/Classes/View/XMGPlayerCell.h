//
//  XMGPlayerCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGAlbumInfoModel.h"


@interface XMGPlayerCell : UITableViewCell

@property (nonatomic, strong) XMGAlbumInfoModel *albumInfoM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
