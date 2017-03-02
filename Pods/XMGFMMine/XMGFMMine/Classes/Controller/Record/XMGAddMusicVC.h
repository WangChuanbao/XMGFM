//
//  XMGAddMusicVC.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGAddMusicVC : UITableViewController

@property (nonatomic, copy) void(^didChooseMusic)(NSString *filePath);

@end
