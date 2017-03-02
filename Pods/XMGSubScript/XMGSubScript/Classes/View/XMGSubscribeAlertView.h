//
//  XMGSubscribeAlertView.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XMGSubscribeAlertViewDelegate<NSObject>
@optional
- (void)subscribeAlertViewDidClickAlertButton:(NSString *)title;
@end

@interface XMGSubscribeAlertView : UIView
@property (nonatomic, weak) id<XMGSubscribeAlertViewDelegate> delegate;
@end
