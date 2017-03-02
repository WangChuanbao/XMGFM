//
//  XMGTrackInfoListCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/24.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTrackInfoListCell.h"

@implementation XMGTrackInfoListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {

    XMGTrackInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trackInfo"];
    if (cell == nil) {

        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"XMGTrackInfoListCell" owner:nil options:nil].firstObject;

    }
    return cell;
}



- (IBAction)downLoad {


    if (self.downLoadBlock) {
        self.downLoadBlock();
    }

}




@end
