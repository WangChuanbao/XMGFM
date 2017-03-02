//
//  XMGTrackInfoListCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/24.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XMGTrackInfoListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *playingLogo;

@property (weak, nonatomic) IBOutlet UILabel *trackTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@property (nonatomic, strong) void(^downLoadBlock)();


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
