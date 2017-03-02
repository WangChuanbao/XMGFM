//
//  XMGFMSingerCell.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMSingerCell.h"
#import "UIImageView+XMGExtension.h"

@interface XMGFMSingerCell()

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *singerIcon;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *middleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vLogo;

@end


@implementation XMGFMSingerCell

-(void)setAnchorM:(XMGFMAnchorModel *)anchorM {
    _anchorM = anchorM;
    [self.singerIcon setURLImageWithURL:[NSURL URLWithString:anchorM.middleLogo] placeHoldImage:nil isCircle:YES];
    self.titleLabel.text = anchorM.nickname;
    self.middleLabel.text = anchorM.verifyTitle;
    self.fansLabel.text = [NSString stringWithFormat:@"%zd 专辑", anchorM.tracksCounts];


    self.vLogo.hidden = !anchorM.isVerified;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
