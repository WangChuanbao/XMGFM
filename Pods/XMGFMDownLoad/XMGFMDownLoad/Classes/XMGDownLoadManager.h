//
//  XMGDownLoadManager.h
//  Pods
//
//  Created by 王顺子 on 16/10/24.
//
//

#import <Foundation/Foundation.h>
#import "XMGDownLoader.h"

@interface XMGDownLoadManager : NSObject
+ (instancetype)shareInstance;


- (XMGDownLoader *)loaderWithURL:(NSURL *)url;

- (void)downLoadWithURL:(NSURL *)url progressBlock:(void(^)(float progress))progressBlock successBlock:(void(^)(NSString *fileFullPath))successBlock failBlock:(void(^)())failBlock;

- (void)pauseDownLoadWithURL:(NSURL *)url;

- (void)resumeDownLoadWithURL:(NSURL *)url;

- (void)cancelDownLoadWithURL:(NSURL *)url;


@end
