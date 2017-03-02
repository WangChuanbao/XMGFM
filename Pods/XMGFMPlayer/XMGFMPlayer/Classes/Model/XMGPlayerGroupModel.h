//
//  XMGPlayerGroupModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGAlbumInfoModel.h"

#import "XMGPlayerFrameModel.h"

@interface XMGPlayerGroupModel : XMGPlayerFrameModel

@property (nonatomic, copy) NSString *groupTitle;

@property (nonatomic, copy) NSString *groupDetailTitle;

@property (nonatomic, strong) NSMutableArray <XMGAlbumInfoModel *>*albumInfoMs;

@property (nonatomic, copy) void(^clickBlock)();

@end
