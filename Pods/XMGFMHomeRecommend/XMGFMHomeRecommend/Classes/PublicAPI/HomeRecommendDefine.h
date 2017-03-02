//
//  HomeRecommendDefine.h
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

// 1. 跳转到专辑详情的通知定义
#define kJumpToAlbumDetail(albumID,currentNav) \
[[NSNotificationCenter defaultCenter]  \
postNotificationName:@"HomeRecommendAPI_jumpToAbumDetail" \
object:@{ \
@"albumID": albumID, \
@"currentNav": currentNav \
}];


// 2. 跳转到播放器的通知定义
#define kPresentToPlayer(trackID) \
[[NSNotificationCenter defaultCenter]  \
postNotificationName:@"HomeRecommendAPI_presentPlayer" \
object:@{ \
@"trackID": trackID, \
}];
