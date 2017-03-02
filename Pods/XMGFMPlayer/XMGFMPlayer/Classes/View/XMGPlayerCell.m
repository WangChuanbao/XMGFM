//
//  XMGPlayerCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayerCell.h"
#import "UIImageView+XMGExtension.h"

@interface XMGPlayerCell()

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@property (weak, nonatomic) IBOutlet UIButton *followCountBtn;

@property (weak, nonatomic) IBOutlet UIButton *voiceCountBtn;


@end

@implementation XMGPlayerCell

- (void)setAlbumInfoM:(XMGAlbumInfoModel *)albumInfoM
{
    _albumInfoM = albumInfoM;

    NSURL *url = [NSURL URLWithString:albumInfoM.coverSmall];
    [self.userIcon setURLImageWithURL:url placeHoldImage:nil isCircle:NO];

    self.nameLabel.text = albumInfoM.title;
    self.introduceLabel.text = albumInfoM.intro;

    [self.followCountBtn setTitle:[NSString stringWithFormat:@"%.01f万", albumInfoM.shares / 10000.0] forState:UIControlStateNormal];

    [self.voiceCountBtn setTitle:[NSString stringWithFormat:@"%zd集", albumInfoM.tracks] forState:UIControlStateNormal];


    

}


+ (instancetype)cellWithTableView:(UITableView *)tableView {

    XMGPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommend"];
    if (cell == nil) {

        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"XMGPlayerCell" owner:nil options:nil].firstObject;
        

    }
    
    return cell;
}


@end
