//
//  XMGTodayFireVoiceCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    XMGCellDownLoadStateWait,
    XMGCellDownLoadStateDownLoading,
    XMGCellDownLoadStateDownLoaded,

}XMGCellDownLoadState;

@interface XMGTodayFireVoiceCell : UITableViewCell
/** 声音标题 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTitleLabel;
/** 声音作者 */
@property (weak, nonatomic) IBOutlet UILabel *voiceAuthorLabel;
/** 声音播放暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/** 声音排名标签 */
@property (weak, nonatomic) IBOutlet UILabel *sortNumLabel;
/** 声音下载按钮 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;


/** 声音下载block */
@property (nonatomic, strong) void(^clickBlock)();

@property (nonatomic, assign) NSInteger trackID;
@property (nonatomic, strong) NSURL *playURL;

@property (nonatomic, assign) XMGCellDownLoadState downLoadState;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
