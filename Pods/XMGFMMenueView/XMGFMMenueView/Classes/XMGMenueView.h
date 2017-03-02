//
//  XMGMenueView.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGMenueModelProtocol.h"

typedef void(^XMGMenueViewLoadImageBlock)(UIButton *imageBtn, NSURL *url);

@interface XMGMenueView : UIScrollView

@property (nonatomic, copy) XMGMenueViewLoadImageBlock loadBlock;


@property (nonatomic, strong) NSArray <id<XMGMenueModelProtocol>>*menueModels;


@end
