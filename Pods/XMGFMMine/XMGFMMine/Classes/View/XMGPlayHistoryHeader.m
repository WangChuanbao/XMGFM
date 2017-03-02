//
//  XMGPlayHistoryHeader.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayHistoryHeader.h"

@implementation XMGPlayHistoryHeader

+ (instancetype)playHistoryHeader {

    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGPlayHistoryHeader" owner:nil options:nil] firstObject];

}


@end
