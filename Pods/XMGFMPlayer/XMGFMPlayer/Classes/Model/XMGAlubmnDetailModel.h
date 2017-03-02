//
//  XMGAlubmnDetailModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGAlubmnDetailModel : NSObject


@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy) NSString *lyric;
@property (nonatomic, copy) NSString *richIntro;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *msg;


@end
