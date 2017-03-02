//
//  XMGPayVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPayVC.h"
#import "XMGButtonItem.h"
#import "XMGBuyVc.h"
#import "XMGConsumRecordVC.h"
#import "XMGPayRecodVC.h"

@interface XMGPayVC ()

@end

@implementation XMGPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的账号";
    
    //添加一组
    [self setGroup1];
    [self setGroup2];
    
}



- (void)setGroup1{
    //创建行.
    XMGButtonItem *rowItem = [XMGButtonItem settingRowItemWithImage:nil name:@"可用余额: 0.0 喜点"];
    rowItem.desClass = [XMGBuyVc class];
    rowItem.buttonName = @"充值";
    rowItem.color = [UIColor orangeColor];

    
    NSArray *rowArray1 = @[rowItem];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
    
}

- (void)setGroup2{
    
    //创建行
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:nil name:@"充值记录"];
    rowItem.desClass = [XMGPayRecodVC class];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:nil name:@"消费记录"];
    rowItem1.desClass = [XMGConsumRecordVC class];
    
    NSArray *rowArray1 = @[rowItem,rowItem1];
    
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    
    [self.groupArray addObject:groupItem];
}





@end
