//
//  UIView+XMGNib.m
//  百思不得姐
//
//  Created by 王顺子 on 16/6/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+XMGNib.h"
#import "NSObject+XMGBundle.h"

@implementation UIView (XMGNib)

+ (instancetype)loadFromNib {

    UIView *view = [[self currentBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    return view;

}

- (UIViewController *)currentViewController
{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
