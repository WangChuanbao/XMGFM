//
//  XMGSubscribleDataTool.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSubscribleDataTool.h"
#import "XMGSessionManager.h"

#import "Sington.h"

#import "Base.h"
#import "MJExtension.h"


@interface XMGSubscribleDataTool()

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end

@implementation XMGSubscribleDataTool
singtonImplement(XMGSubscribleDataTool)

-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

/**
 *  订阅板块 - 网络请求API
 */

//http://mobile.ximalaya.com/feed/v1/recommend/classic?device=iPhone&pageId=1&pageSize=20&ts=1471058513.913570&tsuid=43342908
- (void)getRecommandList:(void(^)(NSArray <NSString *>*recommendList, NSError *error))result {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"feed/v1/recommend/classic"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"pageId": @1,
                            @"pageSize": @20,
                            @"ts": @"1471058513.913570",
                            @"tsuid":@"43342908"
                            };

//    NSString *url = @"http://ifm.ximalaya.com/recsys-stream-query/recsys/stream/feed?device=iPhone";

    [self.sessionManager setValue:@"ting_v5.4.39_c5(CFNetwork, iPhone OS 10.0.1,iPhone8,1)" forHttpField:@"User-Agent"];
    [self.sessionManager setValue:@"domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&5C60B916-A283-4DD3-98B1-8C42A8A889CF&5.4.39; impl=com.gemd.iting; NSUP=42E2BCFA%2C41B9139F%2C1477444624265; XUM=5C60B916-A283-4DD3-98B1-8C42A8A889CF; c-oper=%E6%9C%AA%E7%9F%A5; net-mode=WIFI; res=750%2C1334; idfa=5C60B916-A283-4DD3-98B1-8C42A8A889CF" forHttpField:@"Cookie"];


    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSArray *menuePicMs = [XMGRecommends mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        result(menuePicMs, error);
        
    }];
    
    
}

// http://mobile.ximalaya.com/feed/v2/feed/dynamic?device=iPhone&sign=2&size=30&ts=1471074515.126522&tsuid=43342908
#pragma - 接口无数据
- (void)getSubscribleList:(void(^)(NSArray <NSString *>*subscribleList, NSError *error))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"feed/v2/feed/dynamic"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"sign": @2,
                            @"size": @30,
                            @"ts": @"1471074515.126522",
                            @"tsuid":@"43342908"
                            };

    [self.sessionManager setValue:@"ting_v5.4.39_c5(CFNetwork, iPhone OS 10.0.1,iPhone8,1)" forHttpField:@"User-Agent"];
    [self.sessionManager setValue:@"domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&5C60B916-A283-4DD3-98B1-8C42A8A889CF&5.4.39; impl=com.gemd.iting; NSUP=42E2BCFA%2C41B9139F%2C1477444624265; XUM=5C60B916-A283-4DD3-98B1-8C42A8A889CF; c-oper=%E6%9C%AA%E7%9F%A5; net-mode=WIFI; res=750%2C1334; idfa=5C60B916-A283-4DD3-98B1-8C42A8A889CF" forHttpField:@"Cookie"];

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
       NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"subscribe" ofType:@"plist"]];
       NSArray *menuePicMs = [XMGSubscribe mj_objectArrayWithKeyValuesArray:plistData[@"data"][@"feedResult"][@"feedAlbumResults"]];
        
        result(menuePicMs, error);
        
    }];
}



/**
 *  专辑详情 - 节目
 */

