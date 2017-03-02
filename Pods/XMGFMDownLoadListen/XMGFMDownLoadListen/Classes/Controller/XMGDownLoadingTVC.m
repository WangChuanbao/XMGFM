//
//  XMGDownLoadingTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadingTVC.h"
#import "XMGDownLoadDataTool.h"
#import "XMGDownLoadVoiceCell.h"
#import "XMGSetValueTool.h"
#import "XMGDownLoadService.h"
#import "Base.h"

@interface XMGDownLoadingTVC ()

@property (nonatomic, strong) NSArray<XMGDownLoadVoiceModel *> *downLoadingVoiceMs;

@property (nonatomic, weak) NSTimer *updateTimer;

@end

@implementation XMGDownLoadingTVC

- (NSTimer *)updateTimer
{
    if (_updateTimer == nil) {
        NSTimer *updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateCellProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:updateTimer forMode:NSRunLoopCommonModes];
        _updateTimer = updateTimer;
    }
    return _updateTimer;
}


- (void)updateCellProgress {

    // 取出所有可见的cell indexPath
    NSArray *indexPathes = [self.tableView indexPathsForVisibleRows];


    // 遍历cell, 给进度赋值
    for (NSIndexPath *indexPath in indexPathes) {

        XMGDownLoadVoiceModel *model = self.downLoadingVoiceMs[indexPath.row];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [XMGSetValueTool setModel:model toCell:cell];

    }

}


- (void)loadData {
    kWeakSelf;
    [[XMGDownLoadDataTool shareInstance] getCurrentDownLoadingVoiceMs:^(NSArray<XMGDownLoadVoiceModel *> *downLoadingVoiceMs) {
        weakSelf.downLoadingVoiceMs = downLoadingVoiceMs;
    }];

}


-(void)setDownLoadingVoiceMs:(NSArray<XMGDownLoadVoiceModel *> *)downLoadingVoiceMs
{
    _downLoadingVoiceMs = downLoadingVoiceMs;
    [self.tableView reloadData];

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 100;

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [self.updateTimer fire];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.updateTimer invalidate];
    self.updateTimer = nil;
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
     model.downLoadBlock = ^(BOOL isDownLoad) {
         if (isDownLoad) {
             [XMGDownLoadService downLoadVoiceM:weakModel];
         }else {
             [XMGDownLoadService pauseVoiceM:weakModel];
         }
     };

     kWeakSelf;
     model.deleteBlock = ^{
         // 删除下载任务以及下载缓存
         [XMGDownLoadService stopVoiceM:weakModel];

         // 删除记录
         [[XMGDownLoadDataTool shareInstance] deleteVoiceDownLoadedModelWithURL:weakModel.downloadUrl];
         [weakSelf loadData];
     };


     [XMGSetValueTool setModel:model toCell:cell];

     return cell;
 }



@end
