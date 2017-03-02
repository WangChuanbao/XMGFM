//
//  XMGChooseDateCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGChooseDateCell.h"
#import "CountdownView.h"
#import "XMGNoticeLocal.h"

@interface XMGChooseDateCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet CountdownView *countDown;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;

@property (nonatomic, strong)  NSDate *date;

@end

@implementation XMGChooseDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置背景
    self.bgImageView.image = [[UIImage imageNamed:@"longsit_middlecell_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    //添加定时器,更新标记
    self.countDown.hidden = YES;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    //获取之前保存的日期
    NSDate *preDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"alarmTime"];
    if (preDate) {
        //如果有,设置日期
        [self.datePick setDate:preDate];
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"H:mm";
        NSString *dateStr = [fmt stringFromDate:preDate];
        self.timeLabel.text = [NSString stringWithFormat:@"%@",dateStr];
    }
}

- (IBAction)valueChange:(UIDatePicker *)sender {
    
    //显示倒计时
    self.countDown.hidden = NO;
    //获取日期
    NSDate *date = sender.date;
    //格式化日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"H:mm";
    NSString *dateStr = [fmt stringFromDate:date];
    //设置选择的日期
    self.timeLabel.text = [NSString stringWithFormat:@"%@",dateStr];
    //更新定时器
    [self.countDown updateWithDate:date];
    self.date = date;
    //比较两个时间
    if ([self.date compare:[NSDate date]] == NSOrderedAscending) {
        //如果当前时间大
        self.date = [self.date dateByAddingTimeInterval:3600 * 24];
        [XMGNoticeLocal RegisterLocalNotificationWithFireDate:self.date repeatType:0 keepSleep:NO];
    }else {
        [XMGNoticeLocal RegisterLocalNotificationWithFireDate:self.date repeatType:0 keepSleep:NO];
    }
    //保存日期
    [[NSUserDefaults standardUserDefaults] setObject:self.date forKey:@"alarmTime"];
}

//更新定时器
- (void)timeChange {
    
    if ([self.date compare:[NSDate date]] == NSOrderedAscending) {
        self.date = [self.date dateByAddingTimeInterval:3600 * 24];
    }
    [self.countDown updateWithDate:self.date];
}

//创建Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    XMGChooseDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell"];
    if (cell == nil) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGChooseDateCell" owner:nil options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}




@end
