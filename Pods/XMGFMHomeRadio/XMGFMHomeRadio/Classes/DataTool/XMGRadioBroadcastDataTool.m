//
//  XMGRadioBroadcastDataTool.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 2016/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRadioBroadcastDataTool.h"
#import "XMGSessionManager.h"
#import "Base.h"
#import "MJExtension.h"
#import "Sington.h"

@interface XMGRadioBroadcastDataTool ()

@property (nonatomic, strong) XMGSessionManager *sessionManager;
@end

@implementation XMGRadioBroadcastDataTool

singtonImplement(XMGRadioBroadcastDataTool)


-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

- (void)getCategoriesList:(void (^)(NSMutableArray<XMGCategorieModel *> *categorieMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v4/homepage"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone"
                            };
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSMutableArray *categorieMs = [XMGCategorieModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"categories"]];
        
        XMGCategorieModel *lastModel = [XMGCategorieModel new];
        lastModel.isLast = YES;
        
        [categorieMs addObject:lastModel];
        
        result(categorieMs, error);
    }];
}

- (void)getLocalRadioList:(void(^)(XMGRadioModels *radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v4/homepage"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            };
    
    
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        XMGRadioModels *radioMs = [XMGRadioModels new];
        
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSArray *models = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"localRadios"]];
        radioMs.models = models;
        radioMs.location = responseObject[@"data"][@"location"];
        radioMs.sortID = 1;
        
        result(radioMs, error);
    }];
}


- (void) getTopRadioList:(void(^)(XMGRadioModels *radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v4/homepage"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        XMGRadioModels *radioMs = [XMGRadioModels new];
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        NSArray *models = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topRadios"]];
        radioMs.models = models;
        radioMs.location = @"排行榜";
        radioMs.sortID = 2;
        result(radioMs, error);
    }];
}

- (void) getRadioCategoriesListWithId:(NSInteger) Id resultBlock: (void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v2/radio/category"];
    
    NSDictionary *param = @{
                            @"categoryId": @(Id),
                            @"device": @"iPhone",
                            @"pageNum": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
       
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSMutableArray *radioMs = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        result(radioMs, error);
    }];
}

- (void) getRadioLocalMore:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v1/radio/local"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageNum": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSMutableArray *radioMs = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        result(radioMs, error);
    }];
}

- (void) getRadioHotMore:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v3/radio/hot"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageNum": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSMutableArray *radioMs = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        result(radioMs, error);
    }];
}

- (void) getRadioProvince:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v2/radio/province"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageNum": @"1",
                            @"pageSize": @"30",
                            @"provinceCode": @"440000"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSMutableArray *radioMs = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        result(radioMs, error);
        
    }];
}

- (void) getRadioNational:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v2/radio/national"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageNum": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSMutableArray *radioMs = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        result(radioMs, error);
        
    }];
}

- (void) getRadioNetwork:(void (^)(NSMutableArray <XMGRadioModel *>*radioMs, NSError *error))result
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kLiveUrl, @"live-web/v2/radio/network"];
    
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageNum": @"1",
                            @"pageSize": @"30"
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:urlString parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        [XMGRadioModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"playUrl" : @"playUrl"
                     };
        }];
        
        NSMutableArray *radioMs = [XMGRadioModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        
        result(radioMs, error);
        
    }];
}
@end
