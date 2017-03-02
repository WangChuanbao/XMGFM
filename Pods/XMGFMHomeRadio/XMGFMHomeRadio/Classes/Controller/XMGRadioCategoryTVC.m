//
//  XMGRadioCategoryTVC.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRadioCategoryTVC.h"
#import "XMGRadioBroadcastDataTool.h"
#import "XMGRadioModel.h"
#import "XMGRadioInfoCell.h"


@interface XMGRadioCategoryTVC ()
@property (nonatomic, strong)NSMutableArray<XMGRadioModel *> *categorieMs;
@end

@implementation XMGRadioCategoryTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.model ? self.model.name : self.navTitle;
    self.tableView.rowHeight = 88.0;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGRadioInfoCell" bundle:nil] forCellReuseIdentifier:@"XMGRadioInfoCell"];
    
    switch (self.type) {
            
        case LoadDataRadioCategories:{
            //各个电台的详细数据
            [[XMGRadioBroadcastDataTool shareInstance]getRadioCategoriesListWithId:self.model.id resultBlock:^(NSMutableArray<XMGRadioModel *> *radioMs, NSError *error) {

                self.categorieMs = radioMs;
                [self.tableView reloadData];
                
            }];
        }
        break;
            
        case LoadDataRadioLocalMore:{
            // 当地更多列表
            [[XMGRadioBroadcastDataTool shareInstance] getRadioLocalMore:^(NSMutableArray<XMGRadioModel *> *radioMs, NSError *error) {
                self.categorieMs = radioMs;
                [self.tableView reloadData];
            }];
        }
        break;
            
        case LoadDataRadioHotMore:{
            // 排行榜更多列表
            [[XMGRadioBroadcastDataTool shareInstance] getRadioHotMore:^(NSMutableArray<XMGRadioModel *> *radioMs, NSError *error) {
                self.categorieMs = radioMs;
                [self.tableView reloadData];
            }];
        }
        break;
            
        case LoadDataRadioProvince:{
            // 本地台列表
            
            [[XMGRadioBroadcastDataTool shareInstance]getRadioProvince:^(NSMutableArray<XMGRadioModel *> *radioMs, NSError *error) {
               
                self.categorieMs = radioMs;
                [self.tableView reloadData];
                
            }];
            
        }
        break;
            
        case LoadDataRadioNational:{
            //国家台列表
            [[XMGRadioBroadcastDataTool shareInstance]getRadioNational:^(NSMutableArray<XMGRadioModel *> *radioMs, NSError *error) {
                
                self.categorieMs = radioMs;
                [self.tableView reloadData];
                
            }];
        }
        break;
            
        case LoadDataProvince:
            //省市台
            
        break;
            
        case LoadDataRadioNetwork:{
            //网络台
            [[XMGRadioBroadcastDataTool shareInstance]getRadioNetwork:^(NSMutableArray<XMGRadioModel *> *radioMs, NSError *error) {
                
                self.categorieMs = radioMs;
                [self.tableView reloadData];
                
            }];
        }
        break;
            
        default:
        break;
    }
        
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.categorieMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRadioModel *model = self.categorieMs[indexPath.row];
    XMGRadioInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMGRadioInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRadioModel *model = self.categorieMs[indexPath.row];

}

@end
