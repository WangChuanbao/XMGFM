//
//  XMGDownLoadDataTool.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGShareModel.h"
#import "XMGCategoryModel.h"
#import "XMGDownLoadVoiceModel.h"
#import "XMGDownLoadAlbumModel.h"



@interface XMGDownLoadDataTool : NSObject
+ (instancetype)shareInstance;


/**
 当前正在播放的ID
 */
@property (nonatomic, assign) NSInteger currentTrackID;

/**
 *  获取今日最火, 分享内容, 和分类列表
 *
 *  @param result 分享内容, 分类列表
 */
- (void)getTodayFireShareAndCategoryData:(void(^)(XMGShareModel *shareM, NSArray <XMGCategoryModel *>*categoryMs))result;

/**
 *  获取下载声音列表
 *
 *  @param key    类别key
 *  @param page   页数
 *  @param result 下载的声音模型数组
 */
- (void)getVoiceMsWithKey:(NSString *)key pageNum:(NSInteger)page result:(void(^)(NSArray <XMGDownLoadVoiceModel *>*voiceMs))result;

/**
 *  为音乐模型, 附加下载信息, 以便下载(会修改音频模型)
 *
 *  @param voiceM 音乐模型
 */
- (void)setDownLoadMessageToVoiceM: (XMGDownLoadVoiceModel *)voiceM complete:(void(^)())completeBlock;


/**
 *  获取当前正在下载的声音模型数组
 *
 *  @param result 声音模型数组
 */
- (void)getCurrentDownLoadingVoiceMs:(void(^)(NSArray <XMGDownLoadVoiceModel *>*downLoadingVoiceMs))result;


/**
 *  保存声音模型到本地
 *
 *  @param downLoadVoiceM 声音模型
 */
- (void)saveDownLoadVoiceModel:(XMGDownLoadVoiceModel *)downLoadVoiceM;


/**
 *  获取当前下载完毕的声音模型数组
 *
 *  @param result 声音模型数组
 */
- (void)getCurrentDownLoadedVoiceMs:(void(^)(NSArray <XMGDownLoadVoiceModel *>*downLoadingVoiceMs))result;


/**
 标识下载完成标志

 @param isDownLoaded 是否下载完成
 @param url          url地址
 */
- (void)setVoiceMDownLoaded: (BOOL)isDownLoaded withURL:(NSString *)url;


/**
 删除缓存信息

 @param url 根据url
 */
- (void)deleteVoiceDownLoadedModelWithURL:(NSString *)url;


/**
 根据URL地址判定是否已经下载

 @param url url

 @return 是否已经下载
 */
- (BOOL)isDownLoadedWithURL:(NSString *)url orTrackID: (NSInteger)trackID;


/**
 获取当前音乐的缓存播放路径

 @param url     远程地址
 @param trackID 音频ID

 @return 播放路径, 缓存
 */
- (NSURL *)getCachePathWithWithURL:(NSString *)url orTrackID: (NSInteger)trackID;

/**
 *  获取当前下载完毕的声音模型数组分组信息(专辑组)
 *
 *  @param result 
 */
- (void)getCurrentDownLoadedAlbumMs:(void(^)(NSArray <XMGDownLoadAlbumModel *>*downLoadingAlbumMs))result;



/**
 *  删除指定专辑下的所有声音模型
 *
 *  @param albumID 专辑ID
 */
- (void)deleteDownLoadVocieModelsWithAlbumID: (NSInteger)albumID;



@end
