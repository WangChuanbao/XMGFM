//
//  XMGShareModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGShareModel : NSObject


@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger lengthLimit;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *rowKey;
@property (nonatomic, copy) NSString *shareType;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *weixinPic;


@end
