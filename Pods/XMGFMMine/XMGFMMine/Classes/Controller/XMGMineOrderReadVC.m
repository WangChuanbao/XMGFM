//
//  XMGMineOrderReadVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMineOrderReadVC.h"
#import "XMGMineOrderReadCell.h"

#import "XMGAudioListModel.h"
//#import "XMGAlbumDetailController.h"

@interface XMGMineOrderReadVC ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation XMGMineOrderReadVC


- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [XMGAudioListModel historyList];
        
    }
    return _dataArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"我的订阅";
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGMineOrderReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOrderReadCell"];
    
    if (cell == nil) {
         cell = [XMGMineOrderReadCell mineOrderReadCell];
        
    }
    XMGAudioListModel *audioM = self.dataArray[indexPath.row];
    cell.audioM = audioM;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    XMGAlbumDetailController *albumVC = [[XMGAlbumDetailController alloc] init];
//    XMGAudioListModel *audioM = self.dataArray[indexPath.row];
//    albumVC.albumId = [NSString stringWithFormat:@"%ld",(long)audioM.albumId];
//    [self.navigationController pushViewController:albumVC animated:YES];
}



@end
