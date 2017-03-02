//
//  XMGRecommendTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendTVC.h"
#import "XMGAdPicView.h"
#import "XMGAdPicModel.h"
#import "XMGMenueView.h"

#import "XMGRecommendCell.h"
#import "XMGAdPicTextCell.h"
#import "XMGSpecialColumnCell.h"
#import "UIImageView+XMGExtension.h"
#import "UIButton+WebCache.h"
#import "Base.h"
#import "XMGConst.h"
#import "UIView+XMGLayout.h"
#import "XMGRecommendDataTool.h"
#import <SafariServices/SafariServices.h>
#import "HomeRecommendDefine.h"

@interface XMGRecommendTVC ()

@property (nonatomic, strong) XMGAdPicView *adPicView;

@property (nonatomic, strong) XMGMenueView *menueView;

@property (nonatomic, strong) NSMutableArray *listMs;

@end

@implementation XMGRecommendTVC

@synthesize listMs = _listMs;

-(NSMutableArray *)listMs
{
    if (_listMs == nil) {
        _listMs = [NSMutableArray array];
    }

    // 根据模型的sortID进行排序
    [_listMs sortUsingComparator:^NSComparisonResult(XMGGroupModel *obj1, XMGGroupModel *obj2) {

        if (obj1.sortID < obj2.sortID) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];

    return _listMs;
}

-(void)setListMs:(NSMutableArray *)listMs
{
    _listMs = listMs;
    [self.tableView reloadData];
}


-(XMGAdPicView *)adPicView {
    if (_adPicView == nil) {
        XMGAdPicView *adPicView = [XMGAdPicView picViewWithLoadImageBlock:^(UIImageView *imageView, NSURL *url) {
            [imageView setURLImageWithURL:url progress:nil complete:nil];
        }];
        _adPicView = adPicView;
    }
    return _adPicView;
}

-(XMGMenueView *)menueView {

    if(_menueView == nil)
    {
        XMGMenueView *menueView = [[XMGMenueView alloc] initWithFrame:CGRectZero];
        menueView.loadBlock = ^(UIButton *imageBtn, NSURL *url){
            [imageBtn sd_setImageWithURL:url forState:UIControlStateNormal];
        };
        _menueView = menueView;
    }
    return _menueView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XMGColor(225, 225, 225);
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kCommonMargin, 0);

    // 设置图片轮播器
    // 封装图片轮播器
    [self.tableView.tableHeaderView addSubview:self.adPicView];
    self.adPicView.frame = CGRectMake(0, 0, kScreenWidth, 150);

    // 设置菜单栏
    [self.tableView.tableHeaderView addSubview:self.menueView];
    self.menueView.frame = CGRectMake(0, self.adPicView.height, kScreenWidth, 100);


    // 加载广告
    kWeakSelf;
    [[XMGRecommendDataTool shareInstance] getAdList:^(NSArray<XMGAdPicModel *> *adMs, NSError *error) {

        for (int i = 0; i < adMs.count; i ++) {
            XMGAdPicModel *adM = adMs[i];
            __weak XMGAdPicModel *weakAdM = adM;
            weakAdM.clickBlock = ^{

                NSInteger type = weakAdM.focusImageM.type;

                NSInteger albumID = weakAdM.focusImageM.albumId;

                UINavigationController *nav = self.navigationController;

                if (type == 9) {
                    NSLog(@"听单处理");
                }

                if (type == 3) {
                    NSLog(@"播放器界面");
                    NSString *albumID = [NSString stringWithFormat:@"%zd", weakAdM.focusImageM.trackId];
                    kPresentToPlayer(albumID)

                }else if (type == 2) {
                    NSLog(@"跳转到专辑详情");
                    // 跳转到专辑详情
                    UINavigationController *nav = self.navigationController;
                    NSString *albumIDStr = [NSString stringWithFormat:@"%zd", albumID];
                    kJumpToAlbumDetail(albumIDStr, nav)
                }else if (type == 4) {

                    // 打开网页
                    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:weakAdM.focusImageM.url]];
                    sfvc.title = @"商城";
                    [nav pushViewController:sfvc animated:YES];
                }




            };
        }

        weakSelf.adPicView.picModels = adMs;
    }];


    // 加载 图文菜单列表
    [[XMGRecommendDataTool shareInstance] getPicMenueList:^(NSArray *menuePicMs, NSError *error) {
        weakSelf.menueView.menueModels = menuePicMs;
    }];

    // 加载 小编推荐
    [[XMGRecommendDataTool shareInstance] getEditorRecommendAlbums:^(XMGGroupModel *groupM, NSError *error) {
        NSLog(@"%@", groupM.title);
        groupM.sortID = 1;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];

    // 加载 现场直播
    [[XMGRecommendDataTool shareInstance] getLiveMs:^(XMGGroupModel *groupM, NSError *error) {
        NSLog(@"%@", groupM.liveMs);
        groupM.sortID = 2;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];

    // 加载 精品听单
    [[XMGRecommendDataTool shareInstance] getSpecialColumnMs:^(XMGGroupModel *groupM, NSError *error) {
        groupM.sortID = 4;
        NSLog(@"%@", groupM);
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];

    // 加载 推广
    [[XMGRecommendDataTool shareInstance] getTuiGuangMs:^(XMGGroupModel *groupM, NSError *error) {
        groupM.sortID = 5;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];
    }];

    // 加载  听"广州"
    [[XMGRecommendDataTool shareInstance] getCityAlbums:^(XMGGroupModel *groupM, NSError *error) {
        groupM.sortID = 3;
        [weakSelf.listMs addObject:groupM];
        [weakSelf.tableView reloadData];

    }];

    // 加载 "热门推荐"
    [[XMGRecommendDataTool shareInstance] getHotRecommendsAlbums:^(NSArray<XMGGroupModel *> *groupMs, NSError *error) {

        [weakSelf.listMs addObjectsFromArray:groupMs];
        [weakSelf.tableView reloadData];

    }];

}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGGroupModel *groupM = self.listMs[indexPath.row];
    
    UITableViewCell *cell;
    
    if (groupM.cellType == CellTypeList3) {
        
        cell = [XMGRecommendCell cellWithTableView:tableView];
        [(XMGRecommendCell *)cell setGroupM:groupM];
        
    }else if(groupM.cellType == CellTypeList1) {
        
        cell = [XMGAdPicTextCell cellWithTableView:tableView];
        [(XMGAdPicTextCell *)cell setGroupM:groupM];

    }else if(groupM.cellType == CellTypeList2) {
        
        cell = [XMGSpecialColumnCell cellWithTableView:tableView];
        [(XMGSpecialColumnCell *)cell setGroupM:groupM];
    }


    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGGroupModel *groupM = self.listMs[indexPath.row];

    if (groupM.cellType == CellTypeList1) {
        return 210;
    }

    if (groupM.cellType == CellTypeList3) {
        return 240;
    }

    if (groupM.cellType == CellTypeList2) {
        return 210;
    }

    return 0;
}


@end
