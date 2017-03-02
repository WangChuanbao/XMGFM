//
//  XMGFriendListM.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFriendListM.h"
#import "MJExtension.h"

@implementation XMGFriendListM


+ (NSArray *)getFriendsList {
    
     return  [XMGFriendListM mj_objectArrayWithFilename:@"friendsList.plist"];
}

@end
