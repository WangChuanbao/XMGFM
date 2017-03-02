//
//  XMGAlbumTagCell.h
//  喜马拉雅FM
//
//  Created by xuanzhihua on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XMGAlbumTagCellDelegate<NSObject>
- (void)albumTagCellDidClickTagButton;
@end

@interface XMGAlbumTagCell : UITableViewCell
@property (nonatomic, weak) id<XMGAlbumTagCellDelegate> delegate;
@end
