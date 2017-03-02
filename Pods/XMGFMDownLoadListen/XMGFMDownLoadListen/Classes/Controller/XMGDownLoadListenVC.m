//
//  XMGDiscoverVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadListenVC.h"
#import "XMGSegmentBar.h"
#import "XMGAlbumTVC.h"
#import "XMGVoiceTVC.h"
#import "XMGDownLoadingTVC.h"
#import "Base.h"
#import "XMGConst.h"
#import "UIView+XMGLayout.h"
#import "XMGDeviceMessage.h"
#import "XMGCacheTool.h"



@interface XMGDownLoadListenVC ()<UIScrollViewDelegate, XMGSegmentBarDelegate>

@property (nonatomic, strong) XMGSegmentBar *segmentBar;
@property (nonatomic, weak) UIScrollView *contentScrollView;

@property (nonatomic, weak) UILabel *noticeLabel;

@end

@implementation XMGDownLoadListenVC

-(XMGSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        _segmentBar = [XMGSegmentBar segmentBarWithConfig:[XMGSegmentConfig defaultConfig]];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpInit];

    self.navigationItem.titleView = self.segmentBar;
    self.segmentBar.segmentMs = @[@"专辑", @"声音", @"下载中"];
    self.segmentBar.selectedIndex = 0;

    // 监听下载状态改变的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkMemory) name:kDownLoadStateChangeNotification object:nil];

}


-(void)dealloc
{
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpInit {

    self.view.backgroundColor = XMGColor(225, 225, 225);
    self.automaticallyAdjustsScrollViewInsets = NO;



    // 0. 添加子控制器
    [self addChildViewControllers];

    // 1. 添加占用内存横幅
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kNavigationBarMaxY, kScreenWidth, 20)];
    self.noticeLabel = noticeLabel;
    noticeLabel.backgroundColor = [UIColor grayColor];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.font = [UIFont systemFontOfSize:12];
    noticeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:noticeLabel];
    

    // 2. 添加内容视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarMaxY + 20, kScreenWidth, kScreenHeight - (kNavigationBarMaxY + 20 + kTabbarHeight))];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    self.contentScrollView = scrollView;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * self.childViewControllers.count, 0);
    [self.view addSubview:scrollView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self checkMemory];
}

- (void)checkMemory {

    // 剩余空间
    NSString *freeSpace = [XMGDeviceMessage freeDiskSpaceInBytes];

    // 已用空间
    // kDownLoadPath
    NSString *useSpace = [XMGCacheTool getSizeWithPath:NSHomeDirectory()];


    self.noticeLabel.text = [NSString stringWithFormat:@"已占用空间%@, 可用空间%@", useSpace, freeSpace];
    
}



- (void)addChildViewControllers {

    // 如果设置view的backgroundColor会提前出发viewDidLoad方法
    XMGAlbumTVC *albumTVC = [[XMGAlbumTVC alloc] init];
    [self addChildViewController:albumTVC];

    XMGVoiceTVC *voiceTVC = [[XMGVoiceTVC alloc] init];
    [self addChildViewController:voiceTVC];

    XMGDownLoadingTVC *downLoadTVC = [[XMGDownLoadingTVC alloc] init];
    [self addChildViewController:downLoadTVC];


}


- (void)showControllerView:(NSInteger)index {

    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];


}


- (void)segmentBarDidSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex
{
    [self showControllerView:toIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.selectedIndex = page;
    
}


@end
