//
//  XMGNavMenueBar.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGNavMenueBar.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

#define kIndicatorColor  [UIColor redColor]
#define kTitleFont  [UIFont systemFontOfSize:16]
#define kLimitMargin 2
static CGFloat const kIndicatorHeight = 1;

@interface XMGNavMenueBar()

@property (nonatomic, weak) UIView *indicator;
@property (nonatomic, strong) NSMutableArray <UIButton *>*menueBtns;
@property (nonatomic, weak) UIButton *lastBtn;

@end

@implementation XMGNavMenueBar

-(NSMutableArray *)menueBtns {
    if (_menueBtns == nil)
    {
        _menueBtns = [NSMutableArray array];
    }
    return _menueBtns;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.scrollEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        // 2. 底部的指示器
        UIView *indicator = [[UIView alloc] init];
        indicator.frame = CGRectMake(0, self.height - kIndicatorHeight, kScreenWidth / 3, kIndicatorHeight);
        indicator.backgroundColor = kIndicatorColor;
        [self addSubview:indicator];
        self.indicator = indicator;
        
    }
    return self;
}

-(void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        
        btn.tag = [items indexOfObject:item];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.font = kTitleFont;
        [btn setTitle:item forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self addSubview:btn];
        
        // 保存到一个数组中
        [self.menueBtns addObject:btn];
        
        // 重新布局
        [self layoutIfNeeded];
        
    }
    
}

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    
    if(selectedIndex < 0 || selectedIndex > self.items.count - 1) return;
    
    _selectedIndex = selectedIndex;
    
    // 选中对应索引的按钮
    UIButton *btn = self.menueBtns[selectedIndex];
    [self btnClick:btn];
}


- (void)btnClick: (UIButton *)btn {
    
    // 通知代理
    if ([self.menueBarDelegate respondsToSelector:@selector(navMenueBarDidSelectIndex:fromIndex:)])
    {
        _selectedIndex = btn.tag;
        [self.menueBarDelegate navMenueBarDidSelectIndex:btn.tag fromIndex:self.lastBtn.tag];
    }
    
    
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicator.centerX = btn.centerX;
    }];
    
    
    // 自动滚动到中间位置
    
    CGFloat shouldScrollX = btn.centerX - self.width * 0.5;
    
    if (shouldScrollX < 0) {
        shouldScrollX = 0;
    }
    
    if (shouldScrollX > self.contentSize.width - self.width) {
        shouldScrollX = self.contentSize.width - self.width;
    }
    
    [self setContentOffset:CGPointMake(shouldScrollX, 0) animated:YES];
    
    
}



-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 1. 计算间距
    CGFloat titleTotalW = 0;
    NSMutableArray *widthArray = [NSMutableArray arrayWithCapacity:self.items.count];
    for (NSString *item in self.items) {
        
        NSDictionary *fontDic = @{
                                  NSFontAttributeName: kTitleFont
                                  };
        CGFloat width = [item sizeWithAttributes:fontDic].width;
        [widthArray addObject:@(width)];
        titleTotalW += width;
    }
    
    CGFloat margin = (self.width - titleTotalW) / (self.items.count + 1);
    margin = margin < kLimitMargin ? kLimitMargin : margin;
    
    
    // 布局topmMenue 内部控件
    CGFloat btnY = 0;
    
    CGFloat btnHeight = self.height;
    UIButton *lastBtn;
    for (int i = 0; i < self.menueBtns.count; i++) {
        // 计算每个控件的宽度
        CGFloat btnX = CGRectGetMaxX(lastBtn.frame);
        self.menueBtns[i].frame = CGRectMake(btnX, btnY, kScreenWidth / 3, btnHeight);
        lastBtn = self.menueBtns[i];
    }
    self.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame), 0);
}

@end
