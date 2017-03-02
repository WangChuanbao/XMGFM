//
//  XMGTodayFireVoiceListTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceListTVC.h"
#import "XMGTodayFireVoiceCell.h"
#import "XMGDownLoadDataTool.h"
#import "XMGSetValueTool.h"
#import "XMGDownLoadService.h"

#import "Base.h"
#import "XMGPlayerService.h"
#import "DownLoadAPIDefine.h"


@interface XMGTodayFireVoiceListTVC ()

@property (nonatomic, strong) NSArray<XMGDownLoadVoiceModel *> *voiceMs;

@property (nonatomic, weak) NSTimer *updateTimer;


@end

@implementation XMGTodayFireVoiceListTVC



-(void)setVoiceMs:(NSArray<XMGDownLoadVoiceModel *> *)voiceMs
{
    _voiceMs = voiceMs;
    [self.tableView reloadData];
}

-(void)setLoadKey:(NSString *)loadKey
{
    _loadKey = loadKey;

    kWeakSelf;
    [[XMGDownLoadDataTool shareInstance] getVoiceMsWithKey:loadKey pageNum:1 result:^(NSArray<XMGDownLoadVoiceModel *> *voiceMs) {
        weakSelf.voiceMs = voiceMs;
    }];


}

-(void)viewDidLoad
{
    self.tableView.rowHeight = 80;
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.voiceMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGTodayFireVoiceCell *cell = [XMGTodayFireVoiceCell cellWithTableView:tableView];

    XMGDownLoadVoiceModel *model = self.voiceMs[indexPath.row];
    __weak XMGDownLoadVoiceModel *weakModel = model;
    model.clickBlock = ^{

        [[XMGDownLoadDataTool shareInstance] setDownLoadMessageToVoiceM: weakModel complete:^{
            [XMGDownLoadService downLoadVoiceM:weakModel];
        }];

    };

    model.sortNum = indexPath.row + 1;

    [XMGSetValueTool setModel:model toCell:cell];

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGDownLoadVoiceModel *model = self.voiceMs[indexPath.row];

    kPresentToPlayer(@(model.trackId))

}

@end
