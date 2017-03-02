//
//  XMGDownLoadDataTool.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadDataTool.h"

#import "XMGSessionManager.h"
#import "XMGDownLoadService.h"
#import "Sington.h"
#import "XMGSessionManager.h"
#import "Base.h"
#import "MJExtension.h"

#import "FMDB.h"


@interface XMGDownLoadDataTool()

@property (nonatomic, strong) XMGSessionManager *sessionManager;


@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue;

@end


@implementation XMGDownLoadDataTool

singtonImplement(XMGDownLoadDataTool)

-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}

- (FMDatabaseQueue *)dataBaseQueue {
    if (!_dataBaseQueue) {
        NSString *kCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"XMGFM.sqlite"];
        _dataBaseQueue = [[FMDatabaseQueue alloc] initWithPath:kCachePath];
        [self createTable];
    }
    return _dataBaseQueue;
}


- (void)createTable {


    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"create table if not exists t_Downed_Voice (id integer primary key autoincrement,albumId text, uid text, downloadUrl text unique, downloadSize text, favoritesCounts text, duration text, coverSmall text, nickname text, playtimes text, playPathAacv164 text, title text, trackId text unique, albumTitle text, comments text, albumCoverMiddle text, isDownLoaded text default '0')";

        [db executeUpdate:sql];

    }];


}

- (void)saveDownLoadVoiceModel:(XMGDownLoadVoiceModel *)downLoadVoiceM {

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {

        BOOL result = [db executeUpdate:@"insert into t_Downed_Voice (albumId , uid , downloadUrl , downloadSize , favoritesCounts , duration , coverSmall , nickname , playtimes , playPathAacv164 , title , trackId , albumTitle , comments , albumCoverMiddle ) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" withArgumentsInArray:@[@(downLoadVoiceM.albumId) , @(downLoadVoiceM.uid) , downLoadVoiceM.downloadUrl , @(downLoadVoiceM.downloadSize) , @(downLoadVoiceM.favoritesCounts) , @(downLoadVoiceM.duration) , downLoadVoiceM.coverSmall , downLoadVoiceM.nickname , @(downLoadVoiceM.playtimes) , downLoadVoiceM.playPathAacv164 , downLoadVoiceM.title , @(downLoadVoiceM.trackId) , downLoadVoiceM.albumTitle , @(downLoadVoiceM.comments) , downLoadVoiceM.albumCoverMiddle]];


        if (result)
        {
            NSLog(@"保存声音记录成功");
        }else {
            NSLog(@"保存声音记录失败");
        }
        
    }];
    
}

- (void)getCurrentDownLoadingVoiceMs:(void(^)(NSArray <XMGDownLoadVoiceModel *>*downLoadingVoiceMs))result {

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {


        NSString *sql = @"select * from t_Downed_Voice where isDownLoaded = '0'";
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableArray *voiceMs = [NSMutableArray array];

        while ([rs next]) {
            XMGDownLoadVoiceModel *voiceM = [[XMGDownLoadVoiceModel alloc] init];
            [voiceMs addObject:voiceM];

            NSArray *columnNames = @[@"uid" , @"downloadUrl" , @"downloadSize" , @"favoritesCounts" , @"duration" , @"coverSmall" , @"nickname" , @"playtimes" , @"playPathAacv164" , @"title" , @"trackId" , @"albumTitle" , @"comments" , @"albumCoverMiddle", @"isDownLoaded"];

            for (NSString *columnName in columnNames) {
                [voiceM setValue:[rs stringForColumn:columnName] forKey:columnName];
            }

            
        }
        result(voiceMs);
    }];
    
    
    
    
}




- (void)getCurrentDownLoadedVoiceMs:(void(^)(NSArray <XMGDownLoadVoiceModel *>*downLoadingVoiceMs))result
{

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {


        NSString *sql = @"select * from t_Downed_Voice where isDownLoaded = '1'";
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableArray *voiceMs = [NSMutableArray array];

        while ([rs next]) {
            XMGDownLoadVoiceModel *voiceM = [[XMGDownLoadVoiceModel alloc] init];
            [voiceMs addObject:voiceM];

            NSArray *columnNames = @[@"uid" , @"downloadUrl" , @"downloadSize" , @"favoritesCounts" , @"duration" , @"coverSmall" , @"nickname" , @"playtimes" , @"playPathAacv164" , @"title" , @"trackId" , @"albumTitle" , @"comments" , @"albumCoverMiddle", @"isDownLoaded"];

            for (NSString *columnName in columnNames) {
                [voiceM setValue:[rs stringForColumn:columnName] forKey:columnName];
            }
        }

        result(voiceMs);

    }];

}

- (void)setVoiceMDownLoaded: (BOOL)isDownLoaded withURL:(NSString *)url {

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {

        NSString *sql = [NSString stringWithFormat:@"update t_Downed_Voice set isDownLoaded = '%zd' where downLoadUrl = '%@'", isDownLoaded, url];
        if ([db executeUpdate:sql]) {
            NSLog(@"执行成功");
        }else {
            NSLog(@"执行失败");
        }

    }];


}

- (void)deleteVoiceDownLoadedModelWithURL:(NSString *)url {

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {

        NSString *sql = [NSString stringWithFormat:@"delete from t_Downed_Voice where downLoadUrl = '%@'", url];
        if ([db executeUpdate:sql]) {
            NSLog(@"执行成功");
        }else {
            NSLog(@"执行失败");
        }

    }];


}

