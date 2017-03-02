//
//  XMGNoDownLoadView.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGNoDownLoadView.h"

@interface XMGNoDownLoadView()

@property (weak, nonatomic) IBOutlet UIImageView *noDataImageView;


@end

@implementation XMGNoDownLoadView

+ (instancetype)noDownLoadViewWithType: (XMGNoDownLoadViewType)type {


    NSBundle *_currentBundle = [NSBundle bundleForClass:self];

    XMGNoDownLoadView *noDataView = [[_currentBundle loadNibNamed:@"XMGNoDownLoadView" owner:nil options:nil] firstObject];

    NSString *bundleName = [[_currentBundle bundleIdentifier].pathExtension stringByAppendingString:@".bundle"];


    if (type == XMGNoDownLoadViewNoDownLoaded) {
        NSString *downLoadedPath = [_currentBundle pathForResource:@"noData_download.png" ofType:nil inDirectory:bundleName];
        noDataView.noDataImageView.image = [UIImage imageWithContentsOfFile:downLoadedPath];
    }else if(type == XMGNoDownLoadViewNoDownLoading)
    {
        NSString *downLoadedPath = [_currentBundle pathForResource:@"noData_downloading@3x.png" ofType:nil inDirectory:bundleName];
        noDataView.noDataImageView.image = [UIImage imageWithContentsOfFile:downLoadedPath];
        
    }
    return noDataView;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (IBAction)goView {
    if (self.clickBlock != nil) {
        self.clickBlock();
    }
}


@end
