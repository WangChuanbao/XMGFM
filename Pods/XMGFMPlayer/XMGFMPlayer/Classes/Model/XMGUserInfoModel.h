//
//  XMGUserInfoModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUserInfoModel : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger albums;
@property (nonatomic, copy) NSString *ptitle;
@property (nonatomic, copy) NSString *personDescribe;

@end
