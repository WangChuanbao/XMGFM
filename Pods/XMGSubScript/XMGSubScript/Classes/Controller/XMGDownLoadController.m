//
//  XMGDownLoadController.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadController.h"
#import "XMGDownLoadCell.h"
#import "XMGSubscribleDataTool.h"
#import "Base.h"

@interface XMGDownLoadController ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XMGDownLoadController

static NSString * const downloadCellId = @"downloadCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self initData];
}

- (void)initView
{
    self.title = @"批量下载";
    self.view.backgroundColor = kCommonColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下载中" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGDownLoadCell class]) bundle:nil] forCellReuseIdentifier:downloadCellId] ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)initData
{
    [[XMGSubscribleDataTool shareInstance] getDownLoadListAlbumId:self.albumId position:4 result:^(NSArray<NSString *> *downLoadList, NSError *error) {
        
    }];
}

- (void)rightBarButtonClick
{
    self.tabBarController.selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 立即下载
- (IBAction)downloadButtonClick {
    
}

// 全选
- (IBAction)chooseAllButtonClick:(UIButton *)sender {
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadCellId];
//    cell.recommends = self.recommendList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}






@end
