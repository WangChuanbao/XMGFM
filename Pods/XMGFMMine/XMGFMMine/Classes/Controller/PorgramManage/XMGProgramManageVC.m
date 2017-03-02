//
//  XMGProgramManageVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGProgramManageVC.h"
#import "XMGProgramMHeader.h"


@interface XMGProgramManageVC ()

@end

@implementation XMGProgramManageVC


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"节目管理";
    self.tableView.tableHeaderView  = [XMGProgramMHeader programHeader];
    //添加一组
    [self setGroup1];
    [self setGroup2];
    [self setGroup3];
    
    
    
}


- (void)setGroup1{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_notice_center"] name:@"我的声音"];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_clock"] name:@"我的专辑"];
    XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_liked"] name:@"我的粉丝"];
    NSArray *rowArray1 = @[rowItem,rowItem1,rowItem2];
    
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
    
}

- (void)setGroup2{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_favAlbum"] name:@"推荐指数排名"];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_clock"] name:@"我的收益"];
    
     XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_liked"] name:@"更多服务"];

    NSArray *rowArray1 = @[rowItem,rowItem1,rowItem2];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}



- (void)setGroup3{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_boughttracks"] name:@"节目攻略"];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_account"] name:@"有声化平台"];
    
    
    NSArray *rowArray1 = @[rowItem,rowItem1];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = YES;
    
}


@end
