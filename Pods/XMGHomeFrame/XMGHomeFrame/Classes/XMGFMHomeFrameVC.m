//
//  XMGFMHomeFrameVC.m
//  Pods
//
//  Created by 王顺子 on 16/10/21.
//
//

#import "XMGFMHomeFrameVC.h"
#import "XMGSegmentBar.h"

@interface XMGFMHomeFrameVC ()<XMGSegmentBarDelegate, UIScrollViewDelegate>

/**
 可以通过这个属性配置相关参数, 比如位置, 是否显示更多, 默认索引等
 */
@property (nonatomic, weak, readonly) XMGSegmentBar *segmentBar;

@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation XMGFMHomeFrameVC
@synthesize segmentBar = _segmentBar;


- (void)setIsShowMore:(BOOL)isShowMore {
    _isShowMore = isShowMore;
    [self.segmentBar updateViewWithConfig:^(XMGSegmentConfig *config) {
        config.isShowMore = isShowMore;
    }];
}

-(XMGSegmentBar *)segmentBar {
    if (!_segmentBar) {

        XMGSegmentBar *segmentBar = [XMGSegmentBar segmentBarWithConfig:[XMGSegmentConfig defaultConfig]];
        _segmentBar = segmentBar;
        _segmentBar.backgroundColor = [UIColor whiteColor];
        _segmentBar.frame = self.segBarFrame;
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}


-(UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        // 2. 添加内容视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentScrollViewFrame];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        _contentScrollView = scrollView;
        [self.view addSubview:scrollView];
    }
    return _contentScrollView;
}

-(void)setContentScrollViewFrame:(CGRect)contentScrollViewFrame
{
    _contentScrollViewFrame = contentScrollViewFrame;
    self.contentScrollView.frame = _contentScrollViewFrame;
}


-(void)setSegBarFrame:(CGRect)segBarFrame {
    _segBarFrame = segBarFrame;
    self.segmentBar.frame = segBarFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)setUpWithSegModels:(NSArray <id<XMGSegmentModelProtocol>>*)segMs andChildVCs:(NSArray <UIViewController *>*)subVCs {

    // 0. 添加子控制器
    for (UIViewController *vc in subVCs) {
        [self addChildViewController:vc];
    }

    self.segmentBar.segmentMs = segMs;
    // 1. 设置菜单栏
    [self.view addSubview:self.segmentBar];

    // 2. 设置代理
    self.segmentBar.delegate = self;

    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width * self.childViewControllers.count, 0);

}

-(void)setSegSelectIndex:(NSInteger)segSelectIndex {
    self.segmentBar.selectedIndex = segSelectIndex;
}





- (void)showControllerView:(NSInteger)index {

    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.frame.size.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];


}


- (void)segmentBarDidSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex
{
    [self showControllerView:toIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentBar.selectedIndex = page;
    
}


@end
