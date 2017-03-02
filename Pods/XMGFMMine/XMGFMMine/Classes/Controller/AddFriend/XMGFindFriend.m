//
//  XMGFindFriend.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFindFriend.h"
#import "XMGFriendListM.h"
#import "XMGAddFriendsCell.h"
#import "XMGFriendsDetailVC.h"
#import "Base.h"


@interface XMGFindFriend ()


@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation XMGFindFriend

- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [XMGFriendListM getFriendsList];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCommonColor;
    self.title = @"找听友";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGAddFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell"];
    
    if (cell == nil) {
        cell = [XMGAddFriendsCell friendsCellCell];
    }
    
    XMGFriendListM *friendsM = self.dataArray[indexPath.row];
    cell.friedsM = friendsM;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *title = [[UILabel alloc] init];
    title.text = [NSString stringWithFormat:@"  推荐关注"];
    title.backgroundColor = [UIColor orangeColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:12];
    title.frame = CGRectMake(0, 0, 0, 30);
    return title;
}


//返回每一组头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 79;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGFriendsDetailVC *tableVc = [[XMGFriendsDetailVC alloc] init];
    tableVc.frindsM = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:tableVc animated:YES];
}



@end
