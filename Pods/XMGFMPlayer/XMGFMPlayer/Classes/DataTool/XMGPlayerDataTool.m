//
//  XMGPlayerDataTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayerDataTool.h"
#import "XMGSessionManager.h"
#import "Sington.h"
#import "Base.h"
#import "MJExtension.h"

static NSString * const kCookie = @"kCookie";

@interface XMGPlayerDataTool()

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end


@implementation XMGPlayerDataTool
singtonImplement(XMGPlayerDataTool)


-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}


- (void)getPlayerDataWithAlbumId:(NSInteger)albumId trackUid: (NSInteger)trackUid  result: (void(^)(XMGTrackInfoModel *trackM, XMGAlbumInfoModel *albumInfoM, XMGPlayerGroupModel *associationAlbumGroupM, XMGUserInfoModel *userInfoM, XMGPlayerCommentGroupModel *commentGroupM, XMGTrackRewardInfoModel *rewardInfoM))resultBlock
{
//    http://mobile.ximalaya.com/
//    http://mobile.ximalaya.com/v1/track/ca/playpage/19359302?albumId=323825&device=iPhone&trackUid=32323635

    // http://mobile.ximalaya.com/v1/track/ca/playpage/19668798?albumId=294567&device=iPhone&trackUid=16960840

    NSString *url = [NSString stringWithFormat:@"%@v1/track/ca/playpage/%zd", kBaseUrl, trackUid];



    NSDictionary *param = @{
                            @"albumId": @(albumId),
                            @"device": @"iPhone",
                            @"trackUid": @(trackUid)
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        XMGAlbumInfoModel *albumInfoM = [XMGAlbumInfoModel mj_objectWithKeyValues:responseObject[@"albumInfo"]];

        XMGTrackInfoModel *trackM = [XMGTrackInfoModel mj_objectWithKeyValues:responseObject[@"trackInfo"]];
        trackM.albumId = albumInfoM.albumId;

        NSArray <XMGAlbumInfoModel *>*associationAlbumMs = [XMGAlbumInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"associationAlbumsInfo"]];

        XMGPlayerGroupModel *groupM = [[XMGPlayerGroupModel alloc] init];
        groupM.groupTitle = @"相关推荐";
        groupM.groupDetailTitle = @"查看更多推荐 >";
        groupM.albumInfoMs = [associationAlbumMs mutableCopy];
        

        XMGUserInfoModel *userInfoM = [XMGUserInfoModel mj_objectWithKeyValues:responseObject[@"userInfo"]];

        NSArray <XMGCommentInfoModel *>*commentInfoMs = [XMGCommentInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"commentInfo"][@"list"]];

        XMGPlayerCommentGroupModel *commentGroupM = [[XMGPlayerCommentGroupModel alloc] init];
        commentGroupM.groupTitle = @"听众点评";
        commentGroupM.groupDetailTitle = @"查看更多评论";
        commentGroupM.commentInfoMs = [commentInfoMs mutableCopy];

        [XMGTrackRewardInfoModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"rewords": [XMGRewardModel class]
                     };
        }];

        XMGTrackRewardInfoModel *rewardInfoM = [XMGTrackRewardInfoModel mj_objectWithKeyValues:responseObject[@"trackRewardInfo"]];
        rewardInfoM.trackID = trackM.trackId;
        // 额外属性赋值
        rewardInfoM.voiceIntro = trackM.shortRichIntro;

        if (resultBlock != nil) {
            resultBlock(trackM, albumInfoM, groupM, userInfoM, commentGroupM, rewardInfoM);
        }
        
    }];



}


- (void)getRecommendMsWithAlbumId:(NSInteger)albumId result: (void(^)(NSArray <XMGAlbumInfoModel *>*albumInfoMs))result
{


    NSString *url = [NSString stringWithFormat:@"%@%@", kAlbumUrl, @"rec-association/recommend/album/by_album"];


    NSDictionary *param = @{
                            @"albumId": @(albumId),
                            @"device": @"iPhone",
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {



        NSArray <XMGAlbumInfoModel *>*albumMs = [XMGAlbumInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"albums"]];

        if (result != nil) {
            result(albumMs);
        }
        
    }];

}

- (void)getCommentMsWithTrackId:(NSInteger)trackId retuslt: (void(^)(NSArray <XMGCommentInfoModel *>*commentMs))result {


//       http://mobile.ximalaya.com/mobile/track/comment?device=iPhone&pageId=1&pageSize=30&trackId=19380085

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/track/comment"];


    NSDictionary *param = @{
                            @"trackId": @(trackId),
                            @"device": @"iPhone",
                            @"pageId": @(1),
                            @"pageSize": @(66)
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {



        NSArray <XMGCommentInfoModel *>*commentMs = [XMGCommentInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        if (result != nil) {
            result(commentMs);
        }
        
    }];

}

- (void)getTrackDetailWithTrackID: (NSInteger)trackID result:(void(^)(XMGAlubmnDetailModel *alubmnDetailM))resultBlock
{

         // http://mobile.ximalaya.com/v1/track/extendInfo?device=iPhone&trackId=19668798

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"v1/track/extendInfo"];


    NSDictionary *param = @{
                            @"trackId": @(trackID),
                            @"device": @"iPhone",
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        XMGAlubmnDetailModel *alubmnDetailM = [XMGAlubmnDetailModel mj_objectWithKeyValues:responseObject];

        if (resultBlock != nil) {
            resultBlock(alubmnDetailM);
        }
        
    }];

}


