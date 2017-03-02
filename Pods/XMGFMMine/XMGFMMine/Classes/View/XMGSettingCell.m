//
//  XMGSettingCell.m
//  彩票
//
//  Created by 弓虽_子 on 16/3/6.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//
#import "XMGSettingCell.h"
#import "XMGSettingRowItem.h"
#import "XMGArrowRowItem.h"
#import "XMGSwitchItem.h"
#import "XMGButtonItem.h"

#import "Base.h"
#import "UIView+XMGLayout.h"

@implementation XMGSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)style{
    
    static NSString *ID = @"settingCell";
    XMGSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if ( cell == nil) {
        
        cell = [[XMGSettingCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.layer.cornerRadius = 5;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;

}

//根据传入的模型决定Cell显示什么样的内容
- (void)setRowItem:(XMGSettingRowItem *)rowItem {

    _rowItem = rowItem;
    //设置数据
    [self setData:rowItem];
    //设置辅助视图
    [self setAssoryView:rowItem];
  
}
//设置数据
- (void)setData:(XMGSettingRowItem *)rowItem {
    
    self.imageView.image = rowItem.image;
    self.textLabel.text = rowItem.name ;
    self.detailTextLabel.text = rowItem.detailTitle;
    
}
//设置辅助视图
- (void)setAssoryView:(XMGSettingRowItem *)rowItem {
    //判断模型的类型
    if ([rowItem isKindOfClass:[XMGArrowRowItem class]]) {
        //设置为剪头
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow_all"]];
        imageV.width = 8;
        imageV.height = 15;
        self.accessoryView = imageV;
    }else if ([rowItem isKindOfClass:[XMGSwitchItem class]]) {
        //设置为开关
        self.accessoryView = [[UISwitch alloc] init];
    }else if ([rowItem isKindOfClass:[XMGButtonItem class]]) {
        
        XMGButtonItem *btnM = (XMGButtonItem *)rowItem;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnM.buttonName forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_bg_t"] forState:UIControlStateNormal];
        [btn setTitleColor:btnM.color forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn sizeToFit];
        btn.userInteractionEnabled = NO;
        btn.height = self.height - 2 *10;
        btn.width += 2 * 10;
        
        self.accessoryView = btn;
        
    }else {
        //如果都不是, 那么不设置
        self.accessoryView = nil;
    }
}

//#define margin 10
//- (void)setFrame:(CGRect)frame {
//    frame.origin.x = margin;
//    frame.size.width -= 2 * margin;
//    frame.size.height -= 3;
//    [super setFrame:frame];
//}

@end
