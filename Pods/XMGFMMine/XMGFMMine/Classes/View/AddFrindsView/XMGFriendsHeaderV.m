//
//  XMGFriendsHeaderV.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGFriendsHeaderV.h"
#import "XMGFriendListM.h"
#import "UIImageView+WebCache.h"
#import "UIView+XMGLayout.h"

@interface XMGFriendsHeaderV()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *discribleLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *supLabel;

@end

@implementation XMGFriendsHeaderV


- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 2;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.iconImageView.layer.shadowOpacity = 1;
}


+ (instancetype)friendHeaderV {
    return [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGFriendsHeaderV" owner:nil options:nil] firstObject];

    
}

-(void)setFriendsM:(XMGFriendListM *)friendsM {
    _friendsM = friendsM;
    
    self.nickNameLabel.text = friendsM.nickname;
 
    self.voiceLabel.text = [NSString stringWithFormat:@"%ld",(long)friendsM.followings];
    
    self.fansLabel.text = [NSString stringWithFormat:@"%ld",(long)friendsM.followers];
    
    self.supLabel.text = [NSString stringWithFormat:@"%ld",(long)friendsM.tracks];
    
    self.discribleLabel.text = friendsM.personDescribe;
    
    NSURL *url = [NSURL URLWithString:friendsM.smallLogo];
    
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"find_albumcell_cover_bg"]];
    
    
}


@end
