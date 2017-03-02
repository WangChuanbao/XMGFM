//
//  XMGClassItemModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGClassItemModel : NSObject

@property (nonatomic, copy)  NSString *id;
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, assign)  BOOL isChecked;
@property (nonatomic, assign)  NSInteger orderNum;
@property (nonatomic, copy)  NSString *coverPath;
@property (nonatomic, assign)  BOOL selectedSwitch;
@property (nonatomic, assign)  BOOL isFinished;
@property (nonatomic, copy)  NSString *contentType;
@property (nonatomic, assign)  NSInteger categoryType;
@property (nonatomic, assign)  BOOL filterSupported;
@property (nonatomic, assign)  BOOL isPaid;


@end
