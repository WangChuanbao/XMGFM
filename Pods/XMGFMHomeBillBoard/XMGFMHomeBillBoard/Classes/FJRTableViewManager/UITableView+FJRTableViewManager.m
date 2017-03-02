//
//  UITableView+FJRTableViewManager.m
//  FengjrMobile
//
//  Created by 张九州 on 16/2/25.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import "UITableView+FJRTableViewManager.h"
#import <objc/runtime.h>
#import "FJRTableSection.h"
#import "FJRTableRow.h"
#import "FJRTableViewManagerProtocols.h"

@interface FJRTableSection (PrivateAccess)

@property (nonatomic, weak) UITableView *tableView;

@end

@interface FJRTableRow (PrivateAccess)

@property (nonatomic, weak) FJRTableSection *section;

@end

@interface FJRTableSection (Private)

@property (nonatomic, strong, readonly) NSMutableArray *rows;

@end

@implementation FJRTableSection (Private)

- (NSMutableArray *)rows
{
    NSMutableArray *rows = objc_getAssociatedObject(self, @selector(rows));
    if (!rows) {
        rows = [NSMutableArray array];
        objc_setAssociatedObject(self, @selector(rows), rows, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return rows;
}

@end

@interface UITableView ()

@property (nonatomic, strong) NSMutableArray *fjr_sections;
@property (nonatomic, assign) BOOL fjr_isReload;

@end

@implementation UITableView (FJRTableViewManager)

#pragma mark - setters & getters

- (NSMutableArray *)fjr_sections
{
    NSMutableArray *sections = objc_getAssociatedObject(self, @selector(fjr_sections));
    if (!sections) {
        sections = [NSMutableArray array];
        objc_setAssociatedObject(self, @selector(fjr_sections), sections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return sections;
}

- (void)setFjr_isReload:(BOOL)fjr_isReload
{
    objc_setAssociatedObject(self, @selector(fjr_isReload), @(fjr_isReload), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fjr_isReload
{
    return [objc_getAssociatedObject(self, @selector(fjr_isReload)) boolValue];
}

#pragma mark - operations

- (void)fjr_reloadDataWithBlock:(void (^)(void))block
{
    // 解除sections和rows的关联
    for (FJRTableSection *section in self.fjr_sections) {
        section.tableView = nil;
        if ([section.headerContext respondsToSelector:@selector(tableView)]) {
            section.headerContext.tableView = nil;
        }
        if ([section.footerContext respondsToSelector:@selector(tableView)]) {
            section.footerContext.tableView = nil;
        }

        for (FJRTableRow *row in section.rows) {
            row.section = nil;
            if ([row.context respondsToSelector:@selector(tableView)]) {
                row.context.tableView = nil;
            }
        }
    }

    [self.fjr_sections removeAllObjects];

    self.fjr_isReload = YES;
    block();
    self.fjr_isReload = NO;

    [self reloadData];
}

- (void)fjr_insertSection:(FJRTableSection *)section atIndex:(NSInteger)index
{
    if (section.tableView) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"cannot insert a section twice" userInfo:nil];
    }

    section.tableView = self;
    if ([section.headerContext respondsToSelector:@selector(tableView)]) {
        section.headerContext.tableView = self;
    }
    if ([section.footerContext respondsToSelector:@selector(tableView)]) {
        section.footerContext.tableView = self;
    }
    [self.fjr_sections insertObject:section atIndex:index];

    if (!self.fjr_isReload) {
        // tableview可能会自带一个section，这通常发生在viewDidLoad之后。而viewDidLoad之前不会出现那个自带的section。
        if (!(self.fjr_sections.count == 1 && self.numberOfSections == 1)) {
            [self insertSections:[NSIndexSet indexSetWithIndex:index]
                withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (void)fjr_addSection:(FJRTableSection *)section
{
    [self fjr_insertSection:section atIndex:self.fjr_sections.count];
}

- (void)fjr_reloadSection:(FJRTableSection *)section
{
    if (section.tableView != self) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"section is not in this tableview" userInfo:nil];
    }

    if (!self.fjr_isReload) {
        NSInteger index = [self.fjr_sections indexOfObject:section];
        [self reloadSections:[NSIndexSet indexSetWithIndex:index]
            withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)fjr_deleteSection:(FJRTableSection *)section
{
    if (section.tableView != self) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"section is not in this tableview" userInfo:nil];
    }

    section.tableView = nil;
    if ([section.headerContext respondsToSelector:@selector(tableView)]) {
        section.headerContext.tableView = nil;
    }
    if ([section.footerContext respondsToSelector:@selector(tableView)]) {
        section.footerContext.tableView = nil;
    }
    NSInteger index = [self.fjr_sections indexOfObject:section];
    [self.fjr_sections removeObjectAtIndex:index];

    if (!self.fjr_isReload) {
        [self deleteSections:[NSIndexSet indexSetWithIndex:index]
            withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)fjr_insertRow:(FJRTableRow *)row atIndex:(NSInteger)index inSection:(FJRTableSection *)section
{
    if (row.section) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"cannot insert a row twice" userInfo:nil];
    }
    if (section.tableView != self) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"section is not in this tableview" userInfo:nil];
    }

    row.section = section;
    if ([row.context respondsToSelector:@selector(tableView)]) {
        row.context.tableView = self;
    }
    [section.rows insertObject:row atIndex:index];
    if (!self.fjr_isReload) {
        [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:[self.fjr_sections indexOfObject:section]]]
                    withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)fjr_addRow:(FJRTableRow *)row inSection:(FJRTableSection *)section
{
    [self fjr_insertRow:row atIndex:section.rows.count inSection:section];
}

- (void)fjr_reloadRow:(FJRTableRow *)row
{
    if (row.section.tableView != self) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"row is not in this tableview" userInfo:nil];
    }

    if (!self.fjr_isReload) {
        [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[row.section.rows indexOfObject:row]
                                                          inSection:[self.fjr_sections indexOfObject:row.section]]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)fjr_deleteRow:(FJRTableRow *)row
{
    if (row.section.tableView != self) {
        @throw [NSException exceptionWithName:FJRTableViewManagerException reason:@"row is not in this tableview" userInfo:nil];
    }

    FJRTableSection *oldSection = row.section;
    row.section = nil;
    if ([row.context respondsToSelector:@selector(tableView)]) {
        row.context.tableView = nil;
    }
    NSInteger index = [row.section.rows indexOfObject:row];
    [oldSection.rows removeObjectAtIndex:index];

    if (!self.fjr_isReload) {
        [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:[self.fjr_sections indexOfObject:oldSection]]]
                    withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - table view datasource and delegate helpers

- (NSInteger)fjr_numberOfSections
{
    return self.fjr_sections.count;
}

- (NSInteger)fjr_numberOfRowsInSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    return section.rows.count;
}

- (UITableViewCell *)fjr_cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FJRTableSection *section = self.fjr_sections[indexPath.section];
    FJRTableRow *row = section.rows[indexPath.row];
    NSString *cellId = NSStringFromClass([row.context cellClass]);
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[row.context cellClass] alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}

- (UIView *)fjr_viewForHeaderInSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    if (section.headerContext && [section.headerContext respondsToSelector:@selector(viewClass)] && [section.headerContext viewClass]) {
        NSString *headerId = NSStringFromClass([section.headerContext viewClass]);
        UIView *view = [self dequeueReusableHeaderFooterViewWithIdentifier:headerId];
        if (!view) {
            view = [[[section.headerContext viewClass] alloc] init];
        }
        return view;
    } else {
        return nil;
    }
}

- (UIView *)fjr_viewForFooterInSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    if (section.footerContext && [section.footerContext respondsToSelector:@selector(viewClass)] && [section.footerContext viewClass]) {
        NSString *footerId = NSStringFromClass([section.footerContext viewClass]);
        UIView *view = [self dequeueReusableHeaderFooterViewWithIdentifier:footerId];
        if (!view) {
            view = [[[section.footerContext viewClass] alloc] init];
        }
        return view;
    } else {
        return nil;
    }
}

