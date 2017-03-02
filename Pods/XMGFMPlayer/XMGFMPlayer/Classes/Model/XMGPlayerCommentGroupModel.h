//
//  XMGPlayerCommentGroupModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayerFrameModel.h"
#import "XMGCommentInfoModel.h"

@interface XMGPlayerCommentGroupModel : XMGPlayerFrameModel

@property (nonatomic, copy) NSString *groupTitle;

@property (nonatomic, copy) NSString *groupDetailTitle;


@property (nonatomic, strong) NSMutableArray <XMGCommentInfoModel *>*commentInfoMs;

@property (nonatomic, strong) void(^clickBlock)();

@end
