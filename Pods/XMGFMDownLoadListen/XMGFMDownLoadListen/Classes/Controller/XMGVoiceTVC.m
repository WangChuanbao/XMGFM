//
//  XMGVoiceTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGVoiceTVC.h"

#import "XMGDownLoadDataTool.h"
#import "XMGDownLoadVoiceCell.h"
#import "XMGSetValueTool.h"
#import "XMGDownLoadService.h"
#import "Base.h"
#import "DownLoadAPIDefine.h"

@interface XMGVoiceTVC ()

@property (nonatomic, strong) NSArray<XMGDownLoadVoiceModel *> *downLoadingVoiceMs;

@end

@implementation XMGVoiceTVC

-(void)setDownLoadingVoiceMs:(NSArray<XMGDownLoadVoiceModel *> *)downLoadingVoiceMs
{
    _downLoadingVoiceMs = downLoadingVoiceMs;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;



}

- (void)loadData {
    kWeakSelf;
    [[XMGDownLoadDataTool shareInstance] getCurrentDownLoadedVoiceMs:^(NSArray<XMGDownLoadVoiceModel *> *downLoadingVoiceMs) {
         weakSelf.downLoadingVoiceMs = downLoadingVoiceMs;
    }];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger count = self.downLoadingVoiceMs.count;
    self.showNoDataPane = (count == 0);
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGDownLoadVoiceCell *cell = [XMGDownLoadVoiceCell cellWithTableView:tableView];
    XMGDownLoadVoiceModel *model = self.downLoadingVoiceMs[indexPath.row];

    __weak XMGDownLoadVoiceModel *weakModel = model;
    model.deleteBlock = ^{
        // 删除下载任务以及下载缓存
        [XMGDownLoadService stopVoiceM:weakModel];

        // 删除记录
        [[XMGDownLoadDataTool shareInstance] deleteVoiceDownLoadedModelWithURL:weakModel.downloadUrl];

        // 发通知,
        [[NSNotificationCenter defaultCenter] postNotificationName:kDownLoadStateChangeNotification object:nil];
    };

    [XMGSetValueTool setModel:model toCell:cell];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGDownLoadVoiceModel *model = self.downLoadingVoiceMs[indexPath.row];

    kPresentToPlayer(@(model.trackId))
    
}


@end
