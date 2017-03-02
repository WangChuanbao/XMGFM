//
//  XMGAlbumDetailController.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumDetailController.h"
#import "XMGAlbumDetailHeaderView.h"
#import "XMGSegmentBar.h"
#import "XMGAlbumDetaiVedioCell.h"
#import "XMGVedioFuncCell.h"
#import "XMGAlbumDetailContentCell.h"
#import "XMGAlbumAnchoCell.h"
#import "XMGAlbumTagCell.h"
#import "XMGAlbumRecommendCell.h"
#import "XMGAnchoController.h"
#import "XMGMoreRecommendController.h"
#import "XMGSubscribleDataTool.h"
#import "XMGAlbumDetailInfo.h"
#import "XMGAnchorInfo.h"

#import "XMGDownLoadController.h"
#import "XMGTagController.h"
#import "Base.h"
#import "XMGConst.h"
#import "SubcriptDefine.h"

@interface XMGAlbumDetailController ()<XMGSegmentBarDelegate,XMGAlbumRecommendCellDelegate,XMGAlbumTagCellDelegate>
@property (nonatomic, strong) XMGAlbumDetailHeaderView *headerView;
@property (nonatomic, strong) XMGSegmentBar *setmentBar;
@property (nonatomic, strong) NSArray *menuBarArray;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic, strong)XMGAlbumMenu *albumMenu;
@property (nonatomic, strong)XMGAlbumDetail *albumDetail;

@property (nonatomic, strong) NSArray *menuListArr;

@end

@implementation XMGAlbumDetailController

-(NSArray *)menuBarArray
{
    if (_menuBarArray == nil) {
        _menuBarArray = @[@"详情",@"节目(21)"];
    }
    return _menuBarArray;
}

- (XMGAlbumDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGAlbumDetailHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 205);
    }
    return _headerView;
}

static NSString * const vedioCellId = @"vedioCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 请求网络数据
    [[XMGSubscribleDataTool shareInstance] getAlbumMenuWithAlbumId:self.albumId result:^(XMGAlbumMenu *albumMenu, NSError *error) {
        self.headerView.album = albumMenu.album;
        self.menuListArr = albumMenu.tracks.list;
        
        [self.tableView reloadData];
    }];
    
    // 请求网络数据
    [[XMGSubscribleDataTool shareInstance] getAlbumDetailWithAlbumId:self.albumId result:^(XMGAlbumDetail *albumDetail, NSError *error) {
        self.albumDetail = albumDetail;
        [self.tableView reloadData];
    }];

    
    
    [self initView];
}


- (void)loadList {
    [[XMGSubscribleDataTool shareInstance] getAlbumTrackListWithAlbumId:self.albumId result:^(XMGTracks *tracks, NSError *error){
        self.menuListArr = tracks.list;
        [self.tableView reloadData];
    }];
}

- (void)initView
{
    self.title = @"专辑详情";
    self.view.backgroundColor = kCommonColor;
    
    // 点击主题进行跳转
    kWeakSelf
    self.headerView.callBackClickAlbum = ^(NSInteger tag){
        switch (tag) {
            case 0:  // 主题
            {
                XMGAnchoController *ancho = [[XMGAnchoController alloc] init];
                [weakSelf.navigationController pushViewController:ancho animated:YES];
            }
            break;
            case 1:  // 分类
            {
                
            }
            break;
            case 2:  // 订阅专辑
            {
                
            }
            break;
            case 3:  // 批量下载
            {
                XMGDownLoadController *downloadVc = [[XMGDownLoadController alloc]init];
                downloadVc.albumId = weakSelf.albumId;
                [weakSelf.navigationController pushViewController:downloadVc animated:YES];
            }
            break;
            default:
            break;
        }
       
    };
    self.tableView.tableHeaderView = self.headerView;
    
    self.selectedIndex = 0;
//    if (self.selectedIndex == 1) { // 节目
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGAlbumDetaiVedioCell class]) bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:vedioCellId];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
}

#pragma mark - XMGMenueBarDelegate
- (void)segmentBarDidSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex
{
    self.selectedIndex = toIndex;
    if (toIndex == 1) { // 节目
        if (self.menuListArr.count == 0) {
            [self loadList];
        }else {
            [self.tableView reloadData];
        }

    }else{ // 详情
        [self.tableView reloadData];
    }
    
    XMGLog(@"=========%zd",self.selectedIndex);
}

