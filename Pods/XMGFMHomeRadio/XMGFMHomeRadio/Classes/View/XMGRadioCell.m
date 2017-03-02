//
//  XMGRadioCell.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRadioCell.h"
#import "XMGRadioInfoCell.h"
#import "XMGRadioModel.h"



#define kCellMargin 10
@interface XMGRadioCell () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation XMGRadioCell



- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.scrollEnabled =NO;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}


// 更多按钮点击
- (IBAction)more:(UIButton *)sender {
    
    self.moreBlock(self);
}

- (void)setListMs:(XMGRadioModels *)listMs
{
    
    _listMs = listMs;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.titleLabel.text = listMs.location;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMGRadioModel *model = self.listMs.models[indexPath.row];
    
    XMGRadioInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMGRadioInfoCell"];
    
    if (!cell) {
        cell = [[NSBundle bundleForClass:[XMGRadioInfoCell class]] loadNibNamed:@"XMGRadioInfoCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0;
}

@end
