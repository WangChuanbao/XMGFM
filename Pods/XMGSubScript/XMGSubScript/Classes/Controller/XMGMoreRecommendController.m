//
//  XMGMoreRecommendController.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMoreRecommendController.h"
#import "XMGRecommendsCell.h"
#import "XMGAlbumDetailController.h"
#import "Base.h"

@interface XMGMoreRecommendController ()

@end

@implementation XMGMoreRecommendController

static NSString * const recommendCellId = @"recommendCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView
{
    self.title = @"相关推荐";
    self.view.backgroundColor = kCommonColor;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendsCell class]) bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:recommendCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGRecommendsCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellId];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[XMGAlbumDetailController alloc]init] animated:YES];
}


@end
