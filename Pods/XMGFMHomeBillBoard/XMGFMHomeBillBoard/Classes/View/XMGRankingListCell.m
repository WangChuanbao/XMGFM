//
//  XMGRankingListCell.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/9/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRankingListCell.h"
#import "XMGRankingInfoModel.h"
#import "UIImageView+WebCache.h"
#import "XMGRankingFirstModel.h"

@interface XMGRankingListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *subTitle1;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2;

@end

@implementation XMGRankingListCell

- (void)setContext:(id<FJRTableRowContext>)context
{
    XMGRankingInfoModel *vm = (XMGRankingInfoModel *)context;
    self.titleL.text = vm.title;
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:vm.coverPath] placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    
    self.subTitle1.text = [NSString stringWithFormat:@"1 %@", vm.firstKResults[0].title];
    self.subTitle2.text = [NSString stringWithFormat:@"2 %@", vm.firstKResults[1].title];
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"XMGRankingListCell" owner:nil options:nil].firstObject;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.coverImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.coverImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.coverImageView.layer.shadowOpacity = 0.5;
}

@end
