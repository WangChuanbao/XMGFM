//
//  XMGSpecialColumnModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSpecialColumnModel : NSObject

@property (nonatomic, assign)  NSInteger columnType;
@property (nonatomic, assign)  NSInteger specialId;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, copy)  NSString *subtitle;
@property (nonatomic, copy)  NSString *footnote;
@property (nonatomic, copy)  NSString *coverPath;
@property (nonatomic, copy)  NSString *contentType;

@end
