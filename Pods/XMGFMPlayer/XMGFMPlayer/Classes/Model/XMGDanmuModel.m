//
//  XMGDanmuModel.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/9/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDanmuModel.h"
#import "XMGDanmuProtocol.h"

@implementation XMGDanmuModel


- (NSAttributedString *)attributeContent {

    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];

    NSAttributedString *userName = [[NSAttributedString alloc] initWithString:[self.nickname stringByAppendingString:@": "] attributes:@{
                                                                                                                                           NSFontAttributeName: [UIFont systemFontOfSize:12],
                                                                                                                                           NSForegroundColorAttributeName: [UIColor brownColor]
                                                                                                                                           }];
    [attributeStr appendAttributedString:userName];

    NSAttributedString *content = [[NSAttributedString alloc] initWithString:self.content attributes:@{
                                                                                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                                                                                         NSForegroundColorAttributeName: [UIColor grayColor]
                                                                                                         }];
    [attributeStr appendAttributedString:content];

    return attributeStr;
}

-(NSTimeInterval)liveTime {
    NSInteger time = self.content.length + self.nickname.length;
    return time > 20 ? 20 : time;
}

@end
