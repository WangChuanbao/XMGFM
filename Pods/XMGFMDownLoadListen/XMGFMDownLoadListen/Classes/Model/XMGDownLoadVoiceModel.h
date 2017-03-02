//
//  XMGDownLoadVoiceModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMGDownLoadVoiceModel : NSObject


/** 点击执行代码块 */
@property (nonatomic, copy) void(^clickBlock)();
/** 删除执行代码块 */
@property (nonatomic, copy) void(^deleteBlock)();
/** 点击下载代码块 */
@property (nonatomic, copy) void(^downLoadBlock)(BOOL isDownLoad);




/** -----------------专辑相关信息------------------- */
/**
 专辑ID
 */
@property (nonatomic, assign) NSInteger albumId;

/**
 专辑名称
 */
@property (nonatomic, copy) NSString *albumTitle;

/**
 评论个数
 */
@property (nonatomic, assign) NSInteger comments;
/**
 专辑图片
 */
@property (nonatomic, copy) NSString *albumCoverMiddle;


/** -----------------声音相关信息------------------- */


/**
 声音ID
 */
@property (nonatomic, assign) NSInteger trackId;
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 播放URL
 */
@property (nonatomic, copy) NSString *playPathAacv164;

/**
 播放次数
 */
@property (nonatomic, assign) NSInteger playtimes;

/**
 作者昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 覆盖图片(小)
 */
@property (nonatomic, copy) NSString *coverSmall;
/**
 播放总时长
 */
@property (nonatomic, assign) NSInteger duration;

/**
 喜欢的个数
 */
@property (nonatomic, assign) NSInteger favoritesCounts;





/** -----------------下载相关信息------------------- */
/**
 下载大小
 */
@property (nonatomic, assign) NSInteger downloadSize;

/**
 下载的URL
 */
@property (nonatomic, copy) NSString *downloadUrl;



/** -----------------请求相关信息------------------- */
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger sortNum;

/** -----------------附加信息------------------- */

/**
 是否已经下载
 */
@property (nonatomic, assign) BOOL isDownLoaded;

/**
 下载进度
 */
@property (nonatomic, assign) float downLoadProgress;

/**
 是否正在下载
 */
@property (nonatomic, assign) BOOL isDownLoading;

/** 格式化后的文件总大小 */
@property (nonatomic, copy, readonly) NSString *fileFormatSize;

/** 格式化后的文件已下载大小 */
@property (nonatomic, copy, readonly) NSString *downLoadFormatSize;



@end
