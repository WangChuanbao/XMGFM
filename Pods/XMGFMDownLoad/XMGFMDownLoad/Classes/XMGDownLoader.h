//
//  XMGDownLoader.h
//  Pods
//
//  Created by 王顺子 on 16/10/23.
//
//

#import <Foundation/Foundation.h>


@interface XMGDownLoader : NSObject

- (void)downLoadWithURL: (NSURL *)url withProgressBlock: (void(^)(float progress))progress success:(void(^)(NSString *downLoadPath))sucess failed:(void(^)())fail;

@property (nonatomic, strong, readonly) NSURL *downLoadURL;


/**
 用于记录是否正在下载
 */
@property (nonatomic, assign, readonly) BOOL isDowning;

/**
 当前下载任务的进度
 */
@property (nonatomic, assign, readonly) float progress;

- (void)pauseDownLoad;
- (void)resumeDownLoad;
- (void)cancelDownLoad;

+ (long long int)cacheFileSizeWithURL:(NSURL *)url;
+ (void)removeCacheFileWithURL:(NSURL *)url;

@end
