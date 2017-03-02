//
//  XMGSettingRowItem.m
//  彩票
//
//  Created by 弓虽_子 on 16/3/5.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import "XMGSettingRowItem.h"

@implementation XMGSettingRowItem

+ (instancetype)settingRowItemWithImage:(UIImage *)image name:(NSString *)name {
    
    XMGSettingRowItem *rowItem =  [[self alloc] init];
    rowItem.image = image;
    rowItem.name = name;
    return rowItem;
}



@end
