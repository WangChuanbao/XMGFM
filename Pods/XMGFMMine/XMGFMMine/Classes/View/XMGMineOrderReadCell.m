//
//  XMGMineOrderReadCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMineOrderReadCell.h"
#import "UIImageView+WebCache.h"
#import "XMGAudioListModel.h"
//#import "NSDate+XMGDate.h"

@interface XMGMineOrderReadCell ()
@property (weak, nonatomic) IBOutlet UIView *imageViewBg;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation XMGMineOrderReadCell


+ (instancetype)mineOrderReadCell {
    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGMineOrderReadCell" owner:nil options:nil] firstObject];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置阴影
    self.imageViewBg.layer.shadowRadius = 3;
    self.imageViewBg.layer.shadowOpacity = 0.3;
    self.imageViewBg.layer.shadowOffset = CGSizeMake(0, 1);
    
}

- (void)setAudioM:(XMGAudioListModel *)audioM {
    _audioM = audioM;
    
    NSURL *url = [NSURL URLWithString:audioM.coverSmall];
    //设置图片
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    
    self.timeLabel.text = audioM.title;
    self.descriLabel.text = audioM.lastUptrackTitle;
    
    NSLog(@"%ld",audioM.updatedAt);
//    NSString *timeDate = [NSDate dateStrFromCstampTime:audioM.updatedAt withDateFormat:@"yyyy-MM"];

    
    NSString *timeStamp2 = @"1402051184000";
    long long int date1 = (long long int)[timeStamp2 intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSLog(@"时间戳转日期 %@  = %@", timeStamp2, date2);
    
    self.timeLabel.text = [NSString stringWithFormat:@"更新 %@",timeStamp2];
    
    
    
}









@end
