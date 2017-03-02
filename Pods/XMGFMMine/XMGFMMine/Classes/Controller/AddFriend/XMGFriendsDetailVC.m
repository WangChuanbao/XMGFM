//
//  XMGFriendsDetailVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFriendsDetailVC.h"
#import "XMGFriendsHeaderV.h"


#import "XMGSupportModel.h"
#import "XMGSupportCell.h"
#import "XMGNavigationBar.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGFriendsDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) XMGFriendsHeaderV *headerV;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic,weak) XMGNavigationBar *navBar;

@end

@implementation XMGFriendsDetailVC


- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [XMGSupportModel supportList];
        
    }
    return _dataArray;
}


#define  oriOffsetY -286
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    scrollView.delegate  = self;
    scrollView.bounces = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.view addSubview:scrollView];
    
    //添加tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    //设置内边距
    [tableView setContentInset:UIEdgeInsetsMake(-oriOffsetY, 0, 0, 0)];
    
    //添加头部视图
    XMGFriendsHeaderV *headerV = [XMGFriendsHeaderV friendHeaderV];
    headerV.friendsM = self.frindsM;
    headerV.width = kScreenWidth;
    self.headerV = headerV;
    [self.view addSubview:headerV];
    
    XMGNavigationBar *navBar = [XMGNavigationBar showNavigaitonbar];
    navBar.width = kScreenWidth;
    self.navBar = navBar;
    [self.view addSubview:navBar];
    
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




#define headerVOriH 310


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.y - oriOffsetY;
    //NSLog(@"%f",scrollView.contentOffset.y);
    if (offset >= 0) {
        //往上走
        self.headerV.y = -offset;
        
    }else {
        self.headerV.y = 0;
        //往下走
        CGFloat headerH = headerVOriH - offset;
        self.headerV.height = headerH;
    }
    CGFloat alpha = offset * 1 / 136.0;
    self.navBar.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}


//返回当前组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"发布的声音";
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}







@end
