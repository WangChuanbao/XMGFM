//
//  XMGDownLoadBaseTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadBaseTVC.h"
#import "XMGNoDownLoadView.h"
#import "XMGTodayFireVC.h"
#import "Base.h"
#import "XMGDownLoadService.h"

@interface XMGDownLoadBaseTVC ()

@property (nonatomic, strong) XMGNoDownLoadView *noDataView;

@end

@implementation XMGDownLoadBaseTVC

-(void)setShowNoDataPane:(BOOL)showNoDataPane
{
    _showNoDataPane = showNoDataPane;

    self.noDataView.hidden = !_showNoDataPane;
}

-(XMGNoDownLoadView *)noDataView
{
    if (_noDataView == nil) {
        if ([NSStringFromClass([self class]) isEqualToString:@"XMGDownLoadingTVC"]) {
            _noDataView = [XMGNoDownLoadView noDownLoadViewWithType:XMGNoDownLoadViewNoDownLoading];
        }else
        {
            _noDataView = [XMGNoDownLoadView noDownLoadViewWithType:XMGNoDownLoadViewNoDownLoaded];
        }

        [self.tableView addSubview:_noDataView];
    }
    return _noDataView;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.noDataView.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.3);
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = kCommonColor;
    self.tableView.tableFooterView = [UIView new];

    kWeakSelf
    self.noDataView.clickBlock = ^{
//        XMGLog(@"跳转到查找界面")
        XMGTodayFireVC *todayF = [[XMGTodayFireVC alloc] init];
        [weakSelf.navigationController pushViewController:todayF animated:YES];
    };

    // 监听下载状态改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kDownLoadStateChangeNotification object:nil];

}

- (void)loadData {

}

-(void)dealloc
{
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
