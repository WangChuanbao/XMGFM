//
//  XMGNavigationBar.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGNavigationBar.h"
#import "UIView+XMGNib.h"

@implementation XMGNavigationBar

+ (instancetype)showNavigaitonbar {
    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGNavigationBar" owner:nil options:nil] firstObject];

}

- (IBAction)backClick:(UIButton *)sender {
    
    UIViewController *vc  = [sender currentViewController];
    [vc.navigationController popViewControllerAnimated:YES];
}

@end
