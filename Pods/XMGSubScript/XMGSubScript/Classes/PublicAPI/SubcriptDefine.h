//
//  SubcriptDefine.h
//  Pods
//
//  Created by 王顺子 on 16/10/30.
//
//

// 1. 跳转到播放器的通知定义
#define kPresentToPlayer(trackID) \
[[NSNotificationCenter defaultCenter]  \
postNotificationName:@"SubscriptAPI_presentPlayer" \
object:@{ \
@"trackID": trackID, \
}];
