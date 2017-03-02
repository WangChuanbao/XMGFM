//
//  XMGAnchorDataTool.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGBillBoardDataTool.h"
#import "XMGFocusImageModel.h"
#import "XMGFocusImages.h"
#import "XMGRankingListModel.h"
#import "XMGRankingFirstModel.h"
#import "XMGRankingInfoModel.h"
#import "XMGSessionManager.h"
#import "Base.h"
#import "MJExtension.h"
#import "Sington.h"
#import "XMGAdPicModel.h"

@interface XMGBillBoardDataTool ()
@property (nonatomic, strong) XMGSessionManager *sessionManager;
@end

@implementation XMGBillBoardDataTool
singtonImplement(XMGBillBoardDataTool)

-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

- (void)getFocusList:(void (^)(NSArray <XMGAdPicModel *>*adMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/group"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"channel": @"ios-b1",
                            @"includeActivity": @"true",
                            @"includeSpecial": @"true",
                            @"scale": @"2",
                            @"version": @"5.4.21"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        NSArray *focusImageMs = [XMGFocusImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"focusImages"][@"list"]];
        
        NSMutableArray *adPicMs = [NSMutableArray array];
        for (XMGFocusImageModel *focusImageM in focusImageMs) {
            XMGAdPicModel *adPicM = [[XMGAdPicModel alloc] init];
            adPicM.focusImageM = focusImageM;
            [adPicMs addObject:adPicM];
        }
        
        
        result(adPicMs, error);
        
        
    }];
}

- (void)getRankingList:(void(^)(NSArray <XMGRankingListModel *>*listMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"/mobile/discovery/v2/rankingList/group"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"channel": @"ios-b1",
                            @"includeActivity": @"true",
                            @"includeSpecial": @"true",
                            @"scale": @"2",
                            @"version": @"5.4.21",
                            @"channel": @"ios-b1"
                            };
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        

        
        
        [XMGRankingListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"XMGRankingInfoModel",
                     };
        }];

        
        NSArray *rankingListMs = [XMGRankingListModel mj_objectArrayWithKeyValuesArray:responseObject[@"datas"]];
        
        
        for (XMGRankingListModel *rankingListM in rankingListMs) {
            NSArray *dictArr = rankingListM.list;
            
            [dictArr enumerateObjectsUsingBlock:^(XMGRankingInfoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                NSArray *tempArr = [XMGRankingFirstModel mj_objectArrayWithKeyValuesArray: obj.firstKResults];
                
                obj.firstKResults = tempArr;
            }];
        }
        
        
        result(rankingListMs, error);
        
        
    }];
}
@end
