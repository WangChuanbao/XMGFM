//
//  XMGSubscribeController.m
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import "XMGSubscribeController.h"
#import "XMGSubscribeCell.h"
#import "XMGSubscribeAlertView.h"
#import "XMGSubscribleDataTool.h"
#import "XMGAlbumDetailController.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGSubscribeController()<XMGSubscribeCellDelegate,XMGSubscribeAlertViewDelegate>
// 遮盖层
@property (nonatomic, strong) UIView *coverView;
// 底部弹窗
@property (nonatomic, strong) XMGSubscribeAlertView *alertView;
// 列表数据数组
@property (nonatomic, strong)NSArray *subscribledList;

@end

@implementation XMGSubscribeController

- (UIView *)coverView
{
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _coverView.backgroundColor = Color(0, 0, 0, 0.5);
    }
    return _coverView;
}

- (XMGSubscribeAlertView *)alertView
{
    if (_alertView == nil) {
        _alertView = [[[NSBundle mainBundle] loadNibNamed:@"XMGSubscribeAlertView" owner:nil options:nil] lastObject];
        _alertView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 132.5);
        _alertView.delegate = self;
    }
    return _alertView;
}

static NSString * const subscribeCellId = @"subscribeCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[XMGSubscribleDataTool shareInstance] getSubscribleList:^(NSArray<NSString *> *subscribleList, NSError *error) {
        self.subscribledList = subscribleList;
        [self.tableView reloadData];
    }];

    
    [self initView];
}

- (void)initView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGSubscribeCell class]) bundle:nil] forCellReuseIdentifier:subscribeCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - SubscribeCellDelegate
- (void)subscribeCellDidClickDownButton
{
    // 弹出底部弹窗
    [self showAlertView];
    
}

// 弹出底部弹窗
- (void)showAlertView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.y = kScreenHeight - 132.5;
        self.coverView.alpha = 1;
    }];
}

// 隐藏底部弹窗
- (void)hideAlertView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.y = kScreenHeight;
        self.coverView.alpha = 0;
    }];
    
}

#pragma mark - SubscribeAlertViewDelegate
- (void)subscribeAlertViewDidClickAlertButton:(NSString *)title
{
    if ([title isEqualToString:@"置顶"])
    {
        NSLog(@"置顶");
        
    }else if ([title isEqualToString:@"取消置顶"])
    {
        NSLog(@"取消置顶");
        
    }else if ([title isEqualToString:@"取消订阅"])
    {
        NSLog(@"取消订阅");
        
    }
    
    [self hideAlertView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideAlertView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.subscribledList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:subscribeCellId];
    cell.delegate = self;
    cell.subscribe = self.subscribledList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGSubscribe *subscribe = self.subscribledList[indexPath.row];
    return subscribe.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XMGSubscribe *subScribe = self.subscribledList[indexPath.row];
    
    XMGAlbumDetailController *vc =[[XMGAlbumDetailController alloc] init];
    vc.albumId = subScribe.albumId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
