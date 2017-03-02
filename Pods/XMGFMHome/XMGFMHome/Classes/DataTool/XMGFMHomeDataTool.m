//
//  XMGFMHomeDataTool.m
//  XMGFM
//
//  Created by 王顺子 on 16/10/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFMHomeDataTool.h"
#import "XMGSessionManager.h"
#import "MJExtension.h"
#import "Sington.h"
#import "Base.h"

@interface XMGFMHomeDataTool()

@property (nonatomic, strong) XMGSessionManager *manager;

@end

@implementation XMGFMHomeDataTool
singtonImplement(XMGFMHomeDataTool);


- (XMGSessionManager *)manager {
    if (!_manager) {
        _manager = [[XMGSessionManager alloc] init];
    }
    return _manager;
}


- (void)getHomeTabs: (void(^)(NSArray <XMGHomeTabModel *>*tabMs))resultBlock {

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/tabs"];
    NSDictionary *param = @{
                            @"device": @"iPhone"
                            };

    [self.manager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {



        NSArray <NSDictionary *>*dicArray = (NSArray <NSDictionary *>*)responseObject[@"tabs"][@"list"];
        NSMutableArray *menueItems = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {

            [menueItems addObject:dic[@"title"]];

        }
        resultBlock(menueItems);
        
    }];
    

}

@end
