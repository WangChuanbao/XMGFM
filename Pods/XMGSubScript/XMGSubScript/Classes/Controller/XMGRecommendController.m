//
//  XMGRecommendController.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import "XMGRecommendController.h"
#import "XMGRecommendsCell.h"
#import "XMGSubscribleDataTool.h"
#import "XMGAlbumDetailController.h"


@interface XMGRecommendController()
@property (nonatomic, strong)NSArray *recommendList;
@end

@implementation XMGRecommendController

static NSString * const recommendCellId = @"recommendCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[XMGSubscribleDataTool shareInstance] getRecommandList:^(NSArray<NSString *> *recommendList, NSError *error) {
        self.recommendList = recommendList;
        [self.tableView reloadData];
    }];
    
    [self initView];
}

- (void)initView
{


    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendsCell class]) bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:recommendCellId] ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGRecommendsCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellId];
    cell.recommends = self.recommendList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRecommends *recommends = self.recommendList[indexPath.row];
    return recommends.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMGRecommends *recommends = self.recommendList[indexPath.row];
    
    XMGAlbumDetailController *vc =[[XMGAlbumDetailController alloc]init];
    vc.albumId = recommends.albumId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
