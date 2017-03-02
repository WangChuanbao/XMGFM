//
//  XMGSettingGroupItem.h
//  彩票
//
//  Created by 弓虽_子 on 16/3/5.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSettingGroupItem : NSObject

//一组里面有多少行
@property (nonatomic ,strong) NSArray *rowArray;

//头标题
@property (nonatomic ,strong)NSString *headerTitle;
//行标题
@property (nonatomic, strong) NSString *footerTitle;

//快速创建一个组模型
+ (instancetype)settingGroupItemWithRowArray:(NSArray *)rowArray headerT:(NSString *)headerTitle footerT:(NSString *)footerTitle;


@end
