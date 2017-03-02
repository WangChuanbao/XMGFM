//
//  XMGTimeLabel.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTimeLabel : UICollectionViewCell


+ (instancetype)timeLabel;

- (void)updateWithDate:(NSInteger)newDate;


@end
