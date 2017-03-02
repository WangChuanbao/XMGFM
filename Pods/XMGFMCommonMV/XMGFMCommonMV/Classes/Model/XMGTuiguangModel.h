//
//  XMGTuiguangModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMGTuiguangModel : NSObject


@property (nonatomic, copy)  NSString *shareData;
@property (nonatomic, assign)  BOOL isShareFlag;
@property (nonatomic, copy)  NSString *link;
@property (nonatomic, copy, getter=adImgURL)  NSString *cover;
@property (nonatomic, assign)  NSInteger showstyle;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy)  NSString *Description;
@property (nonatomic, copy)  NSString *scheme;
@property (nonatomic, assign)  NSInteger linkType;
@property (nonatomic, assign)  NSInteger displayType;
@property (nonatomic, assign)  NSInteger clickType;
@property (nonatomic, assign)  NSInteger openlinkType;
@property (nonatomic, assign)  NSInteger loadingShowTime;
@property (nonatomic, copy)  NSString *thirdStatUrl;
@property (nonatomic, copy)  NSString *apkUrl;
@property (nonatomic, copy)  NSString *adtype;
@property (nonatomic, assign)  BOOL Auto;
@property (nonatomic, assign)  NSInteger position;
@property (nonatomic, assign)  NSInteger adid;


@end
