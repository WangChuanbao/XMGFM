//
//  XMGTimeLabel.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTimeLabel.h"


@interface XMGTimeLabel ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation XMGTimeLabel

+ (instancetype)timeLabel {

    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGTimeLabel" owner:nil options:nil] firstObject];
}


- (void)updateWithDate:(NSInteger)newDate {
    // Update the timer label
//    int secRemaining = (int)floor([[NSDate date] timeIntervalSinceDate:newDate] + .5);
//    
//    int hours = secRemaining / 3600;
//    int minutes = secRemaining / 60 - hours * 60;
//    int seconds = secRemaining - minutes * 60 - hours * 3600;
    
    NSLog(@"%zd", newDate);
    // 66
    
    NSInteger minutes = newDate / 60;
    NSInteger seconds = newDate % 60;
    
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%02zd:%02zd",minutes, seconds]];
}


@end
