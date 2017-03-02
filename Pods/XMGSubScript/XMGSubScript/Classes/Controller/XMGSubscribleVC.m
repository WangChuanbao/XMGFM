//
//  XMGSubscribleVC.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSubscribleVC.h"
#import "XMGNavMenueBar.h"
#import "XMGHistoryController.h"
#import "XMGRecommendController.h"
#import "XMGSubscribeController.h"
#import "Base.h"
#import "UIView+XMGLayout.h"
#import "XMGConst.h"

@interface XMGSubscribleVC ()<XMGNavMenueBarDelegate,UIScrollViewDelegate>
/* 导航上的菜单 */
@property (weak, nonatomic) XMGNavMenueBar *menueBar;
/* 全局的内容视图 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
@end

@implementation XMGSubscribleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0. 初始化UI
    [self setUpInit];
    
}

/**
 *  初始化UI
 */
- (void)setUpInit {
    // 0. 初始化界面
    self.view.backgroundColor = XMGColor(225, 225, 225);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1. 添加子控制器
    [self addChildViewControllers];
    
    // 2. 添加内容视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarMaxY, kScreenWidth, kScreenHeight - (kNavigationBarMaxY + kTabbarHeight))];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    self.contentScrollView = scrollView;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * self.childViewControllers.count, 0);
    [self.view addSubview:scrollView];
    
    // 3. 初始化导航菜单
    XMGNavMenueBar *menueBar = [[XMGNavMenueBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarMaxY - 20)];
    menueBar.menueBarDelegate = self;
    self.menueBar.backgroundColor = [UIColor redColor];
    self.menueBar = menueBar;
    menueBar.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = menueBar;
    
    // 4. 设置导航菜单数据
    self.menueBar.items = @[@"推荐", @"订阅", @"历史"];
    self.menueBar.selectedIndex = 0;
    
}

/**
 *  添加子控制器
 */
-(void)addChildViewControllers{
    // 0. 推荐
    XMGRecommendController *recommendVC = [[XMGRecommendController alloc] init];
    [self addChildViewController:recommendVC];
    
    // 1. 订阅
    XMGSubscribeController *subscribeVC = [[XMGSubscribeController alloc] init];
    [self addChildViewController:subscribeVC];
    
    // 2. 历史
    XMGHistoryController *historyVC = [[XMGHistoryController alloc] init];
    [self addChildViewController:historyVC];
    
    

}

/**
 *  导航菜单切换
 *
 *  @param selectedIndex 当前索引
 *  @param fromIndex     到达索引
 */
- (void)navMenueBarDidSelectIndex:(NSInteger)selectedIndex fromIndex:(NSInteger)fromIndex
{
    [self showControllerView:selectedIndex];
}


/**
 *  根据索引展示控制器
 *
 *  @param index 索引
 */
- (void)showControllerView:(NSInteger)index {
    
    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
    
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.menueBar.selectedIndex = page;
}

@end
