//
//  XMGFNAnchorGroupModel.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMAnchorGroupModel.h"

@implementation XMGFMAnchorGroupModel


- (CGFloat)cellHeight {

    if (self.displayStyle == 1) {
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20 * 4) / 3;
        return  2 * width * 1.4 + 35 + 20 + 20;
    }

    if (self.displayStyle == 0) {
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20 * 4) / 3;
        return  1 * width * 1.4 + 35 + 20;
    }

    if (self.displayStyle == 2) {
        return  6 * 70 + 35 + 20;
    }

    return 0.0;
}

@end
