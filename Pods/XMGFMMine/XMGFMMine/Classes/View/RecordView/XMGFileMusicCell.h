//
//  XMGFileMusicCell.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGFileMusicCell : UITableViewCell

+ (instancetype)fileMusicCell;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void(^playBtnTask)(NSIndexPath *indexPath);
@property (weak, nonatomic) IBOutlet UIButton *playBtn;





@end
