//
//  XMGAddFriendsCell.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGFriendListM;

@interface XMGAddFriendsCell : UITableViewCell

+ (instancetype)friendsCellCell;

@property (nonatomic, strong) XMGFriendListM *friedsM;

@end
