//
//  XMGAlbumRecommendCell.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGOtherRecommands;

@protocol XMGAlbumRecommendCellDelegate<NSObject>

- (void)albumRecommendCellDidSelectCell:(NSString *)albumId;

@end

typedef void(^GetMoreRecommend)();
@interface XMGAlbumRecommendCell : UITableViewCell

/** 点击查看更多 回调**/
@property(nonatomic, copy)GetMoreRecommend getMoreRecommend;


@property (nonatomic, strong)XMGOtherRecommands *otherRecommands;
@property (nonatomic, weak) id<XMGAlbumRecommendCellDelegate> delegate;
@end
