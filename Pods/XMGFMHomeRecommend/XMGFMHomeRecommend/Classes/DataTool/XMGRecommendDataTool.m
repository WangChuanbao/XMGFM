//
//  XMGRecommendDataTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendDataTool.h"
#import "XMGSessionManager.h"
#import "Base.h"
#import "MJExtension.h"
#import "Sington.h"
#import "XMGAdPicModel.h"
#import "XMGMenueModel.h"


@interface XMGRecommendDataTool()

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end


@implementation XMGRecommendDataTool

singtonImplement(XMGRecommendDataTool)



-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}


- (void)getDiscoverMenueList:(void(^)(NSArray <NSString *>*menueList, NSError *error))result {

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/tabs"];
    NSDictionary *param = @{
                            @"device": @"iPhone"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {

        NSLog(@"%@", responseObject[@"tabs"][@"list"]);

        NSArray <NSDictionary *>*dicArray = (NSArray <NSDictionary *>*)responseObject[@"tabs"][@"list"];
        NSMutableArray *menueItems = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {

            [menueItems addObject:dic[@"title"]];

        }
        result(menueItems, error);

    }];


}


- (void)getAdList:(void(^)(NSArray <XMGAdPicModel *>*adMs, NSError *error))result {

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


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


- (void)getEditorRecommendAlbums:(void(^)(XMGGroupModel *groupM, NSError *error))result
{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        
        [XMGGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [XMGItemInCellModel class]
                     };
        }];


        NSDictionary *dic = responseObject[@"editorRecommendAlbums"];
        XMGGroupModel *groupM = [XMGGroupModel mj_objectWithKeyValues:dic];
        groupM.cellType = CellTypeList3;
        result(groupM, error);
        
        
    }];

}


- (void)getPicMenueList:(void(^)(NSArray <XMGMenueModel *>*menuePicMs, NSError *error))result {


    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSArray *menuePicMs = [XMGMenueModel mj_objectArrayWithKeyValuesArray:responseObject[@"discoveryColumns"][@"list"]];

        result(menuePicMs, error);
        
        
    }];



}


- (void)getLiveMs:(void(^)(XMGGroupModel *groupM, NSError *error))result {


    NSString *url = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-activity-web/v3/activity/recommend"];


    [self.sessionManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {

        NSLog(@"%@", responseObject);

        NSArray *liveMs = [XMGLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        NSLog(@"%@", liveMs);
        XMGGroupModel *groupM = [[XMGGroupModel alloc] init];
        groupM.cellType = CellTypeList1;
        groupM.title = @"现场直播";
        groupM.hasMore = true;

        groupM.liveMs = liveMs;


        result(groupM, error);
        
        
    }];



}

- (void)getSpecialColumnMs:(void(^)(XMGGroupModel *groupM, NSError *error))result
{

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {



        [XMGGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [XMGSpecialColumnModel class]
                     };
        }];


        NSDictionary *dic = responseObject[@"specialColumn"];
        XMGGroupModel *groupM = [XMGGroupModel mj_objectWithKeyValues:dic];
        groupM.cellType = CellTypeList2;
        
        result(groupM, error);
        
        
    }];

    


}

- (void)getTuiGuangMs:(void(^)(XMGGroupModel *groupM, NSError *error))result
{


    NSString *url = [NSString stringWithFormat:@"%@%@", kAdUrl, @"/ting/feed"];

    NSDictionary *param = @{
                            @"appid": @"0",
                            @"device": @"iPhone",
                            @"name": @"find_native",
                            @"network": @"WIFI",
                            @"operator": @3,
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {

        NSLog(@"%@", responseObject);
        [XMGTuiguangModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return  @{
                      @"Description": @"description",
                      @"Auto" : @"auto"
                      };
        }];

        NSArray *tuiguangMs = [XMGTuiguangModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        XMGGroupModel *groupM = [[XMGGroupModel alloc] init];
        groupM.cellType = CellTypeList1;
        groupM.title = @"推广";
        groupM.hasMore = true;

        groupM.tuiguangMs = tuiguangMs;


        result(groupM, error);
        
        
    }];
    

}

- (void)getCityAlbums:(void(^)(XMGGroupModel *groupM, NSError *error))result
{


    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"code": @"43_440000_4401",
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {




        [XMGGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [XMGItemInCellModel class]
                     };
        }];

        XMGGroupModel *groupM = [XMGGroupModel mj_objectWithKeyValues:responseObject[@"cityColumn"]];

        groupM.cellType = CellTypeList3;
        result(groupM, error);
        
        
    }];


}

- (void)getHotRecommendsAlbums:(void(^)(NSArray <XMGGroupModel *> *groupMs, NSError *error))result
{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/recommend/hotAndGuess"];
    NSDictionary *param = @{
                            @"code": @"43_440000_4401",
                            @"device": @"iPhone",
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {




        [XMGGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [XMGItemInCellModel class]
                     };
        }];


       NSArray *groupMs = [XMGGroupModel mj_objectArrayWithKeyValuesArray:responseObject[@"hotRecommends"][@"list"]];

        [groupMs enumerateObjectsUsingBlock:^(XMGGroupModel *groupM, NSUInteger idx, BOOL * _Nonnull stop) {
            groupM.sortID = 10 + idx;
            groupM.cellType = CellTypeList3;
        }];


        result(groupMs, error);
        
        
    }];
}

- (void)getRecommendEditorList:(void (^)(NSArray<XMGNominateEditorModel *>*editorMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/recommend/editor"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageId": @"1",
                            @"pageSize": @"20"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSArray *editorMs = [XMGNominateEditorModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        result(editorMs, error);
        
    }];
}


@end
