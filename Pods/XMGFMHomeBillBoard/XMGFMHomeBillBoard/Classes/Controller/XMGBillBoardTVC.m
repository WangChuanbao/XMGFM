//
//  XMGAnchorTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGBillBoardTVC.h"
#import "XMGBillBoardDataTool.h"
#import "XMGFocusImages.h"
#import "XMGFocusImageModel.h"
#import "XMGAdPicView.h"
#import "FJRTableViewManager.h"
#import "XMGRankingListModel.h"
#import "XMGRankingInfoModel.h"
#import "Base.h"
#import "UIImageView+XMGExtension.h"

@interface XMGBillBoardTVC ()
@property (nonatomic, strong) XMGAdPicView *adPicView;
@property (nonatomic, strong) FJRTableViewManager *manager;
@end

@implementation XMGBillBoardTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMGRandomColor;
    
    self.manager = [[FJRTableViewManager alloc] initWithTableView:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    // 设置图片轮播器
    // 封装图片轮播器
    [self.tableView.tableHeaderView addSubview:self.adPicView];
    self.adPicView.frame = CGRectMake(0, 0, kScreenWidth, 150);
    
    
    // 加载广告
    
    [[XMGBillBoardDataTool shareInstance] getFocusList:^(NSArray <XMGAdPicModel *>*adMs, NSError *error) {
        
        self.adPicView.picModels = adMs;
        
    }];
    
    [[XMGBillBoardDataTool shareInstance] getRankingList:^(NSArray<XMGRankingListModel *> *listMs, NSError *error) {
        
        
        [self.tableView fjr_reloadDataWithBlock:^{
           
            
            [listMs enumerateObjectsUsingBlock:^(XMGRankingListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                FJRTableSection *section = [FJRTableSection section];

                [self.tableView fjr_addSection:section];
                
                [obj.list enumerateObjectsUsingBlock:^(XMGRankingInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    FJRTableRow *row = [FJRTableRow rowWithContext:obj];
                     [self.tableView fjr_addRow:row inSection:section];
                }];
                
            }];
            
        }];
        
    }];
}



-(XMGAdPicView *)adPicView {
    if (!_adPicView) {
        XMGAdPicView *adPicView = [XMGAdPicView picViewWithLoadImageBlock:^(UIImageView *imageView, NSURL *url) {

            [imageView setURLImageWithURL:url progress:nil complete:nil];
        }];
        _adPicView = adPicView;
    }
    return _adPicView;
}


@end
