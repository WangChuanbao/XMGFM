//
//  XMGRecommendListTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendListTVC.h"
#import "XMGAlbumInfoModel.h"
#import "XMGPlayerCell.h"

#import "XMGPlayerDataTool.h"
#import "Base.h"

#import "PlayerDefine.h"

@interface XMGRecommendListTVC ()

@property (nonatomic, strong) NSArray <XMGAlbumInfoModel *>*albumMs;

@end

@implementation XMGRecommendListTVC

-(void)setAlbumMs:(NSArray *)albumMs {
    _albumMs = albumMs;
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 70;
    self.title = @"相关推荐";

//    http://ar.ximalaya.com/rec-association/recommend/album/by_album?albumId=294567&device=iPhone
    kWeakSelf
    [[XMGPlayerDataTool shareInstance] getRecommendMsWithAlbumId:self.albumId result:^(NSArray<XMGAlbumInfoModel *> *albumInfoMs) {
        weakSelf.albumMs = albumInfoMs;
    }];

}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGPlayerCell *cell = [XMGPlayerCell cellWithTableView:tableView];

    XMGAlbumInfoModel *model = self.albumMs[indexPath.row];

    cell.albumInfoM = model;

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGAlbumInfoModel *model = self.albumMs[indexPath.row];
    // 跳转到专辑详情
    kJumpToAlbumDetail(@(model.albumId), self.navigationController)

//    XMGAlbumDetailController *detailTVC = [[XMGAlbumDetailController alloc] initWithStyle:UITableViewStylePlain];
//    XMGAlbumInfoModel *model = self.albumMs[indexPath.row];
//    detailTVC.albumId = [NSString stringWithFormat:@"%zd", model.albumId];
//    [self.navigationController pushViewController:detailTVC animated:YES];

}



@end
