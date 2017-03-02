//
//  CountdownView.m
//  Start
//
//  Created by Nick Place on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CountdownView.h"


@implementation CountdownView
@synthesize countdownLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    CGRect labelRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    countdownLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    [self addSubview:countdownLabel];
    [countdownLabel setTextAlignment:NSTextAlignmentLeft];
    [countdownLabel setTextColor:[UIColor blackColor]];
    [countdownLabel setBackgroundColor:[UIColor clearColor]];
    shouldFlash = NO;
    [countdownLabel setText:@"00:00:00"];
    
}


- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGRect labelRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    countdownLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    [self addSubview:countdownLabel];
    [countdownLabel setTextAlignment:NSTextAlignmentCenter];
    [countdownLabel setTextColor:[UIColor whiteColor]];
    [countdownLabel setBackgroundColor:[UIColor clearColor]];
    shouldFlash = NO;
    [countdownLabel setText:@"00:00:00"];
  }
  return self;
}



/*
 NSOrderedAscending的意思是：左边的操作对象小于右边的对象。
 NSOrderedDescending的意思是：左边的操作对象大于右边的对象。
 */

- (void)updateWithDate:(NSDate *)newDate {
    
  //Update the countdown label
  int secRemaining = (int)floor([newDate timeIntervalSinceDate:[NSDate date]] + .5);
  
  if (secRemaining <= 0) {
    secRemaining = 0;
    if (!shouldFlash) {
      shouldFlash = YES;
      [self startFlashing];
    }
  } else {
    shouldFlash = NO;
    [countdownLabel setAlpha:1];
  }
  
  int hours = secRemaining / 3600;
  int minutes = secRemaining / 60 - hours * 60;
  int seconds = secRemaining - minutes * 60 - hours * 3600;
  
  [countdownLabel setText:[NSString stringWithFormat:@" %02i:%02i:%02i", hours, minutes, seconds]];
}

- (void)startFlashing {
  [UIView animateWithDuration:.25 delay:.6 options:0 animations:^{
    if (shouldFlash)
    [countdownLabel setAlpha:0];
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:.05 delay:.1 options:0 animations:^{
      [countdownLabel setAlpha:1];
    } completion:^(BOOL finished) {
      if (shouldFlash)
      [self startFlashing];
    }];
  }];
}

@end
