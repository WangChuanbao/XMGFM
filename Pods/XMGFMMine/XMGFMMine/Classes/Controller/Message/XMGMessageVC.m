//
//  XMGMessageVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMessageVC.h"
#import "UIImage+XMGImage.h"
#import "XMGMessageCenterCell.h"

@interface XMGMessageVC ()

@end

@implementation XMGMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加一组
    [self setGroup1];
    [self setGroup1];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    
    self.title = @"消息中心";
}




- (void)setGroup1{
    
    
    //创建行.
    
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[[UIImage imageNamed:@"messageCenter_news_comment"] circleImage]   name:@"评论"];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[[UIImage imageNamed:@"messageCenter_news_circle"] circleImage] name:@"消息圈子"];
  
    NSArray *rowArray1 = @[rowItem,rowItem1];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }else {
        
        XMGMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCenterCell"];
        if (cell == nil) {
            cell = [XMGMessageCenterCell messageCenterCell];
        }
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }else {
    
        return 70;
    }
}


@end
