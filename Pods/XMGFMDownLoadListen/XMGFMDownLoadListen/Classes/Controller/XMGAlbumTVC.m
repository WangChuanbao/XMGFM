//
//  XMGAlbumTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumTVC.h"
#import "XMGDownLoadDataTool.h"
#import "XMGDownLoadAlbumCell.h"
#import "XMGSetValueTool.h"
#import "XMGAlbumVoiceTVC.h"
#import "Base.h"
#import "XMGDownLoadService.h"

@interface XMGAlbumTVC ()

@property (nonatomic, strong) NSArray<XMGDownLoadAlbumModel *> *downLoadingAlbumMs;

@end

@implementation XMGAlbumTVC

-(void)setDownLoadingAlbumMs:(NSArray<XMGDownLoadAlbumModel *> *)downLoadingAlbumMs
{
    _downLoadingAlbumMs = downLoadingAlbumMs;
    [self.tableView reloadData];
}

-(void)viewDidLoad {

    [super viewDidLoad];

    self.tableView.rowHeight = 68;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}


- (void)loadData {

    kWeakSelf;
    [[XMGDownLoadDataTool shareInstance] getCurrentDownLoadedAlbumMs:^(NSArray<XMGDownLoadAlbumModel *> *downLoadingAlbumMs) {
        weakSelf.downLoadingAlbumMs = downLoadingAlbumMs;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = self.downLoadingAlbumMs.count;

    self.showNoDataPane = (count == 0);

    return count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGDownLoadAlbumCell *cell = [XMGDownLoadAlbumCell cellWithTableView:tableView];

    XMGDownLoadAlbumModel *model = self.downLoadingAlbumMs[indexPath.row];

    __weak XMGDownLoadAlbumModel *weakM = model;

    kWeakSelf;
    model.deleteBlock = ^{
        [[XMGDownLoadDataTool shareInstance] deleteDownLoadVocieModelsWithAlbumID:weakM.albumId];
        [weakSelf loadData];

         // 发通知,
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownLoadStateChangeNotification object:nil];

    };

    [XMGSetValueTool setModel:model toCell:cell];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGAlbumVoiceTVC *voiceVC = [[XMGAlbumVoiceTVC alloc] init];
    voiceVC.albumM = self.downLoadingAlbumMs[indexPath.row];
    [self.navigationController pushViewController:voiceVC  animated:YES];


}


@end
