//
//  XMGCommentTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentTVC.h"
#import "XMGCommentInfoModel.h"
#import "XMGCommentCell.h"
#import "XMGPlayerDataTool.h"
#import "Base.h"

@interface XMGCommentTVC ()

@property (nonatomic, strong) NSArray <XMGCommentInfoModel *>*commentInfoMs;

@end

@implementation XMGCommentTVC


-(void)setCommentInfoMs:(NSArray<XMGCommentInfoModel *> *)commentInfoMs
{
    _commentInfoMs = commentInfoMs;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有评论";

    kWeakSelf

    [[XMGPlayerDataTool shareInstance] getCommentMsWithTrackId:self.trackId retuslt:^(NSArray<XMGCommentInfoModel *> *commentMs) {
        weakSelf.commentInfoMs = commentMs;
    }];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentInfoMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGCommentCell *cell = [XMGCommentCell cellWithTableView:tableView];
    
    XMGCommentInfoModel *commentM = self.commentInfoMs[indexPath.row];

    cell.commentInfoM = commentM;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentInfoModel *commentM = self.commentInfoMs[indexPath.row];
    return commentM.cellHeight;
}

@end
