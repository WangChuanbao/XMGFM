//
//  XMGAddFriendsCell.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAddFriendsCell.h"
#import "XMGFriendListM.h"
#import "UIImageView+WebCache.h"
#import "UIView+XMGLayout.h"

@interface XMGAddFriendsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *voiceCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;
@property (weak, nonatomic) IBOutlet UILabel *describleLabel;

@property (nonatomic, assign) BOOL  isChoose;

@property (weak, nonatomic) IBOutlet UIImageView *validImageView;


@end

@implementation XMGAddFriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 1;
    self.iconImageView.layer.borderColor = [UIColor grayColor].CGColor;
}



//添加按钮点击
- (IBAction)addBtnClick:(UIButton *)btn {
    
    
    self.isChoose = !self.isChoose;
    if (self.isChoose) {
         [btn setImage:[UIImage imageNamed:@"icon_rec_bgm_done"] forState:UIControlStateNormal];
    }else {
  
        
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定要取消关注" message:nil preferredStyle:0];
        UIAlertAction *actionV = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
               [btn setImage:[UIImage imageNamed:@"icon_rec_bgm_add"] forState:UIControlStateNormal];
        }];
        UIAlertAction *actionV1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:actionV];
        [alertVC addAction:actionV1];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }
    

}



+ (instancetype)friendsCellCell {

    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGAddFriendsCell" owner:nil options:nil] firstObject];
}



- (void)setFriedsM:(XMGFriendListM *)friedsM {
    
    _friedsM = friedsM;
    
    //设置数据
    //设置图片
    NSURL *url = [NSURL URLWithString:friedsM.smallLogo];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    self.nickName.text = friedsM.nickname;
    self.voiceCountLabel.text = [NSString stringWithFormat:@"声音:%ld",(long)friedsM.followings];
    
    NSInteger followers  =  friedsM.followers;
    
    self.favLabel.text  = [NSString stringWithFormat:@"粉丝:%d",followers];
    self.describleLabel.text = friedsM.ptitle;
    
    
    if (friedsM.isVerified) {
        self.validImageView.hidden = NO;
    }else {
        self.validImageView.hidden = YES;
    }
    
    

}



@end
