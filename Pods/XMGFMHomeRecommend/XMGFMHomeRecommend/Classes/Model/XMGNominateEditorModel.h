//
//  XMGNominateEditorModel.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


// 小编推荐--更多
@interface XMGNominateEditorModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *albumCoverUrl290;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) NSInteger isFinished;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy) NSString *trackTitle;
@property (nonatomic, assign)  BOOL isPaid;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger priceTypeId;

@end
