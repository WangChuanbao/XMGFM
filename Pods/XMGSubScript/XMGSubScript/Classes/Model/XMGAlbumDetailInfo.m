//
//  XMGAlbumDetailInfo.m
//  喜马拉雅FM
//
//  Created by 叶建华 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumDetailInfo.h"
#import "UIView+XMGLayout.h"
#import "Base.h"
@implementation XMGAlbumDetailInfo

- (CGFloat)contentCellHeight
{
    _contentCellHeight = 37;
    NSDictionary *titleDic = @{
                                NSFontAttributeName: [UIFont systemFontOfSize:13]
                                                             };
    CGRect titleRect = [self.intro boundingRectWithSize:CGSizeMake(kScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleDic context:nil];
    
    _contentCellHeight += (titleRect.size.height + 20);
    
    return _contentCellHeight;
}

@end
