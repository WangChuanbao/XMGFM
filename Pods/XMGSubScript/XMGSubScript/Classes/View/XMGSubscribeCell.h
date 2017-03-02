//
//  XMGSubscribeCell.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/12.
//  Copyright © 2016年 xuanzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGSubscribe;

@protocol XMGSubscribeCellDelegate<NSObject>
@optional
- (void)subscribeCellDidClickDownButton;
@end

@interface XMGSubscribeCell : UITableViewCell

@property (nonatomic, weak) id<XMGSubscribeCellDelegate> delegate;
@property(nonatomic, strong) XMGSubscribe *subscribe;

@end
