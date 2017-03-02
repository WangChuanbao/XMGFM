//
//  XMGAlarmVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlarmVC.h"
#import "XMGSoundCell.h"
#import "XMGRepeatCell.h"
#import "XMGChooseDateCell.h"
#import "XMGNoticeLocal.h"




@interface XMGAlarmVC ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger curRow;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic,weak)  UISwitch *SW;


@end

@implementation XMGAlarmVC

-(UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.curRow = -1;
    
    //判断闹钟开关是否为打开状态
    BOOL isOpenAlarm = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenAlarm"];
    
    if (isOpenAlarm) {
        self.sectionCount = 2;
    }else {
        self.sectionCount = 1;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        //第0组,显示开关
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
            cell.textLabel.text = @"闹钟开关";
            UISwitch *SW =  [[UISwitch alloc] init];
            [SW addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = SW;
            SW.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenAlarm"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        
        
    }else {
        //第1组
        if (indexPath.row == 0) {
            //第一行,选择天数
              cell =  [XMGRepeatCell cellWithTableView:tableView];
        }else if (indexPath.row == 1) {
            //第二行,选择时间
             cell =  [XMGChooseDateCell cellWithTableView:tableView];
        }else if (indexPath.row == 2) {
            //第三行.选择音乐
              cell =  [XMGSoundCell cellWithTableView:tableView];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)change:(UISwitch *)sw {
    
    [[NSUserDefaults standardUserDefaults] setBool:sw.on forKey:@"isOpenAlarm"];
    
    if (sw.on) {
        self.sectionCount = 2;
        [self.tableView reloadData];
    }else {
        self.sectionCount = 1;
        [XMGNoticeLocal cancleAlarmNotifications];
        [XMGNoticeLocal cancelKeepSleepNotice];
        [self.tableView reloadData];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 40;
    }else {
        
        if (indexPath.row == 0) {
            return  self.curRow == indexPath.row && self.isOpen ? 320 : 40;
            
        }else if (indexPath.row == 1) {
            return  self.curRow == indexPath.row && self.isOpen ? 220 : 40;
            
        }else if (indexPath.row == 2) {
            return  self.curRow == indexPath.row && self.isOpen ? 164 : 40;
        }
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        self.isOpen = !self.isOpen;
        
        if (self.curRow != indexPath.row) {
            self.isOpen = YES;
        }
        
        self.curRow = indexPath.row;
        
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

@end
