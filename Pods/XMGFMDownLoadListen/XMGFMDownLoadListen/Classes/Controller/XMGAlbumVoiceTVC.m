//
//  XMGAlbumVoiceTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAlbumVoiceTVC.h"
#import "XMGDownLoadVoiceModel.h"
#import "XMGDownLoadDataTool.h"
#import "Base.h"

@interface XMGAlbumVoiceTVC ()

@property (nonatomic, strong) NSArray<XMGDownLoadVoiceModel *> *downLoadingVoiceMs;

@end

@implementation XMGAlbumVoiceTVC

-(void)setDownLoadingVoiceMs:(NSArray<XMGDownLoadVoiceModel *> *)downLoadingVoiceMs
{
    _downLoadingVoiceMs = downLoadingVoiceMs;
    [self.tableView reloadData];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;

    self.title = self.albumM.albumTitle;
    
}

- (void)loadData {

    kWeakSelf;
    self.downLoadingVoiceMs = nil;
    [[XMGDownLoadDataTool shareInstance] getCurrentDownLoadedAlbumMs:^(NSArray<XMGDownLoadAlbumModel *> *downLoadingAlbumMs) {

        for (int i = 0; i < downLoadingAlbumMs.count; i ++) {
            XMGDownLoadAlbumModel *albumM = downLoadingAlbumMs[i];
            
            if (albumM.albumId == self.albumM.albumId) {
                weakSelf.downLoadingVoiceMs = albumM.voiceMs;
                break;
            }
        }

        [weakSelf.tableView reloadData];

    }];

}

@end
