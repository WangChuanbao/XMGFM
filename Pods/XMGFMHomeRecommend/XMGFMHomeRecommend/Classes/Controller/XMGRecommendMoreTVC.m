//
//  XMGRecommendMoreTVC.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendMoreTVC.h"
#import "XMGRecommendDataTool.h"
#import "XMGNominateEditorCell.h"
#import "HomeRecommendDefine.h"

@interface XMGRecommendMoreTVC ()
@property (nonatomic, strong)NSArray <XMGNominateEditorModel *> *editorMs;
@end

@implementation XMGRecommendMoreTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.navTitle;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 88.0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGNominateEditorCell" bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:@"XMGNominateEditorCell"];
    
    [[XMGRecommendDataTool shareInstance] getRecommendEditorList:^(NSArray <XMGNominateEditorModel *> *editorMs, NSError *error) {
        
        self.editorMs = editorMs;
        
        [self.tableView reloadData];
        
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.editorMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGNominateEditorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMGNominateEditorCell"];
    
    XMGNominateEditorModel *model = self.editorMs[indexPath.row];
    cell.model = model;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //albumId
    XMGNominateEditorModel *model = self.editorMs[indexPath.row];
    NSString *albumID = [NSString stringWithFormat:@"%zd", model.albumId];
    UINavigationController *nav = self.navigationController;
    kJumpToAlbumDetail(albumID, nav)

}

@end
