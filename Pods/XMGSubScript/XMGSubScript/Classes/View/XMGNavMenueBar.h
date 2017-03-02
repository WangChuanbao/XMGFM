//
//  XMGNavMenueBar.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMGNavMenueBarDelegate <NSObject>
/** 点击选中 **/
- (void)navMenueBarDidSelectIndex:(NSInteger)selectedIndex fromIndex: (NSInteger)fromIndex;

@end

@interface XMGNavMenueBar : UIScrollView

@property (nonatomic, weak) id<XMGNavMenueBarDelegate> menueBarDelegate;
@property (nonatomic, strong) NSArray <NSString *>*items;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
