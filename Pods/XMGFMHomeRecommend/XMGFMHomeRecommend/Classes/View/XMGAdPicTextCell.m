//
//  XMGAdPicTextCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAdPicTextCell.h"
#import "XMGAdPicView.h"
#import "UIImageView+XMGExtension.h"
#import "XMGAdPicModel.h"


#define kCellMargin 10

@interface XMGAdPicTextCell ()<XMGAdPicViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet XMGAdPicView *adPicView;
@property (weak, nonatomic) IBOutlet UILabel *upTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;


@end

@implementation XMGAdPicTextCell

static NSString *const cellID = @"CellTypeList1";

+ (instancetype)cellWithTableView: (UITableView *)tableView {

    XMGAdPicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {

        cell =  [[NSBundle bundleForClass:self] loadNibNamed:@"XMGAdPicTextCell" owner:nil options:nil].firstObject;
    }
    return cell;
    
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self.adPicView setLoadBlock:^(UIImageView *imageView, NSURL *url){
        [imageView setURLImageWithURL:url progress:nil complete:nil];

    }];
    self.adPicView.delegate = self;
}

-(void)setGroupM:(XMGGroupModel *)groupM
{
    _groupM = groupM;
    self.titleLabel.text = groupM.title;

    NSMutableArray *picMs = [NSMutableArray array];

    NSLog(@"%@", groupM.liveMs);

    if (groupM.liveMs.count > 0) {
        for (XMGLiveModel *liveM in groupM.liveMs) {
            XMGAdPicModel *picM = [[XMGAdPicModel alloc] init];
            picM.liveM = liveM;
            [picMs addObject:picM];
        }
    }else if (groupM.tuiguangMs.count > 0)
    {
        for (XMGTuiguangModel *tuiguangM in groupM.tuiguangMs) {
            XMGAdPicModel *picM = [[XMGAdPicModel alloc] init];
            picM.tuiguangM = tuiguangM;
            [picMs addObject:picM];
        }
    }



    self.adPicView.picModels = picMs;

}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}

- (IBAction)more {

}

-(void)adPicViewDidSelectedPicModel:(XMGAdPicModel *)picM
{
    

    XMGLiveModel *liveM = picM.liveM;
    if (liveM != nil) {
        self.upTitleLabel.text = liveM.name;
        self.detailTitleLabel.text = liveM.shortDescription;
        double count = [liveM.playCount doubleValue];
        if (count > 10000) {
            count = count / 10000.0;
            self.rightTitleLabel.text = [NSString stringWithFormat:@"%.01f万人参与", count];
        }else {
            self.rightTitleLabel.text = [NSString stringWithFormat:@"%zd人参与", count];
        }
    }

    XMGTuiguangModel *tuiguangM = picM.tuiguangM;
    if (tuiguangM != nil) {
        self.upTitleLabel.text = tuiguangM.name;
        self.detailTitleLabel.text = tuiguangM.Description;

    }


}


@end
