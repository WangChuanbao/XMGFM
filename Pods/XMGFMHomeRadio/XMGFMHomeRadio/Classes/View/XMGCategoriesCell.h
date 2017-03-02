//
//  XMGCategoriesCell.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGCategorieModel.h"

@interface XMGCategoriesCell : UICollectionViewCell

@property (nonatomic, strong)XMGCategorieModel *model;

- (void)up;
- (void)down;

@end
