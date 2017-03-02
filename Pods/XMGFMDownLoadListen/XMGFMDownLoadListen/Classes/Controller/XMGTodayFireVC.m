//
//  XMGTodayFireVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVC.h"
#import "XMGSegmentBar.h"

#import "XMGDownLoadDataTool.h"
#import "XMGTodayFireVoiceListTVC.h"
#import "UIView+XMGLayout.h"
#import "XMGConst.h"
#import "Base.h"


@interface XMGTodayFireVC ()<UIScrollViewDelegate, XMGSegmentBarDelegate>

@property (nonatomic, strong) XMGSegmentBar *segmentBar;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray<XMGCategoryModel *> *categoryMs;

@end

@implementation XMGTodayFireVC

-(XMGSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        XMGSegmentConfig *config = [XMGSegmentConfig defaultConfig];
        config.isShowMore = YES;
        _segmentBar = [XMGSegmentBar segmentBarWithConfig:config];
        _segmentBar.y = kNavigationBarMaxY;
        _segmentBar.backgroundColor = [UIColor whiteColor];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}

-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarMaxY + self.segmentBar.height, kScreenWidth, kScreenHeight - (kNavigationBarMaxY + self.segmentBar.height))];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
        _contentScrollView = scrollView;
    }
    return _contentScrollView;
}

-(void)setCategoryMs:(NSArray<XMGCategoryModel *> *)categoryMs
{
    _categoryMs = categoryMs;
    [self setUpWithItems:[categoryMs valueForKeyPath:@"name"]];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"今日最火";
    self.view.tag = 666;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kCommonColor;
    
    // 2. 添加内容视图
    [self.view addSubview:self.contentScrollView];

    // 1. 设置菜单栏
    [self.view addSubview:self.segmentBar];



    // 3. 加载数据
    kWeakSelf
    [[XMGDownLoadDataTool shareInstance] getTodayFireShareAndCategoryData:^(XMGShareModel *shareM, NSArray<XMGCategoryModel *> *categoryMs) {
        weakSelf.categoryMs = categoryMs;
    }];
}


- (void)setUpWithItems: (NSArray <NSString *>*)items {

    // 0.添加子控制器
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (int i = 0; i < items.count; i++) {
        XMGTodayFireVoiceListTVC *vc = [[XMGTodayFireVoiceListTVC alloc] init];
        vc.view.backgroundColor = XMGRandomColor;
        [self addChildViewController:vc];
    }

    // 1. 设置菜单项展示
    self.segmentBar.segmentMs = items;

    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * items.count, 0);

    self.segmentBar.selectedIndex = 0;
}

- (void)showControllerView:(NSInteger)index {

    XMGTodayFireVoiceListTVC *cvc = self.childViewControllers[index];
    cvc.loadKey = self.categoryMs[index].key;
    UIView *view = cvc.view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
    
}



- (void)segmentBarDidSelectIndex:(NSInteger)selectedIndex fromIndex:(NSInteger)fromIndex
{
    [self showControllerView:selectedIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.selectedIndex = page;
    
}



@end
