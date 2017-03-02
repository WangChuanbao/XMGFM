//
//  XMGRadioBroadcaseTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRadioBroadcaseTVC.h"
#import "XMGRadioBroadcastDataTool.h"
#import "XMGRadioCell.h"
#import "XMGCategoriesView.h"
#import "XMGCategoriesCell.h"
#import "XMGRadioCategoryTVC.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGRadioBroadcaseTVC ()

@property (nonatomic, strong) NSMutableArray *listMs;
@property (nonatomic, strong)XMGCategoriesView *headerView;

@property (nonatomic, strong)NSMutableArray<XMGCategorieModel *> *categorieMs;


@end

@implementation XMGRadioBroadcaseTVC

-(NSMutableArray *)listMs
{
    if (_listMs == nil) {
        _listMs = [NSMutableArray array];
    }
    
    // 根据模型的sortID进行排序
    [_listMs sortUsingComparator:^NSComparisonResult(XMGRadioModels *obj1, XMGRadioModels *obj2) {
        
        if (obj1.sortID < obj2.sortID) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    
    return _listMs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMGColor(225, 225, 225);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 310;
    self.headerView = [[NSBundle bundleForClass:[XMGCategoriesView class]] loadNibNamed:@"XMGCategoriesView" owner:nil options:nil].firstObject;
    
    // 头部collectionViewCell点击回调的block
    kWeakSelf
    self.headerView.selectorItemBlock = ^(XMGCategoriesCell* cell, NSIndexPath *indexPath){
        
        [weakSelf collectionViewSeletorItemAtCell:cell indexPath:indexPath];
    };
    
    self.headerView.height = 300;
    self.tableView.tableHeaderView = self.headerView;
    
    
    
    //头部电台列表
    [[XMGRadioBroadcastDataTool shareInstance] getCategoriesList:^(NSMutableArray<XMGCategorieModel *> *categorieMs, NSError *error) {
        
        self.headerView.categorieMs = categorieMs;
        self.headerView.height = 100 + 130;
        self.tableView.tableHeaderView = self.headerView;
        self.categorieMs = categorieMs;
        
    }];
    
    
    // 本地电台列表
    [[XMGRadioBroadcastDataTool shareInstance]getLocalRadioList:^(XMGRadioModels *radioMs, NSError *error) {
        
        
        
        [self.listMs addObject:radioMs];
        
        [self.tableView reloadData];
    }];
    
    // 排行榜列表
    [[XMGRadioBroadcastDataTool shareInstance] getTopRadioList:^(XMGRadioModels *radioMs, NSError *error) {
        [self.listMs addObject:radioMs];
        [self.tableView reloadData];
    }];
    
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGRadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMGRadioCell"];
    
    
    XMGRadioModels *radioMs = self.listMs[indexPath.row];
    
    if (!cell) {
        cell = [[NSBundle bundleForClass:[XMGRadioCell class]] loadNibNamed:@"XMGRadioCell" owner:nil  options:nil].firstObject;
    }
    
    cell.listMs = radioMs;
    
    // cell 更多按钮点击处理
    kWeakSelf
    cell.moreBlock = ^(XMGRadioCell *cell){
        [weakSelf moreBtnClick:cell];
    };
    
    return cell;
}


- (void)collectionViewSeletorItemAtCell:(UICollectionViewCell *)cell indexPath: (NSIndexPath *)indexPath
{
    NSRange range= NSMakeRange(0,7);
    
    NSMutableArray *smallCategorieMs = [NSMutableArray arrayWithArray:[self.headerView.categorieMs subarrayWithRange:range]];
    
    XMGCategorieModel *lastModel = [XMGCategorieModel new];
    lastModel.isLast = YES;
    
    [smallCategorieMs addObject:lastModel];
    
    // 判断是否点击最后一个
    if (indexPath.row == self.headerView.categorieMs.count - 1) {
        
        self.headerView.categorieMs = self.headerView.categorieMs.count <= 8 ? self.categorieMs : smallCategorieMs;
        
        [UIView animateWithDuration:.1 animations:^{
            self.headerView.height = self.headerView.categorieMs.count <= 8 ? (100 + 10 + 30 * 2) : (100 + 130);
            self.tableView.tableHeaderView = self.headerView;
        }];
        
        return;
    }
    
    XMGCategorieModel *model = self.headerView.categorieMs[indexPath.row];
    
    // 加载各个电台的详细数据
    XMGRadioCategoryTVC *VC = [XMGRadioCategoryTVC new];
    VC.type = LoadDataRadioCategories;
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)moreBtnClick: (XMGRadioCell *)cell
{
    // 加载更多按钮数据
    XMGRadioCategoryTVC *VC = [XMGRadioCategoryTVC new];
    switch (cell.listMs.sortID) {
        case 1:
            VC.type = LoadDataRadioLocalMore;
            break;
            
        case 2:
            VC.type = LoadDataRadioHotMore;
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:VC animated:YES];
}
@end