- (void)getRewardList:(void(^)())resultBlock {

//
//    NSData * cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject: cookiesData forKey:kCookie];
//    [defaults synchronize];


//    http://hybrid.ximalaya.com/ting-shang-mobile-web/1/user/rewardSelect?app=iting&device=iPhone&impl=com.gemd.iting&payeeId=10260025&payerId=12593123&trackId=19994417&version=5.4.21

    // domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&5C60B916-A283-4DD3-98B1-8C42A8A889CF&5.4.21; impl=com.gemd.iting; NSUP=42E2BD7E%2C41B914ED%2C1471577797525; XUM=5C60B916-A283-4DD3-98B1-8C42A8A889CF; c-oper=%E6%9C%AA%E7%9F%A5; net-mode=WIFI; res=750%2C1334; 1&_token=12593123&7bd382a40170a046410a1a102e06d38340af; idfa=5C60B916-A283-4DD3-98B1-8C42A8A889CF


//    NSArray * cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:kCookie]];
    NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *customCookie = [NSHTTPCookie cookieWithProperties:@{
                                                                      @"domain": @".ximalaya.com",
                                                                      @"path":@"/",
                                                                      @"channel":@"ios-b1",
                                                                      @"1&_device":@"iPhone&5C60B916-A283-4DD3-98B1-8C42A8A889CF&5.4.21",
                                                                      @"impl":@"com.gemd.iting",
                                                                      @"NSUP":@"42E2BD7E%2C41B914ED%2C1471577797525",
                                                                      @"XUM":@"5C60B916-A283-4DD3-98B1-8C42A8A889CF",
                                                                      @"c-oper":@"%E6%9C%AA%E7%9F%A5",
                                                                      @"net-mode":@"WIFI",
                                                                      @"res":@"750%2C1334",
                                                                      @"1&_token":@"12593123&7bd382a40170a046410a1a102e06d38340af",
                                                                      @"idfa":@"5C60B916-A283-4DD3-98B1-8C42A8A889CF"
                                                                      }];


        [cookieStorage setCookie: customCookie];



//      http://hybrid.ximalaya.com/ting-shang-mobile-web/1/user/rewardSelect?app=iting&device=iPhone&impl=com.gemd.iting&payeeId=10260025&payerId=12593123&trackId=19994417&version=5.4.21

    NSString *url = [NSString stringWithFormat:@"%@%@", kHybridUrl, @"ting-shang-mobile-web/1/user/rewardSelect"];


    NSDictionary *param = @{
                            @"app": @"iting",
                            @"device": @"iPhone",
                            @"impl": @"com.gemd.iting",
                            @"payeeId":@"10260025",
                            @"payerId": @"12593123",
                            @"trackId": @"19994417",
                            @"version": @"5.4.21"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {

//        XMGLog(@"%@", responseObject)

    }];



}

- (void)getTrackMsWithAlbumId: (NSInteger)albumId trackId:(NSInteger)trackId result:(void(^)(NSMutableArray <XMGTrackInfoModel *>*))resultBlock {


    //    http://mobile.ximalaya.com/mobile/playlist/album/new?albumId=2716928&asc=true&device=iPhone&trackId=19039103

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/playlist/album/new"];


    NSDictionary *param = @{
                            @"albumId": @(albumId),
                            @"asc": @"true",
                            @"device": @"iPhone",
                            @"trackId": @(trackId)
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSMutableArray <XMGTrackInfoModel *> *albumMs = [XMGTrackInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        if (resultBlock != nil) {
            resultBlock(albumMs);
        }
        
    }];




}


- (void)getDanMuMsWithTrackId:(NSInteger)trackId result:(void(^)(NSMutableArray <XMGDanmuModel *>*danmuMs, BOOL isNewData))resultBlock {

    static NSInteger sec = 0;
    static NSInteger lastTrackId = 0;
    BOOL isNewData = NO;
    if (lastTrackId != trackId) {
        sec = 0;
        isNewData = YES;
        lastTrackId = trackId;
    }


//     http://mobile.ximalaya.com/comment-mobile/bullet?device=iPhone&second=80&trackId=20128255

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"comment-mobile/bullet"];


    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"second": @(sec),
                            @"trackId": @(trackId)
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSMutableArray <XMGDanmuModel *> *danmuMs = [XMGDanmuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"comments"]];

        sec = [responseObject[@"data"][@"second"] integerValue];

        if (resultBlock != nil) {

            [danmuMs sortUsingComparator:^NSComparisonResult(XMGDanmuModel *obj1, XMGDanmuModel *obj2) {
                if (obj1.startTime < obj2.startTime) {
                    return NSOrderedAscending;
                }
                return NSOrderedDescending;
                
            }];


            resultBlock(danmuMs, isNewData);
        }
        
    }];




}



@end
