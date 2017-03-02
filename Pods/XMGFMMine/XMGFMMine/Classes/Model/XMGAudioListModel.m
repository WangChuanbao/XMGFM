//
//  XMGMyOrderReader.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAudioListModel.h"
#import "MJExtension.h"


@implementation XMGAudioListModel

+ (NSArray *)historyList {
    
   return  [XMGAudioListModel mj_objectArrayWithFilename:@"history.plist"];
}


+ (NSArray *)supportList {
    return  [XMGAudioListModel mj_objectArrayWithFilename:@"myOrderReader"];
}


@end
