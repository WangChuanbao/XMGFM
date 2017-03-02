//
//  XMGSettingViewController.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSettingViewController.h"
#import "XMGAlarmVC.h"

#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    //添加一组
    [self setGroup1];
    [self setGroup2];
    [self setGroup3];
    [self setGroup4];
    [self setGroup5];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
    UIView *footV = [[UIView alloc] init];
    
    footV.frame = CGRectMake(0, 0, 0, 44);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateHighlighted];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    CGFloat borderW = 20;
    btn.frame = CGRectMake(borderW, 5, kScreenWidth - 2 * borderW, 35);
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    [footV addSubview:btn];
    self.tableView.tableFooterView = footV;
    
}




- (void)setGroup1{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"特色闹钟"];
    rowItem.desClass = [XMGAlarmVC class];
    
    
     XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"定时关闭"];
    
    
    
    
    NSArray *rowArray1 = @[rowItem,rowItem2];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
    
}

- (void)setGroup2{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"账号绑定"];
    
    NSArray *rowArray1 = @[rowItem];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}



- (void)setGroup3{
    
    //创建行.
    XMGSwitchItem *rowItem = [XMGSwitchItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"断点续听"];
    
    XMGSwitchItem *rowItem1 = [XMGSwitchItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"2G/3G/4G播放和下载"];
    
    XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"清理占用空间"];
    
    XMGArrowRowItem *rowItem3 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"推送设置"];
    
    XMGArrowRowItem *rowItem4 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"隐藏设置"];
    
    
    
    NSArray *rowArray1 = @[rowItem,rowItem1,rowItem2,rowItem3,rowItem4];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}


- (void)setGroup4{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"帮助中心"];
    
    
    NSArray *rowArray1 = @[rowItem];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}


- (void)setGroup5{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"亲,请评价,支持我们做的更好!"];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@""] name:@"关于"];
    
    
    NSArray *rowArray1 = @[rowItem,rowItem1];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}




@end
