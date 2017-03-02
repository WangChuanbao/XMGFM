//
//  XMGCategoriesView.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGCategorieModel;
@class XMGCategoriesCell;

typedef void(^selectorItemBlock)(XMGCategoriesCell *cell, NSIndexPath *indexPath);

@interface XMGCategoriesView : UIView



@property (nonatomic, strong)NSMutableArray<XMGCategorieModel *> *categorieMs;

@property (nonatomic, copy) selectorItemBlock selectorItemBlock;

@end
