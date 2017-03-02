//
//  XMGAlbumDetailHeaderView.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGAlbum;

typedef void(^CallBackClickAlbumBlock)(NSInteger tag);
@interface XMGAlbumDetailHeaderView : UIView

@property(nonatomic, strong) XMGAlbum *album;

/** 传递事件回控制器 **/
@property (nonatomic, copy) CallBackClickAlbumBlock callBackClickAlbum;

@end
