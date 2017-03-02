//
//  XMGAnchorInfo.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAnchorInfo.h"
#import "Base.h"

@implementation XMGAnchorInfo

- (CGFloat)anchorCellHeight
{
    NSDictionary *titleDic = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:14]
                               };
    CGRect titleRect = [self.personalSignature boundingRectWithSize:CGSizeMake(kScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleDic context:nil];
    
    _anchorCellHeight = titleRect.size.height + 122;
    return _anchorCellHeight;
}
@end
