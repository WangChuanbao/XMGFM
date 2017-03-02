//
//  PlayerDefine.h
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

// 1. 跳转到专辑详情的通知定义
#define kJumpToAlbumDetail(albumID,currentNav) \
[[NSNotificationCenter defaultCenter]  \
postNotificationName:@"PlayerAPI_jumpToAbumDetail" \
object:@{ \
@"albumID": albumID, \
@"currentNav": currentNav \
}];
