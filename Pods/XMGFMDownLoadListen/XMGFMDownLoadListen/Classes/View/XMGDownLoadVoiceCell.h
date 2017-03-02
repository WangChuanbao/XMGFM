//
//  XMGDownLoadVoiceCell.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGDownLoadVoiceCell : UITableViewCell

/** 声音标题 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTitleLabel;
/** 声音作者 */
@property (weak, nonatomic) IBOutlet UILabel *voiceAuthorLabel;
/** 声音文件大小 */
@property (weak, nonatomic) IBOutlet UILabel *voiceFileSizeLabel;
/** 声音播放次数 */
@property (weak, nonatomic) IBOutlet UIButton *voicePlayCountBtn;
/** 声音评论次数 */
@property (weak, nonatomic) IBOutlet UIButton *voiceCommentBtn;
/** 声音时长 */
@property (weak, nonatomic) IBOutlet UIButton *voiceDurationBtn;
/** 声音播放进度 */
@property (weak, nonatomic) IBOutlet UILabel *voicePlayProgressLabel;
/** 声音播放暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

/** 声音下载进度背景(需要控制隐藏显示) */
@property (weak, nonatomic) IBOutlet UIView *progressBackView;

/** 声音下载或者暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadOrPauseBtn;

/** 声音下载进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *downLoadProgressV;

/** 声音下载进度label */
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;




/** 点击执行代码块 */
@property (nonatomic, copy) void(^clickBlock)();

/** 删除执行代码块 */
@property (nonatomic, copy) void(^deleteBlock)();

/** 下载代码块 */
@property (nonatomic, copy) void(^downLoadBlock)(BOOL isDownLoad);

@property (nonatomic, assign) NSInteger trackID;
@property (nonatomic, strong) NSURL *playURL;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
