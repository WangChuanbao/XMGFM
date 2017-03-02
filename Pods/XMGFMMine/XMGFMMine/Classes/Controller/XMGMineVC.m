//
//  XMGMineVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMineVC.h"
#import "XMGMineHeaderView.h"
#import "XMGMineMainViewController.h"
#import "XMGProgramManageVC.h"
#import "XMGSettingViewController.h"
#import "XMGRecordVC.h"
#import "Base.h"
#import "UIView+XMGLayout.h"


@interface XMGMineVC ()<UIScrollViewDelegate,UITableViewDelegate,XMGSettingViewController>

@property (nonatomic, strong)  XMGMineHeaderView *headerV ;

@property (nonatomic,weak) UITableView *tableView;

@end

@implementation XMGMineVC


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];

}



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
    XMGMineMainViewController *settingVC = [[XMGMineMainViewController alloc] init];
    settingVC.delegate = self;
    settingVC.view.frame = self.view.bounds;
    
    self.tableView = (UITableView *)settingVC.view;
    
    [self.view addSubview:settingVC.view];
    [self addChildViewController:settingVC];
    //设置内边距
    [settingVC.tableView setContentInset:UIEdgeInsetsMake(266, 0, 0, 0)];
    
    //添加头部视图
    XMGMineHeaderView *headerV = [XMGMineHeaderView mineHeaderView];
    headerV.width = kScreenWidth;
    headerV.height = 300;
    self.headerV = headerV;
    [self.view addSubview:headerV];
    
    
    //节目管理点击
    __weak typeof(self) weakSelf = self;
    self.headerV.programClickTask = ^{
        
        XMGProgramManageVC *manageVC = [[XMGProgramManageVC alloc] init];
        //跳转到节目管理控制器
        [weakSelf.navigationController pushViewController:manageVC animated:YES];
        
    };
    
    //点击录音
    self.headerV.recordClickTask = ^{

        XMGRecordVC *recorder = [[XMGRecordVC alloc] initWithNibName:@"XMGRecordVC" bundle:[NSBundle bundleForClass:[XMGRecordVC class]]];
     
        [weakSelf.navigationController pushViewController:recorder animated:YES];
    };
    
    //点击设置
    self.headerV.settingClickTask = ^{
           XMGSettingViewController *settingVC = [[XMGSettingViewController alloc] init];    [weakSelf.navigationController pushViewController:settingVC animated:YES];
    };
    
    
}

#define oriOffsetY -266
#define headerVOriH 300
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
    
    
}

- (void)settingScrollViewOffset:(CGFloat)offset {
    
    if (offset >= 0) {
        //往上走
        self.headerV.y = -offset;
        
    }else {
        self.headerV.y = 0;
        //往下走
        CGFloat headerH = headerVOriH - offset;
        self.headerV.height = headerH;
    }
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
     [self.navigationController.navigationBar setHidden:NO];
    
}


@end
