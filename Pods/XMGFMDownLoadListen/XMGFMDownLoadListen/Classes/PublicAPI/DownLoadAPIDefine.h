//
//  DownLoadAPIDefine.h
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

// 1. 加载专辑信息
#define kLoadTrackInfo(trackID) \
[[NSNotificationCenter defaultCenter] \
postNotificationName:@"DownLoadListern_loadTrackInfo" object:trackID];

// 2. 跳转到播放器的通知定义
#define kPresentToPlayer(trackID) \
[[NSNotificationCenter defaultCenter]  \
postNotificationName:@"DownLoadListern_presentPlayer" \
object:trackID];