- (CGFloat)fjr_heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FJRTableSection *section = self.fjr_sections[indexPath.section];
    FJRTableRow *row = section.rows[indexPath.row];
    if ([row.context respondsToSelector:@selector(rowHeight)]) {
        return [row.context rowHeight];
    } else {
        return self.rowHeight;
    }
}

- (CGFloat)fjr_heightForHeaderInSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    if (section.headerContext && [section.headerContext respondsToSelector:@selector(viewHeight)]) {
        return [section.headerContext viewHeight];
    } else {
        return 0.1;
    }
}

- (CGFloat)fjr_heightForFooterInSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    if (section.footerContext && [section.footerContext respondsToSelector:@selector(viewHeight)]) {
        return [section.footerContext viewHeight];
    } else {
        return 0.1;
    }
}

- (void)fjr_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setContext:)]) {
        FJRTableSection *section = self.fjr_sections[indexPath.section];
        FJRTableRow *row = section.rows[indexPath.row];
        [cell performSelector:@selector(setContext:) withObject:row.context];
    }
    if ([cell respondsToSelector:@selector(willDisplay)]) {
        [cell performSelector:@selector(willDisplay)];
    }
}

- (void)fjr_didEndDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(didEndDisplay)]) {
        [cell performSelector:@selector(didEndDisplay)];
    }
}

- (void)fjr_willDisplayHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    if (section.headerContext && [view respondsToSelector:@selector(setContext:)]) {
        [view performSelector:@selector(setContext:) withObject:section.headerContext];
    }
    if ([view respondsToSelector:@selector(willDisplay)]) {
        [view performSelector:@selector(willDisplay)];
    }
}

- (void)fjr_didEndDisplayHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    if ([view respondsToSelector:@selector(didEndDisplay)]) {
        [view performSelector:@selector(didEndDisplay)];
    }
}

- (void)fjr_willDisplayFooterView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    FJRTableSection *section = self.fjr_sections[sectionIndex];
    if (section.footerContext && [view respondsToSelector:@selector(setContext:)]) {
        [view performSelector:@selector(setContext:) withObject:section.footerContext];
    }
    if ([view respondsToSelector:@selector(willDisplay)]) {
        [view performSelector:@selector(willDisplay)];
    }
}

- (void)fjr_didEndDisplayFooterView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    if ([view respondsToSelector:@selector(didEndDisplay)]) {
        [view performSelector:@selector(didEndDisplay)];
    }
}

- (void)fjr_didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(didSelect)]) {
        [cell performSelector:@selector(didSelect)];
    }
}

- (void)fjr_didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(didDeselect)]) {
        [cell performSelector:@selector(didDeselect)];
    }
}

@end
