//
//  XMGPlayerVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayerVC.h"

#import "XMGPlayerDataTool.h"
#import "XMGPlayerService.h"

#import "XMGTitleScrollView.h"
#import "XMGPlayerPane.h"

#import "XMGRewardView.h"
#import "XMGUserInfoCell.h"

#import "XMGPlayerGroupCell.h"
#import "XMGRecommendListTVC.h"
#import "XMGCommentTVC.h"

#import "UIView+XMGLayout.h"
#import "Base.h"
#import "PlayerDefine.h"

@interface XMGPlayerVC ()


@property (nonatomic, strong) XMGPlayerPane *playerPane;

@property (nonatomic, weak) XMGTitleScrollView *titleScrollView;

@property (nonatomic, strong) XMGRewardView *rewardView;


@property (nonatomic, strong) NSMutableArray *cellModels;



@end

@implementation XMGPlayerVC

static UINavigationController *shareNavIntance;

+ (UINavigationController *)shareInstanceWithAlbumId: (NSInteger)albumId trackUid:(NSInteger)trackUid isUseCache: (BOOL)isUseCache
{
    if (shareNavIntance == nil) {
        XMGPlayerVC *playerVC = [[XMGPlayerVC alloc] initWithStyle:UITableViewStyleGrouped];
        shareNavIntance = [[UINavigationController alloc] initWithRootViewController:playerVC];
    }
    if (!isUseCache) {
        XMGPlayerVC *playerVC = shareNavIntance.childViewControllers[0];

        if (playerVC.trackUid != trackUid) {
            playerVC.albumId = albumId;
            playerVC.trackUid = trackUid;
            [playerVC loadData];
        }

    }else {

        // 继续播放当前音频
        [[XMGPlayerService shareInstance] playCurrentAudio];

    }

    return shareNavIntance;
}


-(XMGRewardView *)rewardView {
    if (_rewardView == nil) {

        _rewardView = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGRewardView" owner:nil options:nil].firstObject;

    }
    return _rewardView;
}

-(NSMutableArray *)cellModels
{
    if (_cellModels == nil) {
        _cellModels = [NSMutableArray array];
    }
    return _cellModels;
}


-(XMGTitleScrollView *)titleScrollView {
    if (_titleScrollView == nil) {

        XMGTitleScrollView *titleScrollView = [[XMGTitleScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        self.navigationItem.titleView = titleScrollView;
        _titleScrollView = titleScrollView;

    }
    return _titleScrollView;
}


-(XMGPlayerPane *)playerPane {
    if (!_playerPane) {

        _playerPane = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGPlayerPane" owner:nil options:nil].firstObject;
        _playerPane.height = 430;
    }
    return _playerPane;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpInit];


}



- (void)setUpInit {

    self.view.backgroundColor = [UIColor lightGrayColor];

    NSString *normalImagePath = [[NSBundle bundleForClass:self] pathForResource:@"playingback_h@2x.png" ofType:nil];

    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithContentsOfFile:normalImagePath] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];

    // 设置关闭按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    // 设置表格顶部视图
    self.tableView.tableHeaderView = self.playerPane;

    // 加载数据
    [self loadData];

}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

}



- (void)loadData {

//    http://mobile.ximalaya.com/v1/track/ca/playpage/19668798?albumId=294567&device=iPhone&trackUid=16960840


//    [[XMGPlayerDataTool shareInstance] getRewardList:^{
//        
//    }];


    kWeakSelf
    [[XMGPlayerDataTool shareInstance] getPlayerDataWithAlbumId:self.albumId trackUid: self.trackUid result:^(XMGTrackInfoModel *trackM, XMGAlbumInfoModel *albumInfoM, XMGPlayerGroupModel *associationAlbumM, XMGUserInfoModel *userInfoM, XMGPlayerCommentGroupModel *commentGroupM, XMGTrackRewardInfoModel *rewardInfoM) {

        // 清空数据
        self.cellModels = nil;
        [self.tableView reloadData];


        // 设置播放面板
        self.playerPane.trackM = trackM;
        self.playerPane.userInfoM = userInfoM;

        // 设置标题
        self.titleScrollView.showContent = trackM.title;

        // 用户信息
        [self.cellModels addObject:albumInfoM];


        associationAlbumM.clickBlock = ^{
            XMGRecommendListTVC *listTVC = [[XMGRecommendListTVC alloc] init];
            listTVC.albumId = albumInfoM.albumId;
            [weakSelf.navigationController pushViewController:listTVC animated:YES];

        };
        [self.cellModels addObject:associationAlbumM];


        commentGroupM.clickBlock = ^{

            XMGCommentTVC *commentTVC = [[XMGCommentTVC alloc] init];
            commentTVC.trackId = self.trackUid;
            [weakSelf.navigationController pushViewController:commentTVC animated:YES];

        };
        [self.cellModels addObject:commentGroupM];

        [self.tableView reloadData];

        //设置打赏
        self.rewardView.rewardInfoM = rewardInfoM;



    }];

}


- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.cellModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.cellModels[indexPath.section];
    UITableViewCell *cell;
    if ([model isKindOfClass:[XMGAlbumInfoModel class]]) {
        cell = [XMGUserInfoCell cellWithTableView:tableView];
        [(XMGUserInfoCell *)cell setAlbumInfoM:model];
    }

    if ([model isKindOfClass:[XMGPlayerGroupModel class]]) {
        cell = [XMGPlayerGroupCell cellWithTableView:tableView];
        [(XMGPlayerGroupCell *)cell setAssociationAlbumGroupM:model];
    }

    if ([model isKindOfClass:[XMGPlayerCommentGroupModel class]]) {
        cell = [XMGPlayerGroupCell cellWithTableView:tableView];
        [(XMGPlayerGroupCell *)cell setCommentGroupM:model];
    }

    return cell;
}





- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return self.rewardView;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 140;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    XMGPlayerFrameModel *model = self.cellModels[indexPath.section];

    return model.cellHeight;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGPlayerFrameModel *model = self.cellModels[indexPath.section];
    if ([model isKindOfClass:[XMGAlbumInfoModel class]]) {
        // 跳转到专辑详情
        kJumpToAlbumDetail(@(((XMGAlbumInfoModel *)model).albumId), self.navigationController)
    }

    if ([model isKindOfClass:[XMGUserInfoCell class]]) {
        NSLog(@"跳转到用户详情");
    }

}


@end
