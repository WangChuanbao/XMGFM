//
//  XMGFMAnchorCell.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMAnchorCell.h"
#import "UIImageView+XMGExtension.h"

@interface XMGFMAnchorCell()

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XMGFMAnchorCell

-(void)setAnchorM:(XMGFMAnchorModel *)anchorM
{
    _anchorM = anchorM;
    [self.imageView setURLImageWithURL:[NSURL URLWithString:anchorM.middleLogo] progress:nil complete:nil];
    self.titleLabel.text = anchorM.verifyTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;



}

@end
