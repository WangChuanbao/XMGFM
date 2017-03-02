//
//  XMGFMAnchorTVC.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMAnchorTVC.h"
#import "XMGFMAnchorDataTool.h"
#import "XMGFMAnchorGroupCell.h"
#import "XMGFMSingerGroupCell.h"

@interface XMGFMAnchorTVC ()

@property (nonatomic, strong) NSArray <XMGFMAnchorGroupModel *>*anchorGroupMs;


@end

@implementation XMGFMAnchorTVC

-(void)setAnchorGroupMs:(NSArray<XMGFMAnchorGroupModel *> *)anchorGroupMs
{
    _anchorGroupMs = anchorGroupMs;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];

    [[XMGFMAnchorDataTool shareInstance] getAnchorMs:^(NSArray<XMGFMAnchorGroupModel *> *anchorGroupMs) {
        NSLog(@"%@", anchorGroupMs);
        self.anchorGroupMs = anchorGroupMs;
    }];


}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.anchorGroupMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGFMAnchorGroupModel *groupM = self.anchorGroupMs[indexPath.row];

    // 6个, 上下列表样式
    if (groupM.displayStyle == 2) {
        // 九宫格样式, 4个, 或者 6个
        XMGFMSingerGroupCell *cell = [XMGFMSingerGroupCell cellWithTableView:tableView];
        cell.anchorGroupM = groupM;

        return cell;


    }else {
        // 九宫格样式, 4个, 或者 6个
        XMGFMAnchorGroupCell *cell = [XMGFMAnchorGroupCell cellWithTableView:tableView];
        cell.anchorGroupM = groupM;

        return cell;

    }

    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGFMAnchorGroupModel *groupM = self.anchorGroupMs[indexPath.row];

    return groupM.cellHeight;

}


@end
