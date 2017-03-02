//
//  XMGPlayerVC.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGPlayerVC : UITableViewController


+ (UINavigationController *)shareInstanceWithAlbumId: (NSInteger)albumId trackUid:(NSInteger)trackUid isUseCache: (BOOL)isUseCache;

/** 加载网络音频 */
// 此字段可以为0
@property (nonatomic, assign)  NSInteger albumId;
// 必传字段
@property (nonatomic, assign)  NSInteger trackUid;

- (void)loadData;

@end
