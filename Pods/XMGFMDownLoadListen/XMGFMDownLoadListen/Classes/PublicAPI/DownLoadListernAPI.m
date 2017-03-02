//
//  DownLoadListernAPI.m
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

#import "DownLoadListernAPI.h"
#import "XMGDownLoadListenVC.h"
#import "XMGDownLoadDataTool.h"

@implementation DownLoadListernAPI

static DownLoadListernAPI *_shareInstance;

+ (instancetype)shareInstance {

    if (_shareInstance == nil) {
        _shareInstance = [[DownLoadListernAPI alloc] init];
        [_shareInstance registerNotification];
    }
    return _shareInstance;
}

- (void)registerNotification {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTrackInfo:) name:@"DownLoadListern_loadTrackInfo" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentPlayer:) name:@"DownLoadListern_presentPlayer" object:nil];


}

- (void)presentPlayer:(NSNotification *)notice {

    // 1. 获取通知传递过来的, 声音ID
    NSInteger trackID = [notice.object integerValue];

    [XMGDownLoadDataTool shareInstance].currentTrackID = trackID;
    // 2. 执行代码块
    if (self.presentPlayerBlock) {
        self.presentPlayerBlock(trackID);
    }
    
    
}


- (void)loadTrackInfo:(NSNotification *)notice {

    NSInteger trackID = [notice.object integerValue];
    if (self.loadTrackBlock) {
        self.loadTrackBlock(trackID);
    }

}

- (UIViewController *)getDownLoadListernVC {

    return [XMGDownLoadListenVC new];


}


+(void)load {
    [self shareInstance];
}

@end

