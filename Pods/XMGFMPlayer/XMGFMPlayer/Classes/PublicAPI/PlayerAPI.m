//
//  PlayerAPI.m
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

#import "PlayerAPI.h"
#import "XMGPlayerVC.h"


@implementation PlayerAPI

static PlayerAPI *_shareInstance;
+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [[PlayerAPI alloc] init];
        [_shareInstance registerNotification];
    }
    return _shareInstance;
}

- (void)registerNotification {

    // 监听本模块内部的行为动作
    // 1. 跳转到专辑详情界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToAlbumDetail:) name:@"PlayerAPI_jumpToAbumDetail" object:nil];

}


+(void)load {
    [self shareInstance];
}

- (void)jumpToAlbumDetail:(NSNotification *)notice {

    // 1. 获取通知传递过来的 当前导航控制器
    UINavigationController *currentNav = (UINavigationController *)notice.object[@"currentNav"];
    // 2. 获取通知传递过来的 专辑ID
    NSInteger albumID = [notice.object[@"albumID"] integerValue];

    // 3. 执行代码块
    if (self.jumpAlbumDetailBlock) {
        self.jumpAlbumDetailBlock(albumID, currentNav);
    }
    
}

- (void)loadTrackInfo:(NSInteger)trackID {

    [XMGPlayerVC shareInstanceWithAlbumId: 0 trackUid:trackID isUseCache: NO];


}

- (UINavigationController *)getPlayerNavgationControllerWithTrackId:(NSInteger)trackID isCache:(BOOL)isCache {

    return [XMGPlayerVC shareInstanceWithAlbumId: 0 trackUid:trackID isUseCache: isCache];

}


@end
