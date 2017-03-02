//
//  XMGAlbumRecommendCell.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumRecommendCell.h"
#import "XMGRecommendsCell.h"
#import "XMGOtherRecommands.h"
#import "XMGOtherRecommand.h"
#import "XMGAlbumDetailController.h"
#import "UIView+XMGLayout.h"
#import "Base.h"

@interface XMGAlbumRecommendCell()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XMGAlbumRecommendCell

- (void)setOtherRecommands:(XMGOtherRecommands *)otherRecommands{
    _otherRecommands = otherRecommands;
    
}

static NSString * const recommendCellId = @"recommendCell";
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initView];
    
}

- (void)initView
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kCommonColor;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendsCell class]) bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:recommendCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.otherRecommands.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRecommendsCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellId];
    cell.otherRecommand = self.otherRecommands.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGOtherRecommand *otherRecommand = self.otherRecommands.list[indexPath.row];
    return otherRecommand.recommandCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XMGOtherRecommand *otherRecommand = self.otherRecommands.list[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(albumRecommendCellDidSelectCell:)]) {
        [self.delegate albumRecommendCellDidSelectCell:otherRecommand.albumId];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectio{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 40)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"相关推荐";
    [header addSubview:label];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    footer.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [btn setTitle:@"查看更多推荐" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(getMoreRecommand) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:btn];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

/** 查看更多推荐 **/
- (void)getMoreRecommand{
    self.getMoreRecommend();
}

@end
