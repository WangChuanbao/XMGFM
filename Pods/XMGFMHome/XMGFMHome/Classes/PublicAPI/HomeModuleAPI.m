//
//  HomeModuleAPI.m
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

#import "HomeModuleAPI.h"
#import "HomeRecommendAPI.h"


#import "HomeVC.h"

@implementation HomeModuleAPI
static HomeModuleAPI *_shareInstance;
+ (instancetype)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [[HomeModuleAPI alloc] init];
    }
    return _shareInstance;
}

- (UIViewController *)homeVC {
    return [[HomeVC alloc] init];
}


- (void)setJumpAlbumDetailBlock:(void (^)(NSInteger, UINavigationController *))jumpAlbumDetailBlock {
    [HomeRecommendAPI shareInstance].jumpAlbumDetailBlock = jumpAlbumDetailBlock;
}


-(void)setPresentPlayerBlock:(void (^)(NSInteger))presentPlayerBlock {
    [HomeRecommendAPI shareInstance].presentPlayerBlock = presentPlayerBlock;
}

@end
