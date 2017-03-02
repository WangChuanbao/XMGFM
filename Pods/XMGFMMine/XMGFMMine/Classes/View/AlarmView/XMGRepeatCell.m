//
//  XMGRepeatCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRepeatCell.h"

@interface XMGRepeatCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allChooseBtn;

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@end

@implementation XMGRepeatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSMutableArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"weekBtn"];

    
    for (UIButton *btn in self.allChooseBtn) {
        for (NSNumber *btnTag in array) {
            if ([btnTag integerValue] == btn.tag) {
                btn.selected = YES;
            }
        }
    }
    
    self.weekLabel.text = [self weekStringWithArray:array];

    
    self.bgImageView.image = [[UIImage imageNamed:@"longsit_firstcell_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
}

- (IBAction)btnClick:(UIButton *)btn {
    //设置按钮状态
    btn.selected = !btn.selected;
    //如果按钮为选中状态
    //获取当前选中的有哪些按钮.
    NSMutableArray *weekBtnArray = [NSMutableArray array];
    for (UIButton *btn in self.allChooseBtn) {
        if(btn.selected){
            [weekBtnArray addObject:@(btn.tag)];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:weekBtnArray forKey:@"weekBtn"];
    
    self.weekLabel.text = [self weekStringWithArray:weekBtnArray];
    
    
    
    
}


- (NSString *)weekStringWithArray:(NSArray *)array {
    
    //设置周
    NSString *weekString = nil;
    
    NSArray *weeks = array;
    if(weeks && weeks.count>0){
        weekString = @"每天";
        if(weeks.count < 7){
            if([weeks isEqualToArray:@[@(1),@(2),@(3),@(4),@(5)]]){
                weekString = @"工作日";
            }else if([weeks isEqualToArray:@[@(6),@(0)]]){
                weekString = @"周末";
            }else{
                weekString = @"";
                for (int i=0; i<weeks.count; i++) {
                    weekString = [weekString stringByAppendingFormat:@"%@  ",[self getWeekString:[weeks[i] integerValue]]];
                }
            }
        }
    }else {
        weekString = @"不重复";
    }
    
    return weekString;

}




//根据tag查看当前是周几.
- (NSString *)getWeekString:(NSInteger)week
{
    NSString *weekStr = @"";
    switch (week) {
        case 1: weekStr=@"周一";
            break;
        case 2: weekStr=@"周二";
            break;
        case 3: weekStr=@"周三";
            break;
        case 4: weekStr=@"周四";
            break;
        case 5: weekStr=@"周五";
            break;
        case 6: weekStr=@"周六";
            break;
        case 0: weekStr=@"周日";
            break;
        default: weekStr=@"周日";
            break;
    }
    return weekStr;
}






+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    XMGRepeatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepeatCell"];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGRepeatCell" owner:nil options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}


@end
