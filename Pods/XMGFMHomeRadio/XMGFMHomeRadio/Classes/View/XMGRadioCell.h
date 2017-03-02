//
//  XMGRadioCell.h
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGRadioModels.h"



@interface XMGRadioCell : UITableViewCell
typedef void(^moreBlok)(XMGRadioCell *cell);

@property (nonatomic, copy) moreBlok moreBlock;
@property (nonatomic, strong) XMGRadioModels *listMs;


@end
