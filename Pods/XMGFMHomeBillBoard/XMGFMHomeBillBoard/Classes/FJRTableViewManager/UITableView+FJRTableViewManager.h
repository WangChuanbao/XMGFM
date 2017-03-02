//
//  UITableView+FJRTableViewManager.h
//  FengjrMobile
//
//  Created by 张九州 on 16/2/25.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FJRTableViewManagerException @"FJRTableViewManagerException"

@class FJRTableSection;
@class FJRTableRow;

@interface UITableView (FJRTableViewManager)

- (void)fjr_reloadDataWithBlock:(void (^)(void))block;

- (void)fjr_insertSection:(FJRTableSection *)section atIndex:(NSInteger)index;
- (void)fjr_addSection:(FJRTableSection *)section;
- (void)fjr_reloadSection:(FJRTableSection *)section;
- (void)fjr_deleteSection:(FJRTableSection *)section;

- (void)fjr_insertRow:(FJRTableRow *)row atIndex:(NSInteger)index inSection:(FJRTableSection *)section;
- (void)fjr_addRow:(FJRTableRow *)row inSection:(FJRTableSection *)section;
- (void)fjr_reloadRow:(FJRTableRow *)row;
- (void)fjr_deleteRow:(FJRTableRow *)row;

- (NSInteger)fjr_numberOfSections;
- (NSInteger)fjr_numberOfRowsInSection:(NSInteger)sectionIndex;

- (UITableViewCell *)fjr_cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)fjr_viewForHeaderInSection:(NSInteger)sectionIndex;
- (UIView *)fjr_viewForFooterInSection:(NSInteger)sectionIndex;

- (CGFloat)fjr_heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)fjr_heightForHeaderInSection:(NSInteger)sectionIndex;
- (CGFloat)fjr_heightForFooterInSection:(NSInteger)sectionIndex;

- (void)fjr_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)fjr_didEndDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)fjr_willDisplayHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex;
- (void)fjr_didEndDisplayHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex;
- (void)fjr_willDisplayFooterView:(UIView *)view forSection:(NSInteger)sectionIndex;
- (void)fjr_didEndDisplayFooterView:(UIView *)view forSection:(NSInteger)sectionIndex;

- (void)fjr_didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)fjr_didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
