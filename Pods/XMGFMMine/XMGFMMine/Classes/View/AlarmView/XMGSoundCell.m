//
//  XMGSoundCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSoundCell.h"

@interface XMGSoundCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *preSelBtn;

@end

@implementation XMGSoundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImageView.image = [[UIImage imageNamed:@"longsit_lastcell_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];

}
- (IBAction)btnClick:(UIButton *)btn {
    
    self.preSelBtn.selected = NO;
    btn.selected = YES;
    self.preSelBtn = btn;
    self.titleLabel.text = btn.titleLabel.text;
    
    //保存当前的名称
    [[NSUserDefaults standardUserDefaults] setObject:btn.titleLabel.text forKey:@"musicName"];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    XMGSoundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SoundCell"];
    if (cell == nil) {

        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGSoundCell" owner:nil options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
