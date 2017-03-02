//
//  XMGHistoryHeaderView.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XMGHistoryHeaderViewDelegate<NSObject>
@optional
- (void)historyHeaderViewDidClickHeaderButton:(NSString *)title;
@end

@interface XMGHistoryHeaderView : UIView
@property (nonatomic,weak) id<XMGHistoryHeaderViewDelegate> delegate;
@end
