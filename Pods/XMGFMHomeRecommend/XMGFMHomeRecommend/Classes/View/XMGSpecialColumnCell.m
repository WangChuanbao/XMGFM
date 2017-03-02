//
//  XMGSpecialColumnCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSpecialColumnCell.h"
#import "XMGCellInCell.h"

#define kCellMargin 10

@interface XMGSpecialColumnCell()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XMGSpecialColumnCell

static NSString *const cellID = @"CellTypeList2";


+ (instancetype)cellWithTableView: (UITableView *)tableView {

    XMGSpecialColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {

        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"XMGSpecialColumnCell" owner:nil options:nil].firstObject;
//        cell = [XMGSpecialColumnCell loadFromNib];
    }
    return cell;

}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.rowHeight = 80;
    self.tableView.scrollEnabled = NO;
}

-(void)setGroupM:(XMGGroupModel *)groupM
{
    _groupM = groupM;
    self.titleLabel.text = groupM.title;
    [self.tableView reloadData];
    
}

- (IBAction)more {
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupM.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCellInCell *cell = [XMGCellInCell cellWithTableView:tableView];

    XMGSpecialColumnModel *specialM = self.groupM.list[indexPath.row];
    if (![specialM isKindOfClass:[XMGSpecialColumnModel class]]) {
        return nil;
    }

    cell.specialColumnM = specialM;

    return cell;

}

@end