// http://mobile.ximalaya.com/mobile/v1/album?albumId=265897&device=iPhone&pageSize=20&source=0&statEvent=pageview%2Falbum%40265897&statModule=%E6%8E%A8%E8%8D%90&statPage=tab%40%E8%AE%A2%E9%98%85%E5%90%AC_%E6%8E%A8%E8%8D%90&statPosition=1
- (void)getAlbumMenuWithAlbumId:(NSString *)albumId result:(void(^)(XMGAlbumMenu *albumMenu, NSError *error))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/v1/album"];
    NSLog(@"%@", albumId);
    NSDictionary *param = @{
                            @"albumId": albumId,
                            @"device": @"iPhone",
                            @"pageSize": @20,
                            @"source": @0,
                            @"statEvent":[NSString stringWithFormat:@"pageview/Falbum/%@", albumId],
                            @"statModule":@"推荐",
                            @"statPage":@"tab/订阅听_推荐",
                            @"statPosition":@1
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        
        [XMGTracks mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"XMGTrack",
                     };
        }];
        XMGAlbumMenu *albumMenu = [XMGAlbumMenu mj_objectWithKeyValues:responseObject[@"data"]];
        result(albumMenu, error);

    }];

}


/**
 *  专辑详情 - 详情
 */
// http://mobile.ximalaya.com/mobile/v1/album/detail?albumId=265897&device=iPhone&statEvent=pageview%2Falbum%40265897&statModule=%E6%8E%A8%E8%8D%90&statPage=tab%40%E8%AE%A2%E9%98%85%E5%90%AC_%E6%8E%A8%E8%8D%90&statPosition=1
- (void)getAlbumDetailWithAlbumId:(NSString *)albumId result:(void(^)(XMGAlbumDetail *albumDetail, NSError *error))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/v1/album/detail"];
    NSLog(@"%@", albumId);
    NSDictionary *param = @{
                            @"albumId": albumId,
                            @"device": @"iPhone",
                            @"pageSize": @20,
                            @"source": @0,
                            @"statEvent":[NSString stringWithFormat:@"pageview/Falbum/%@", albumId],
                            @"statModule":@"推荐",
                            @"statPage":@"tab/订阅听_推荐",
                            @"statPosition":@1
                            };
    
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        [XMGOtherRecommands mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"XMGOtherRecommand",
                     };
        }];
        XMGAlbumDetail *albumDetail = [XMGAlbumDetail mj_objectWithKeyValues:responseObject[@"data"]];
        result(albumDetail, error);
    }];

}

//statEvent=pageview%2Falbum%402947060&statModule=小编推荐&statPage=%40小编推荐&statPosition=1&tagName=空列表
- (void)getAlbumTrackListWithAlbumId:(NSString *)albumId result:(void(^)(XMGTracks *tracks, NSError *error))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/v1/album/track"];
    NSLog(@"%@", albumId);
    NSDictionary *param = @{
                            @"albumId": albumId,
                            @"isAsc": @"true",
                            @"device": @"iPhone",
                            @"pageSize": @20,
                            @"statEvent":[NSString stringWithFormat:@"pageview/Falbum/%@", albumId],
                            @"statModule":@"小编推荐",
                            @"statPage":@"albumlist/小编推荐",
                            @"statPosition":@1
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        [XMGTracks mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"XMGTrack",
                     };
        }];
        XMGTracks *tracks = [XMGTracks mj_objectWithKeyValues:responseObject[@"data"]];
        result(tracks, error);
    }];

}






/**
 *  批量下载
 */
//http://mobile.ximalaya.com/mobile/api1/download/album/3404911/1/true?device=iPhone&statEvent=pageview%2Falbum%403935229&statModule=%E6%8E%A8%E8%8D%90&statPage=tab%40%E8%AE%A2%E9%98%85%E5%90%AC_%E6%8E%A8%E8%8D%90&statPosition=4
- (void)getDownLoadListAlbumId:(NSString *)albumId position:(NSInteger)position result:(void(^)(NSArray <NSString *>*downLoadList, NSError *error))result{
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/api1/download/album/3404911/1/true"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"statEvent": [NSString stringWithFormat:@"pageview/album@%@",albumId],
                            @"statModule":@"推荐",
                            @"statPage":@"tab@订阅听_推荐",
                            @"statPosition":@(position)
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        
        NSArray *menuePicMs = [XMGDownLoadModel mj_objectArrayWithKeyValuesArray:responseObject[@"tracks"][@"list"]];
        
        result(menuePicMs, error);
        
    }];
}
@end
