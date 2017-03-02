//
//  XMGPlayListSheetView.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlayListSheetView.h"
#import "XMGTrackInfoModel.h"
#import "XMGTrackInfoListCell.h"
#import "XMGPlayerDataTool.h"

#import "XMGPlayerSetModelToCell.h"
#import "Base.h"
//#import "XMGDownLoadService.h"
//#import "XMGDownLoadDataTool.h"

@interface XMGPlayListSheetView()<UITableViewDataSource, UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger trackID;

@end

@implementation XMGPlayListSheetView

-(void)setCurrentIndex:(NSInteger)currentIndex {
    if (self.trackInfoMs.count == 0 || currentIndex < 0 || currentIndex > self.trackInfoMs.count - 1) {
        _currentIndex = 0;
        return;
    }
    _currentIndex = currentIndex;
}

-(void)setTrackInfoMs:(NSMutableArray<XMGTrackInfoModel *> *)trackInfoMs
{
    _trackInfoMs = trackInfoMs;
    [self.tableView reloadData];
}

- (IBAction)playModel:(UIButton *)sender {

    NSLog(@"切换播放模式");
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"downLoadStateChangeNotification" object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (IBAction)close {

    if (self.closeBlock != nil) {
        self.closeBlock();
    }

}
-(void)refreshData {
    [self.tableView reloadData];
}


- (void)setAlbumID:(NSInteger)albumID trackID:(NSInteger)trackId {
    self.trackID = trackId;
    kWeakSelf;
    [[XMGPlayerDataTool shareInstance] getTrackMsWithAlbumId:albumID trackId:trackId result:^(NSMutableArray<XMGTrackInfoModel *> *trackMs) {
        weakSelf.trackInfoMs = trackMs;
    }];

}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trackInfoMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGTrackInfoListCell *cell = [XMGTrackInfoListCell cellWithTableView:tableView];

    __weak XMGTrackInfoModel *trackM = self.trackInfoMs[indexPath.row];

    if (trackM.trackId == self.trackID) {
        cell.playingLogo.image = [UIImage imageNamed:@"sound_playingbtn.gif"];
    }else {
        cell.playingLogo.image = nil;
    }

    cell.downLoadBlock = ^{
//        XMGDownLoadVoiceModel *voiceM = [[XMGDownLoadVoiceModel alloc] init];
//        voiceM.uid = trackM.uid;
//        voiceM.id = trackM.trackId;
//        [[XMGDownLoadDataTool shareInstance] setDownLoadMessageToVoiceM:voiceM complete:^{
//            [XMGDownLoadService downLoadVoiceM:voiceM];
//        }];
    };

    [XMGPlayerSetModelToCell setModel:self.trackInfoMs[indexPath.row] toCell:cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGTrackInfoModel *trackM = self.trackInfoMs[indexPath.row];

    if (self.clickItemBlock) {
        self.clickItemBlock(trackM);
    }

}




@end
