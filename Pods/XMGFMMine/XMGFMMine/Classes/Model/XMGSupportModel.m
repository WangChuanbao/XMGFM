//
//  XMGSupportModel.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSupportModel.h"
#import "MJExtension.h"

@implementation XMGSupportModel


+ (NSArray *)supportList {
    return  [XMGSupportModel mj_objectArrayWithFilename:@"suport.plist"];
}


@end
