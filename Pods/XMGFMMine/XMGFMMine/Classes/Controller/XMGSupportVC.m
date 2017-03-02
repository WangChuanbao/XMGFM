//
//  XMGSupportVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSupportVC.h"

#import "XMGSupportModel.h"
#import "XMGSupportCell.h"

#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGSupportVC ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation XMGSupportVC

- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [XMGSupportModel supportList];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"赞过的";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    
        return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGSupportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOrderReadCell"];
    
    if (cell == nil) {
        cell = [XMGSupportCell supportCell];
    }
    
    XMGSupportModel *supportM = self.dataArray[indexPath.row];
    cell.supportM = supportM;
    
    return cell;
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
//    UIView *headerV = [[UIView alloc] init];
//    headerV.frame = CGRectMake(0, 0, 0, 30);
//    headerV.backgroundColor =  kCommonColor;
    
    UILabel *title = [[UILabel alloc] init];
    title.text = [NSString stringWithFormat:@"   共赞过%ld个声音",self.dataArray.count];
    title.backgroundColor = kCommonColor;
    title.textColor = [UIColor grayColor];
    title.font = [UIFont systemFontOfSize:12];
    title.frame = CGRectMake(0, 0, 0, 30);
    
    
    return title;
}

//返回每一组头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGSupportModel *supportM = self.dataArray[indexPath.row];
    
//    [self presentViewController:[XMGPlayerVC shareInstanceWithAlbumId:0 trackUid:supportM.trackId isUseCache:NO] animated:YES completion:nil];
}

@end
