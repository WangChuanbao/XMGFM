//
//  XMGAlbumMenu.h
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGAlbum;
@class XMGTracks;

@interface XMGAlbumMenu : NSObject

/** 头部的数据 **/
@property (nonatomic, strong) XMGAlbum *album;

/** 节目的数据 **/
@property (nonatomic, strong) XMGTracks *tracks;

@end
