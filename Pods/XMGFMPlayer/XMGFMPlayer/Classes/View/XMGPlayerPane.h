//
//  XMGPlayerPane.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTrackInfoModel.h"
#import "XMGUserInfoModel.h"

@interface XMGPlayerPane : UIView

@property (nonatomic, strong) XMGTrackInfoModel *trackM;
@property (nonatomic, strong) XMGUserInfoModel *userInfoM;


@property (nonatomic, assign) IBInspectable CGFloat radius;

@end
