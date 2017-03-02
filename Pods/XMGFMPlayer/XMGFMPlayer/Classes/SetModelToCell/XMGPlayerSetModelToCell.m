//
//  XMGPlayerSetModelToCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayerSetModelToCell.h"
#import "XMGTrackInfoModel.h"
#import "XMGTrackInfoListCell.h"
//#import "XMGDownLoadDataTool.h"

//#import "UIImage+GIF.h"

@implementation XMGPlayerSetModelToCell

+ (void)setModel:(id)model toCell:(UITableViewCell *)cell {


    if ([model isKindOfClass:[XMGTrackInfoModel class]]) {
        XMGTrackInfoModel *modelR = (XMGTrackInfoModel *)model;
        if ([cell isKindOfClass:[XMGTrackInfoListCell class]]) {

            XMGTrackInfoListCell *cellR = (XMGTrackInfoListCell *)cell;

            cellR.trackTitleLabel.text = modelR.title;

            // 判断, 是否存在下载文件
//            NSArray *downLoadMIDs = [[XMGDownLoadDataTool getCurrentDownLoadedVoiceMs] valueForKeyPath:@"id"];
            NSArray *downLoadMIDs;
            if ([downLoadMIDs containsObject:@(modelR.trackId)]) {
                [cellR.downLoadBtn setImage:[UIImage imageNamed:@"cell_downloaded"] forState:UIControlStateNormal];
            }else {
                 [cellR.downLoadBtn setImage:[UIImage imageNamed:@"cell_download"] forState:UIControlStateNormal];
            }




        }

    }

}


@end
