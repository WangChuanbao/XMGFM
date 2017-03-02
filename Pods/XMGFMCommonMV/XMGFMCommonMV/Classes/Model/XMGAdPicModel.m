//
//  XMGAdPicModel.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAdPicModel.h"

#import "XMGAdPicProtocol.h"

@interface XMGAdPicModel()<XMGAdPicProtocol>

@end

@implementation XMGAdPicModel

-(void)setFocusImageM:(XMGFocusImageModel *)focusImageM
{
    _focusImageM = focusImageM;
    self.adImgURL = [NSURL URLWithString:_focusImageM.pic];

}

-(void)setLiveM:(XMGLiveModel *)liveM {
    _liveM = liveM;
    self.adImgURL = [NSURL URLWithString:_liveM.coverPath];
}

-(void)setTuiguangM:(XMGTuiguangModel *)tuiguangM
{
    _tuiguangM = tuiguangM;
    self.adImgURL = [NSURL URLWithString:_tuiguangM.cover];
}

-(void)setClassItemM:(XMGClassItemModel *)classItemM
{
    _classItemM = classItemM;
    self.adImgURL = [NSURL URLWithString:_classItemM.coverPath];
}

@end
