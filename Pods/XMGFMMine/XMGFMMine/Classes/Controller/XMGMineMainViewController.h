
#import <UIKit/UIKit.h>
#import "XMGBaseSettingVC.h"

@protocol XMGSettingViewController <NSObject>

- (void)settingScrollViewOffset:(CGFloat)offset;

@end

@interface XMGMineMainViewController : XMGBaseSettingVC

@property (nonatomic,weak) id<XMGSettingViewController> delegate;


@end
