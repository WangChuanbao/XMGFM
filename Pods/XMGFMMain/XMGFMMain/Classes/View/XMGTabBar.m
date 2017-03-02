//
//  XMGTbabBar.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTabBar.h"
#import "XMGNavigationController.h"
#import "XMGMiddleView.h"
#import "UIView+XMGLayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface XMGTabBar()


@property (nonatomic, strong) UIWindow *middleWindow;

@end


@implementation XMGTabBar


/**
 懒加载中间控件

 @return 中间的按钮控件
 */
- (XMGMiddleView *)middleView {
    if (_middleView == nil) {
        XMGMiddleView *middleView = [XMGMiddleView shareInstance];
        [self addSubview:middleView];
        _middleView = middleView;
    }
    return _middleView;
}


//- (UIWindow *)middleWindow {
//    if (!_middleWindow) {
//        CGFloat width = 65;
//        CGFloat height = 65;
//        CGRect rect = CGRectMake((kScreenWidth - width) * 0.5, (kScreenHeight - height), width, height);
//        _middleWindow = [[UIWindow alloc] initWithFrame:rect];
//        _middleWindow.backgroundColor = [UIColor clearColor];
//        _middleWindow.rootViewController = [UIViewController new];
//        _middleWindow.windowLevel = UIWindowLevelNormal + 1;
//        [_middleWindow setHidden:NO];
//
//
//        XMGMiddleView *middleView = [XMGMiddleView middleView];
//        self.middleView = middleView;
//        middleView.frame = CGRectMake(0, 0, width, height);
//        [_middleWindow addSubview:middleView];
//
//
//
//    }
//    return _middleWindow;
//}


// 这里可以做一些初始化设置
-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}


- (void)setUpInit {

    // 设置样式, 去除tabbar上面的黑线
    self.barStyle = UIBarStyleBlack;

    // 设置tabbar 背景图片
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *bundleName = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
    NSString *path = [currentBundle pathForResource:@"tabbar_bg@2x.png" ofType:nil inDirectory:bundleName];

    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.backgroundImage = image;


    // 添加一个按钮, 准备放在中间
//    [self middleWindow];
    CGFloat width = 65;
    CGFloat height = 65;
    self.middleView.frame = CGRectMake((kScreenWidth - width) * 0.5, (kScreenHeight - height), width, height);

}


-(void)setMiddleClickBlock:(void (^)(BOOL))middleClickBlock {
    _middleClickBlock = middleClickBlock;
    self.middleView.middleClickBlock = middleClickBlock;
}


-(void)layoutSubviews {
    [super layoutSubviews];

    // 将中间按钮, 移动到顶部
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window.rootViewController.view bringSubviewToFront:self.middleBtn];


    NSInteger count = self.items.count;

    // 1. 遍历所有的子控件
    NSArray *subViews = self.subviews;

    // 确定单个控件的大小
    CGFloat btnW = self.width / (count + 1);
    CGFloat btnH = self.height;
    CGFloat btnY = 5;

    NSInteger index = 0;
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == count / 2) {
                index ++;
            }

            CGFloat btnX = index * btnW;
            subView.frame = CGRectMake(btnX, btnY, btnW, btnH);

            index ++;
        }
    }

    self.middleView.centerX = self.frame.size.width * 0.5;
    self.middleView.y = self.height - self.middleView.height;

}



-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{

    // 设置允许交互的区域
    CGPoint pointInMiddleBtn = [self convertPoint:point toView:self.middleView];

    CGPoint middleBtnCenter = CGPointMake(33, 33);
    CGFloat distance = sqrt(pow(pointInMiddleBtn.x - middleBtnCenter.x, 2) + pow(pointInMiddleBtn.y - middleBtnCenter.y, 2));

    if (pointInMiddleBtn.y < 3.5 || (distance > 33 && pointInMiddleBtn.y < 18)) {
        return NO;
    }

    return YES;
}



@end