#pragma mark - XMGAlbumRecommendCellDelegate
- (void)albumRecommendCellDidSelectCell:(NSString *)albumId
{
    XMGAlbumDetailController *vc =[[XMGAlbumDetailController alloc]init];
    vc.albumId = albumId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - XMGAlbumTagCellDelegate
- (void)albumTagCellDidClickTagButton
{
    XMGTagController *tagVc = [[XMGTagController alloc]init];
    [self.navigationController pushViewController:tagVc animated:YES];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectedIndex == 1) { // 节目
        return self.menuListArr.count;
    }else
    {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        if (indexPath.row == 0) {
//
            XMGVedioFuncCell *cell = [[NSBundle bundleForClass:[XMGVedioFuncCell class]] loadNibNamed:@"XMGVedioFuncCell" owner:nil options:nil].firstObject;
            return cell;
        }else
        {
            XMGAlbumDetaiVedioCell *cell = [tableView dequeueReusableCellWithIdentifier:vedioCellId];
            cell.track = self.menuListArr[indexPath.row];
            return cell;
        }
    }else if (self.selectedIndex == 0)
    {
        switch (indexPath.row) {
                case 0:
                    {
                        XMGAlbumDetailContentCell *cell = [[NSBundle bundleForClass:[XMGAlbumDetailContentCell class]] loadNibNamed:@"XMGAlbumDetailContentCell" owner:nil options:nil].firstObject;
                        cell.albumDetailInfo  = self.albumDetail.detail;
                        return cell;
                    }
                break;
                case 1:
                    {
                        XMGAlbumAnchoCell *cell = [[NSBundle bundleForClass:[XMGAlbumAnchoCell class]] loadNibNamed:@"XMGAlbumAnchoCell" owner:nil options:nil].firstObject;
                        cell.anchorInfo = self.albumDetail.user;
                        return cell;
                    }
                break;
                case 2:
                    {
                        XMGAlbumTagCell *cell = [[NSBundle bundleForClass:[XMGAlbumTagCell class]] loadNibNamed:@"XMGAlbumTagCell" owner:nil options:nil].firstObject;
                        cell.delegate = self;
                        return cell;
                    }
                break;
                case 3:
                    {
                        XMGAlbumRecommendCell *cell = [[NSBundle bundleForClass:[XMGAlbumRecommendCell class]] loadNibNamed:@"XMGAlbumRecommendCell" owner:nil options:nil].firstObject;
                        cell.delegate = self;
                        cell.otherRecommands = self.albumDetail.recs;
                        kWeakSelf
                        cell.getMoreRecommend = ^{
                            XMGMoreRecommendController *moreRecommend = [[XMGMoreRecommendController alloc] init];
                            [weakSelf.navigationController pushViewController:moreRecommend animated:YES];
                        };
                        return cell;
                    }
                break;
        }
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedIndex == 1 && indexPath.row > 0){  // 点击节目中的cell
        XMGTrack *track = self.menuListArr[indexPath.row];

        kPresentToPlayer(@(track.trackId))

    }else{
        if (indexPath.row == 1) {
            
            XMGAnchoController *ancho = [[XMGAnchoController alloc] init];
            [self.navigationController pushViewController:ancho animated:YES];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        if (indexPath.row == 0) {
            return 30;
        }else
        {
            XMGTrack *track = [self.menuListArr objectAtIndex:indexPath.row];
            XMGLog(@"cellheight ======= %.2f",track.cellHeight);
            return track.cellHeight + 20;
        }
    }else{
        switch (indexPath.row) {
                case 0:
                    {
                        XMGAlbumDetailInfo *albumDetailInfo  = self.albumDetail.detail;
                        return albumDetailInfo.contentCellHeight;
                    }
                break;
                case 1:
                    {
                        XMGAnchorInfo *anchorInfo = self.albumDetail.user;
                        return anchorInfo.anchorCellHeight;
                    }
                break;
                case 2:
                    return 88;
                break;
                case 3:
                    {
                        return 420;
                    }
                break;
            default:
                break;
        }
    }
    return 0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. 设置菜单栏
    XMGSegmentBar *setmentBar = [[XMGSegmentBar alloc] initWithFrame:CGRectMake(0, kNavigationBarMaxY, kScreenWidth, kMenueBarHeight)];
    setmentBar.segmentMs = self.menuBarArray;
    if (self.selectedIndex == 1) {
        setmentBar.selectedIndex = 1;
    }else
    {
        setmentBar.selectedIndex = 0;
    }
    setmentBar.delegate = self;
    self.setmentBar = setmentBar;
    setmentBar.backgroundColor = [UIColor whiteColor];
    return setmentBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kMenueBarHeight;
}

@end
