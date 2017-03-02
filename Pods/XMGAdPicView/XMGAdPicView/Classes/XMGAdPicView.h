//
//  XMGAdPicView.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGAdPicProtocol.h"

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol XMGAdPicViewDelegate <NSObject>

- (void)adPicViewDidSelectedPicModel: (id <XMGAdPicProtocol>)picM;

@end



@interface XMGAdPicView : UIView

+ (instancetype)picViewWithLoadImageBlock: (LoadImageBlock)loadBlock;
/**
 *  用于加载图片的代码块, 必须赋值
 */
@property (nonatomic, copy) LoadImageBlock loadBlock;

/**
 *  用于告知外界, 当前滚动到的是哪个广告数据模型
 */
@property (nonatomic, strong) id<XMGAdPicViewDelegate> delegate;

/**
 *  用来展示图片的数据源
 */
@property (nonatomic, strong) NSArray <id <XMGAdPicProtocol>>*picModels;



@end
