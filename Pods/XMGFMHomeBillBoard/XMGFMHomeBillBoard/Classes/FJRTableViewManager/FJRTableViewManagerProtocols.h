//
//  FJRTableViewManagerProtocols.h
//  FJRTableViewManager
//
//  Created by 张九州 on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FJRTableRowContext <NSObject>

- (Class)cellClass;

@optional

@property (nonatomic, weak) UITableView *tableView;

- (CGFloat)rowHeight;

@end

@protocol FJRTableSectionViewContext <NSObject>

@optional

@property (nonatomic, weak) UITableView *tableView;

- (Class)viewClass;
- (CGFloat)viewHeight;

@end

@protocol FJRTableCell <NSObject>

@optional
- (void)setContext:(id<FJRTableRowContext>)context;
- (void)willDisplay;
- (void)didEndDisplay;
- (void)didSelect;
- (void)didDeselect;

@end

@protocol FJRTableSectionView <NSObject>

@optional
- (void)setContext:(id<FJRTableSectionViewContext>)context;
- (void)willDisplay;
- (void)didEndDisplay;

@end

