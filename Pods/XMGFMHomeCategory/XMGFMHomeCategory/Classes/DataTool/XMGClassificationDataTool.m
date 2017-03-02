//
//  XMGClassificationDataTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGClassificationDataTool.h"
#import "Base.h"
#import "XMGSessionManager.h"
#import "MJExtension.h"
#import "NSArray+XMGPartition.h"
#import "Sington.h"

#import "XMGMenueModel.h"
#import "XMGAdPicModel.h"
#import "XMGClassItemModel.h"

@interface XMGClassificationDataTool()

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end

@implementation XMGClassificationDataTool

singtonImplement(XMGClassificationDataTool)

-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

- (void)getPicMenueList:(void(^)(NSArray <XMGMenueModel *>*menuePicMs, NSError *error))result
{

//   http://mobile.ximalaya.com/mobile/discovery/v2/categories?channel=ios-b1&device=iPhone&picVersion=13&scale=2&version=5.4.21
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/categories"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"version": @"5.4.21",
                            @"picVersion": @13,
                            @"scale": @2
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSArray *menuePicMs = [XMGMenueModel mj_objectArrayWithKeyValuesArray:responseObject[@"discoveryColumns"][@"list"]];
        
        result(menuePicMs, error);
        
        
    }];

}

- (void)getAdList:(void(^)(NSArray <XMGAdPicModel *>*adMs, NSError *error))result
{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/categories"];
    NSDictionary *param = @{

                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"version": @"5.4.21",
                            @"picVersion": @13,
                            @"scale": @2
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSArray *classItemMs = [XMGClassItemModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        NSMutableArray *adPicMs = [NSMutableArray array];
//        for (XMGClassItemModel *classItemM in classItemMs) {

//            if (classItemM.categoryType == 1 ) {
                XMGAdPicModel *adPicM = [[XMGAdPicModel alloc] init];
                adPicM.classItemM = [classItemMs firstObject];
                [adPicMs addObject:adPicM];
//            }

//        }


        result(adPicMs, error);

        
        
    }];

}

- (void)getClassItemList:(void(^)(NSArray *classItemMs, NSError *error))result
{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/categories"];
    NSDictionary *param = @{

                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"version": @"5.4.21",
                            @"picVersion": @13,
                            @"scale": @2
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSArray *classItemMs = [XMGClassItemModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 将一个大数组按照指定的个数切成小数组
        NSArray *resultMs = [classItemMs partitionArrayWithStart:1 Count:6];
        
        result(resultMs, error);
    }];
}


@end
