//
//  XMGCommentInfoModel.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentInfoModel.h"
#import "Base.h"

@implementation XMGCommentInfoModel

-(CGFloat)cellHeight {


    NSDictionary *fontDic = @{
                                      NSFontAttributeName: [UIFont systemFontOfSize:10]
                                      };
    CGRect fontRect = [self.content boundingRectWithSize:CGSizeMake(kScreenWidth - 73, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDic context:nil];

    // 计算高度
     return (fontRect.size.height + 50);


}

@end
