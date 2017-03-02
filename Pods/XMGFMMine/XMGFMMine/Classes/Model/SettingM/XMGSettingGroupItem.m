//
//  XMGSettingGroupItem.m
//  彩票
//
//  Created by 弓虽_子 on 16/3/5.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import "XMGSettingGroupItem.h"

@implementation XMGSettingGroupItem


+ (instancetype)settingGroupItemWithRowArray:(NSArray *)rowArray headerT:(NSString *)headerTitle footerT:(NSString *)footerTitle {

   XMGSettingGroupItem *groupItem =  [[self alloc] init];
    groupItem.rowArray = rowArray;
    groupItem.footerTitle = footerTitle;
    groupItem.headerTitle = headerTitle;
    return groupItem;
}

@end
