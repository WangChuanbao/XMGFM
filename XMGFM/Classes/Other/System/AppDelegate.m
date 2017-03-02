//
//  AppDelegate.m
//  XMGFM
//
//  Created by 王顺子 on 16/10/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "AppDelegate.h"
#import "XMGMineVC.h"

#import "MainModuleAPI.h"
#import "HomeModuleAPI.h"
#import "DownLoadListernAPI.h"
#import "PlayerAPI.h"
#import "SubscriptAPI.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UITabBarController *rootVC = [MainModuleAPI rootTabBarCcontroller];
    [MainModuleAPI addChildVC:[HomeModuleAPI shareInstance].homeVC normalImageName:@"tabbar_find_n" selectedImageName:@"tabbar_find_h" isRequiredNavController:YES];
    [MainModuleAPI addChildVC:[SubscriptAPI shareInstance].subscriptVC normalImageName:@"tabbar_sound_n" selectedImageName:@"tabbar_sound_h" isRequiredNavController:YES];
    [MainModuleAPI addChildVC:[[DownLoadListernAPI shareInstance] getDownLoadListernVC] normalImageName:@"tabbar_download_n" selectedImageName:@"tabbar_download_h" isRequiredNavController:YES];
    [MainModuleAPI addChildVC:[XMGMineVC new] normalImageName:@"tabbar_me_n" selectedImageName:@"tabbar_me_h" isRequiredNavController:YES];

    [MainModuleAPI setTabbarMiddleBtnClick:^(BOOL isPlaying) {

            UINavigationController *nav = [[PlayerAPI shareInstance] getPlayerNavgationControllerWithTrackId:0 isCache:YES];
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];

    }];

    [MainModuleAPI setNavBarGlobalBackGroundImage:[UIImage imageNamed:@"navigationbar_bg_64"]];
    [MainModuleAPI setNavBarGlobalTextColor:[UIColor redColor] andFontSize:18];



    // 配置首页的各种需求
    [[HomeModuleAPI shareInstance] setJumpAlbumDetailBlock:^(NSInteger albumID, UINavigationController *currentNav) {
        NSLog(@"跳转到专辑详情----%zd", albumID);
        UIViewController *v = [[SubscriptAPI shareInstance] getAlbumDetailVCWithAlbumID:albumID];
        [currentNav pushViewController:v animated:YES];
    }];

    [[HomeModuleAPI shareInstance] setPresentPlayerBlock:^(NSInteger trackID) {
        UINavigationController *nav = [[PlayerAPI shareInstance] getPlayerNavgationControllerWithTrackId:trackID isCache:NO];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }];


    // 配置订阅的各种需求
    [[SubscriptAPI shareInstance] setPresentPlayerBlock:^(NSInteger trackID) {
        UINavigationController *nav = [[PlayerAPI shareInstance] getPlayerNavgationControllerWithTrackId:trackID isCache:NO];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];

    }];


    // 配置播放器的各种需求
    [[PlayerAPI shareInstance] setJumpAlbumDetailBlock:^(NSInteger albumID, UINavigationController *nav) {
        UIViewController *v = [[SubscriptAPI shareInstance] getAlbumDetailVCWithAlbumID:albumID];
        [nav pushViewController:v animated:YES];
    }];

    // 配置下载听的各种需求
    [[DownLoadListernAPI shareInstance] setLoadTrackBlock:^(NSInteger trackID) {
        NSLog(@"设置播放器, 加载响应的数据信息");
        [[PlayerAPI shareInstance] loadTrackInfo:trackID];
    }];
    [[DownLoadListernAPI shareInstance] setPresentPlayerBlock:^(NSInteger trackID) {
        UINavigationController *nav = [[PlayerAPI shareInstance] getPlayerNavgationControllerWithTrackId:trackID isCache:NO];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }];

    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}





@end
