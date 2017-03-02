
//
//  XMGTagController.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTagController.h"
#import "XMGRecommendsCell.h"
#import "XMGAlbumDetaiVedioCell.h"
#import "XMGTagSortView.h"
#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGTagController ()<XMGTagSortViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
// 遮盖层
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) XMGTagSortView *sortView;
// 标志下拉框的显示与隐藏
@property (nonatomic, assign) NSInteger flag;
@end

@implementation XMGTagController

- (UIView *)coverView
{
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _coverView.backgroundColor = Color(0, 0, 0, 0.5);
    }
    return _coverView;
}

- (XMGTagSortView *)sortView
{
    if (_sortView == nil) {
        _sortView = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGTagSortView" owner:nil options:nil].firstObject;
        _sortView.frame = CGRectMake(0, 0, kScreenWidth, 44);
        _sortView.delegate = self;
    }
    return _sortView;
}

static NSString * const recommendCellId = @"recommendCell";
static NSString * const vedioCellId = @"vedioCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView
{
    self.title = @"标签";
    self.view.backgroundColor = kCommonColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"排序" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    
    self.segmentControl.selectedSegmentIndex = 1;
    [self.segmentControl addTarget:self action:@selector(segmentControlChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGAlbumDetaiVedioCell class]) bundle:nil] forCellReuseIdentifier:vedioCellId];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendsCell class]) bundle:nil] forCellReuseIdentifier:recommendCellId] ;

}

- (void)rightBarButtonClick
{
    if (self.flag == 0) {
        [self showSortView];
    }else
    {
        [self hideSortView];
    }
}

- (void)showSortView
{
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.sortView];
    [UIView animateWithDuration:0.3 animations:^{
        self.sortView.y = 64;
        self.coverView.alpha = 1;
    }];
    self.flag = 1;
}

- (void)hideSortView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.sortView.y = 0;
        self.coverView.alpha = 0;
    }];
    self.flag = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideSortView];
}

- (void)segmentControlChangeValue:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) { // 声音
        
    }else
    {
        
    }
    [self.tableView reloadData];
}

#pragma mark - XMGTagSortViewDelegate
- (void)tagSortDidClickButton:(NSString *)title
{
    if ([title isEqualToString:@"最火"]) {
        
    }else if ([title isEqualToString:@"最新上传"]) {
        
    }else if ([title isEqualToString:@"最多播放"]) {
        
    }
    [self hideSortView];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentControl.selectedSegmentIndex == 0)
    {
        return 20;
    }else
    {
         return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentControl.selectedSegmentIndex == 0) {
        XMGAlbumDetaiVedioCell *cell = [tableView dequeueReusableCellWithIdentifier:vedioCellId];
//        cell.track = self.menuListArr[indexPath.row];
        return cell;
    }else
    {
        XMGRecommendsCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellId];
        //    cell.recommends = self.recommendList[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentControl.selectedSegmentIndex == 0)
    {
        return 70;
    }else
    {
        return 90;
    }
}


@end
