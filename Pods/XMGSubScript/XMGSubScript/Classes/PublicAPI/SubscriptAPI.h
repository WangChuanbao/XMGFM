//
//  SubscriptAPI.h
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

#import <Foundation/Foundation.h>

@interface SubscriptAPI : NSObject

+ (instancetype)shareInstance;


/**
  获取订阅控制器
 */
@property (nonatomic, weak, readonly) UIViewController *subscriptVC;


/**
 获取专辑详情控制器

 @param albumID 专辑ID
 */
- (UIViewController *)getAlbumDetailVCWithAlbumID:(NSInteger)albumID;


/**
 弹出播放器界面的block
 */
@property (nonatomic, copy) void(^presentPlayerBlock)(NSInteger trackID);




@end
