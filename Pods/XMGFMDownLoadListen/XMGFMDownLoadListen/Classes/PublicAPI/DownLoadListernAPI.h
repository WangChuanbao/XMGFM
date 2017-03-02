//
//  DownLoadListernAPI.h
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

#import <Foundation/Foundation.h>

@interface DownLoadListernAPI : NSObject
+ (instancetype)shareInstance;


/**
 获取下载听控制器
 */
- (UIViewController *)getDownLoadListernVC;


/**
 加载播放声音信息
 */
@property (nonatomic, strong) void(^loadTrackBlock)(NSInteger trackID);

/**
 弹出播放器界面的block
 */
@property (nonatomic, copy) void(^presentPlayerBlock)(NSInteger trackID);

@end