- (NSURL *)getCachePathWithWithURL:(NSString *)url orTrackID: (NSInteger)trackID {

    if (url.length > 0) {
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:url.lastPathComponent];
        return [NSURL URLWithString:path];
    }


    __block NSString *downLoadPath = nil;
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {


        NSString *sql = [NSString stringWithFormat:@"select downloadUrl from t_Downed_Voice where downloadUrl = '%@' or trackId = '%zd'", url, trackID];
        FMResultSet *rs = [db executeQuery:sql];


        while ([rs next]) {
            downLoadPath = [rs stringForColumn:@"downloadUrl"];
        }
        
        
    }];

    if (downLoadPath.length > 0) {
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:downLoadPath.lastPathComponent];
        return [NSURL URLWithString:path];
    }

    return nil;
}

- (BOOL)isDownLoadedWithURL:(NSString *)url orTrackID: (NSInteger)trackID {

    __block BOOL isDownLoaded = NO;
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {


        NSString *sql = [NSString stringWithFormat:@"select isDownLoaded from t_Downed_Voice where downloadUrl = '%@' or trackId = '%zd'", url, trackID];
        FMResultSet *rs = [db executeQuery:sql];


        while ([rs next]) {
            isDownLoaded = [rs boolForColumn:@"isDownLoaded"];
            NSLog(@"-----%zd", isDownLoaded);
        }

        
    }];

    return isDownLoaded;

}





- (void)getCurrentDownLoadedAlbumMs:(void(^)(NSArray <XMGDownLoadAlbumModel *>*downLoadingAlbumMs))result {

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {


        NSString *sql = @"select albumId, nickname, count(*) as trackCount, albumCoverMiddle, albumTitle  from t_Downed_Voice where isDownLoaded = '1'  group by albumId";
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableArray *albumMs = [NSMutableArray array];

        while ([rs next]) {
            XMGDownLoadAlbumModel *albumM = [[XMGDownLoadAlbumModel alloc] init];
            [albumMs addObject:albumM];

            NSArray *columnNames = @[@"albumId" , @"nickname" , @"trackCount" , @"albumCoverMiddle" , @"albumTitle"];

            for (NSString *columnName in columnNames) {
                [albumM setValue:[rs stringForColumn:columnName] forKey:columnName];
            }
        }


        for (XMGDownLoadAlbumModel *albumM in albumMs) {

            NSString *queryAlbumMsSql = [NSString stringWithFormat:@"select * from t_Downed_Voice where isDownLoaded = '1' and albumId = '%zd'", albumM.albumId];
            FMResultSet *rs2 = [db executeQuery:queryAlbumMsSql];
            NSMutableArray *voiceMs = [NSMutableArray array];

            while ([rs2 next]) {
                XMGDownLoadVoiceModel *voiceM = [[XMGDownLoadVoiceModel alloc] init];
                [voiceMs addObject:voiceM];

                NSArray *columnNames = @[@"uid" , @"downloadUrl" , @"downloadSize" , @"favoritesCounts" , @"duration" , @"coverSmall" , @"nickname" , @"playtimes" , @"playPathAacv164" , @"title" , @"trackId" , @"albumTitle" , @"comments" , @"albumCoverMiddle", @"isDownLoaded"];

                for (NSString *columnName in columnNames) {
                    [voiceM setValue:[rs2 stringForColumn:columnName] forKey:columnName];
                }
                [albumM.voiceMs addObject:voiceM];
            }

        }



        result(albumMs);
        
    }];



}







- (void)deleteDownLoadVocieModelsWithAlbumID: (NSInteger)albumID {

    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {

        NSString *sql = [NSString stringWithFormat:@"delete from t_Downed_Voice where albumId = '%zd'", albumID];
        if ([db executeUpdate:sql]) {
            NSLog(@"执行成功");
        }else {
            NSLog(@"执行失败");
        }

    }];

}



- (void)getVoiceMsWithKey:(NSString *)key pageNum:(NSInteger)page result:(void(^)(NSArray <XMGDownLoadVoiceModel *>*voiceMs))result
{

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": key,
                            @"pageId": @"1",
                            @"pageSize": @"30"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSMutableArray <XMGDownLoadVoiceModel *>*voiceyMs = [XMGDownLoadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        result(voiceyMs);

    }];

}


- (void)setDownLoadMessageToVoiceM: (XMGDownLoadVoiceModel *)voiceM complete:(void(^)())completeBlock {


    NSString *url = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/download/%zd/track/%zd", voiceM.uid, voiceM.trackId];


    [self.sessionManager request:RequestTypePost urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {

        [voiceM mj_setKeyValues:responseObject];
        
        completeBlock();
        
    }];
    
    
}

- (void)getTodayFireShareAndCategoryData:(void(^)(XMGShareModel *shareM, NSArray <XMGCategoryModel *>*categoryMs))result
{
    //     http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/track?device=iPhone&key=ranking:track:scoreByTime:1:0&pageId=1&pageSize=1

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": @"ranking:track:scoreByTime:1:0",
                            @"pageId": @"1",
                            @"pageSize": @"0"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {

        XMGShareModel *shareM = [XMGShareModel mj_objectWithKeyValues:responseObject[@"shareContent"]];



        XMGCategoryModel *categoryM = [[XMGCategoryModel alloc] init];
        categoryM.key = @"ranking:track:scoreByTime:1:0";
        categoryM.name = @"总榜";

        NSMutableArray <XMGCategoryModel *>*categoryMs = [XMGCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"categories"]];
        [categoryMs insertObject:categoryM atIndex:0];

        
        result(shareM, categoryMs);
        
    }];
    
    
}





@end
