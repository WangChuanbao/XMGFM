//
//  XMGDownLoadAlbumCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadAlbumCell.h"


@implementation XMGDownLoadAlbumCell

static NSString *const cellID = @"downLoadAlbum";

+ (instancetype)cellWithTableView:(UITableView *)tableView {

    XMGDownLoadAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
            cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGDownLoadAlbumCell" owner:nil options:nil] firstObject];

    }

    return cell;
}

- (IBAction)delete {

    if (self.deleteBlock) {
        self.deleteBlock();
    }

}



@end
