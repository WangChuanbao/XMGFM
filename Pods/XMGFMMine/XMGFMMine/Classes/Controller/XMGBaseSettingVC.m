//
//  XMGBaseSettingVC.m
//  彩票
//
//  Created by 弓虽_子 on 16/3/6.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import "XMGBaseSettingVC.h"

@interface XMGBaseSettingVC ()

@end

@implementation XMGBaseSettingVC

//初始化为一个组样式
-(instancetype)init {
    
    return [super initWithStyle:UITableViewStyleGrouped];
    
}

//创建存放组模型的数组
- (NSMutableArray *)groupArray {
    
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}
//共有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArray.count;
}
//每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //取出当前的组模型
    XMGSettingGroupItem *groupItem =  self.groupArray[section];
    //返加第一组里面行的个数
    return groupItem.rowArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前的Cell
    XMGSettingCell *cell = [XMGSettingCell cellWithTableView:tableView cellStyle:UITableViewCellStyleDefault];
    
    
    //取出当前的组模型
    XMGSettingGroupItem *groupItem =  self.groupArray[indexPath.section];
    //取出组模型当中的每一行.
    XMGSettingRowItem *item = groupItem.rowArray[indexPath.row];
    //把行模型传递给Cell
    cell.rowItem = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取出当前的组模型
    XMGSettingGroupItem *groupItem =  self.groupArray[indexPath.section];
    //取出组模型当中的每一行.
    XMGSettingRowItem *item = groupItem.rowArray[indexPath.row];
    //如果有要执行的Block
    if (item.myTask) {
        //直接执行Block
        item.myTask(indexPath);
        //执行完后,直接返回
        return;
    }
    
    if (item.desClass) {
        //创建控制器.跳转到目标控制器
        UIViewController *vc = [[item.desClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    //判断行模型的类型.
//    if ([item isKindOfClass:[XMGArrowRowItem class]]) {
//        //如果是箭头模型,
//        XMGArrowRowItem *arrowItem = (XMGArrowRowItem *)item;
//        if (arrowItem.desClass) {
//            //创建控制器.跳转到目标控制器
//            UIViewController *vc = [[arrowItem.desClass alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
}

//返回当前组的尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    XMGSettingGroupItem *item = self.groupArray[section];
    return item.footerTitle;
}
//返回当前组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    XMGSettingGroupItem *item = self.groupArray[section];
    return item.headerTitle;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 35;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}



@end
