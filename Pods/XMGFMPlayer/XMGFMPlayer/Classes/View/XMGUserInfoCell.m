//
//  XMGUserInfoCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGUserInfoCell.h"
#import "UIImageView+XMGExtension.h"

@interface XMGUserInfoCell()


@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@property (weak, nonatomic) IBOutlet UIButton *followCountBtn;

@property (weak, nonatomic) IBOutlet UIButton *voiceCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@end


@implementation XMGUserInfoCell

- (void)setAlbumInfoM:(XMGAlbumInfoModel *)albumInfoM
{
    _albumInfoM = albumInfoM;

    NSURL *url = [NSURL URLWithString:albumInfoM.coverSmall];
    [self.userIcon setURLImageWithURL:url placeHoldImage:nil isCircle:NO];

    self.nameLabel.text = albumInfoM.title;
    self.introduceLabel.text = albumInfoM.intro;

    [self.followCountBtn setTitle:[NSString stringWithFormat:@"%.01f万", albumInfoM.shares / 10000.0] forState:UIControlStateNormal];

    [self.voiceCountBtn setTitle:[NSString stringWithFormat:@"%zd集", albumInfoM.tracks] forState:UIControlStateNormal];


    _albumInfoM.cellHeight = 55;

}


+ (instancetype)cellWithTableView:(UITableView *)tableView {

    XMGUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfo"];
    if (cell == nil) {

        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"XMGUserInfoCell" owner:nil options:nil].firstObject;

    }

    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
