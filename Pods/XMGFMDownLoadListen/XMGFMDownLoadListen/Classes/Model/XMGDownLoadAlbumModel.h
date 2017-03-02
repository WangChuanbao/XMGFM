//
//  XMGDownLoadAlbumModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGDownLoadVoiceModel.h"

@interface XMGDownLoadAlbumModel : NSObject

@property (nonatomic, strong) NSMutableArray <XMGDownLoadVoiceModel *>*voiceMs;

/** 删除按钮点击执行代码块 */
@property (nonatomic, strong) void(^deleteBlock)();

/** 格式化后的文件大小 */
@property (nonatomic, copy) NSString *fileFormatSize;

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger trackCount;
@property (nonatomic, copy) NSString *albumCoverMiddle;
@property (nonatomic, copy) NSString *albumTitle;





@end
