
#import "XMGMineMainViewController.h"
#import "XMGSettingViewController.h"

#import "XMGMessageVC.h"
#import "XMGMineOrderReadVC.h"
#import "XMGPlayHistoryVC.h"
#import "XMGSupportVC.h"
#import "XMGBuyedSoundVC.h"
#import "XMGPayVC.h"
#import "XMGStorVC.h"
#import "XMGMyOrderVC.h"
#import "XMGGameCenterVC.h"
#import "XMGDeviceVc.h"
#import "XMGFreeFlowVC.h"
//#import "XMGHistoryController.h"

#import "XMGFindFriend.h"


@interface XMGMineMainViewController ()


@end

@implementation XMGMineMainViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    //添加一组
    [self setGroup1];
    [self setGroup2];
    [self setGroup3];
    [self setGroup4];
    [self setGroup5];

}


- (void)setGroup1{
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_notice_center"] name:@"我的消息"];
    rowItem.desClass  = [XMGMessageVC class];
    
    NSArray *rowArray1 = @[rowItem];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];

}

- (void)setGroup2{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_favAlbum"] name:@"我的订阅"];
    rowItem.desClass  = [XMGMineOrderReadVC class];
    
//    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_clock"] name:@"播放历史"];
//    rowItem1.desClass = [XMGHistoryController class];

    XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_liked"] name:@"赞过的"];
    rowItem2.desClass  = [XMGSupportVC class];
    
    NSArray *rowArray1 = @[rowItem,rowItem2];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}



- (void)setGroup3{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_boughttracks"] name:@"已购声音"];
    rowItem.desClass = [XMGBuyedSoundVC class];
    
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_account"] name:@"喜点余额"];
    rowItem1.desClass  =[XMGPayVC class];
    
    
    NSArray *rowArray1 = @[rowItem,rowItem1];
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}


- (void)setGroup4{
    
    //创建行
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_store"] name:@"喜马拉亚商城"];
    rowItem.desClass = [XMGStorVC class];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_myorder"] name:@"我的商城订单"];
    rowItem1.desClass = [XMGMyOrderVC class];
    
    
    XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_coupon"] name:@"我的优惠券"];
    rowItem2.desClass = [XMGMyOrderVC class];
    
    
    XMGArrowRowItem *rowItem3 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_game"] name:@"游戏中心"];
    rowItem3.desClass = [XMGGameCenterVC class];
    
    
    XMGArrowRowItem *rowItem4 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_device"] name:@"智能硬件设备"];
    rowItem4.desClass = [XMGDeviceVc class];
    
    NSArray *rowArray1 = @[rowItem,rowItem1,rowItem2,rowItem3,rowItem4];
    
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    [self.groupArray addObject:groupItem];
}


- (void)setGroup5{
    
    //创建行.
    XMGArrowRowItem *rowItem = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_union"] name:@"免流量服务"];
    rowItem.desClass = [XMGFreeFlowVC class];
    
    XMGArrowRowItem *rowItem1 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_findting"] name:@"找听友"];
    rowItem1.desClass = [XMGFindFriend class];
    
    XMGArrowRowItem *rowItem2 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_feedback"] name:@"意见反馈"];
    XMGArrowRowItem *rowItem3 = [XMGArrowRowItem settingRowItemWithImage:[UIImage imageNamed:@"me_setting_setting"] name:@"设置"];
    
    rowItem3.desClass = [XMGSettingViewController class];
    
    NSArray *rowArray1 = @[rowItem,rowItem1,rowItem2,rowItem3];
    
    XMGSettingGroupItem *groupItem = [XMGSettingGroupItem settingGroupItemWithRowArray:rowArray1 headerT:nil footerT:nil];
    
    [self.groupArray addObject:groupItem];
}

#define oriOffsetY -266
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%f",scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - oriOffsetY;
    //把偏移量传给代理
    if ([self.delegate respondsToSelector:@selector(settingScrollViewOffset:)]) {
        [self.delegate settingScrollViewOffset:offset];
    }
    
}


@end
