//
//  XMGRecommendsCell.h.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGRecommends;
@class XMGOtherRecommand;

@interface XMGRecommendsCell : UITableViewCell

@property(nonatomic, strong) XMGRecommends *recommends;
@property(nonatomic, strong) XMGOtherRecommand *otherRecommand;

@end
