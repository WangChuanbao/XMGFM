//
//  XMGAlubmnDetailTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlubmnDetailVC.h"
#import "XMGPlayerDataTool.h"
#import "Base.h"

@interface XMGAlubmnDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation XMGAlubmnDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = @"声音详情";

    kWeakSelf
    [[XMGPlayerDataTool shareInstance] getTrackDetailWithTrackID:self.trackID result:^(XMGAlubmnDetailModel *alubmnDetailM) {

        weakSelf.introduceLabel.text = alubmnDetailM.richIntro;
        weakSelf.detailLabel.text = alubmnDetailM.lyric;


    }];

}




@end
