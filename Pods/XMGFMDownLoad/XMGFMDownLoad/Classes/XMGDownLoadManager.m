//
//  XMGDownLoadManager.m
//  Pods
//
//  Created by 王顺子 on 16/10/24.
//
//

#import "XMGDownLoadManager.h"


@interface XMGDownLoadManager()

@property (nonatomic, strong) NSMutableDictionary *downLoadDic;

@end

@implementation XMGDownLoadManager

static XMGDownLoadManager *_shareInstance;

+ (instancetype)shareInstance { 
    
    if(_shareInstance == nil) {
        _shareInstance = [[XMGDownLoadManager alloc] init]; 
    } 
    return _shareInstance; 
} 

+(instancetype)allocWithZone:(struct _NSZone *)zone { 
    
    static dispatch_once_t onceToken; 
    dispatch_once(&onceToken, ^{ 
        _shareInstance = [super allocWithZone:zone]; 
    }); 
    
    return _shareInstance; 
    
}


- (NSMutableDictionary *)downLoadDic {
    if (!_downLoadDic) {
        _downLoadDic = [NSMutableDictionary dictionary];
    }
    return _downLoadDic;
}

- (XMGDownLoader *)loaderWithURL:(NSURL *)url {
    return self.downLoadDic[url.lastPathComponent];
}


- (void)downLoadWithURL:(NSURL *)url progressBlock:(void(^)(float progress))progressBlock successBlock:(void(^)(NSString *fileFullPath))successBlock failBlock:(void(^)())failBlock {

    XMGDownLoader *downLoader = [self loaderWithURL:url];
    __weak XMGDownLoadManager *weakManager = self;
    if (!downLoader) {
        downLoader = [[XMGDownLoader alloc] init];
        [self.downLoadDic setValue:downLoader forKey:url.lastPathComponent];
        [downLoader downLoadWithURL:url withProgressBlock:^(float progress) {
            progressBlock(progress);
        } success:^(NSString *downLoadPath) {
            successBlock(downLoadPath);
            // 移除对象
            [weakManager.downLoadDic removeObjectForKey:downLoadPath.lastPathComponent];
        } failed:^{
            failBlock();
        }];

    }else {
        [downLoader resumeDownLoad];
    }


}

- (void)pauseDownLoadWithURL:(NSURL *)url {
    XMGDownLoader *downLoader = [self loaderWithURL:url];
    [downLoader pauseDownLoad];
}

- (void)resumeDownLoadWithURL:(NSURL *)url {
    XMGDownLoader *downLoader = [self loaderWithURL:url];
    [downLoader resumeDownLoad];
}

- (void)cancelDownLoadWithURL:(NSURL *)url {
    XMGDownLoader *downLoader = self.downLoadDic[url.lastPathComponent];
    if (downLoader) {
        [downLoader cancelDownLoad];
    }else {
        [XMGDownLoader removeCacheFileWithURL:url];
    }

}


@end
