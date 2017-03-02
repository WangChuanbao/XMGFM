//
//  XMGCommentInfoModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGPlayerFrameModel.h"

@interface XMGCommentInfoModel : XMGPlayerFrameModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger track_id;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *smallHeader;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, assign) NSInteger likes;


@end
