//
//  XMGSettingRowItem.h
//  彩票
//
//  Created by 弓虽_子 on 16/3/5.
//  Copyright © 2016年 弓虽_子. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMGSettingRowItem : NSObject


//typedef enum: NSInteger{
//
//    XMGSettingRowTypeArrow,
//    XMGSettingRowTypeSwitch
//
//}XMGSettingRowType;
//每一组右侧是什么类型的视图
//@property (nonatomic ,assign) XMGSettingRowType rowType;

//图标
@property (nonatomic , strong) UIImage *image;
//标题
@property (nonatomic, strong) NSString *name;
//子标题
@property (nonatomic , strong) NSString *detailTitle;

//根据图片和名称快速创建一个行模型
+ (instancetype)settingRowItemWithImage:(UIImage *)image name:(NSString *)name;

@property (nonatomic ,copy) void(^myTask)(NSIndexPath *indexPath);

//要跳转的控制器
@property (nonatomic ,assign) Class desClass;

@end





