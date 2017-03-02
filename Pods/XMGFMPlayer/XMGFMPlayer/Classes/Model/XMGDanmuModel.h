//
//  XMGDanmuModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/9/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol XMGDanmuProtocol;

@interface XMGDanmuModel : NSObject<XMGDanmuProtocol>



@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy, getter=headerIconUrl) NSString *smallHeader;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger track_id;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) NSInteger likes;

- (NSAttributedString *)attributeContent;


/**
 *  存活时间
 */
@property (nonatomic, assign) NSTimeInterval liveTime;
/**
 *  开始时间
 */
@property (nonatomic, assign) NSTimeInterval beginTime;


@end
