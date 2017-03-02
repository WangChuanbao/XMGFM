//
//  XMGPlayHistoryVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayHistoryVC.h"

#import "XMGMineOrderReadCell.h"
#import "XMGPlayHistoryHeader.h"



@interface XMGPlayHistoryVC ()



@end

@implementation XMGPlayHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [XMGPlayHistoryHeader playHistoryHeader];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"播放历史";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGMineOrderReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOrderReadCell"];
    
    if (cell == nil) {
        cell = [XMGMineOrderReadCell mineOrderReadCell];
        cell.deleteBtn.hidden = YES;
    }
    
 

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}



@end
