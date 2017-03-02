//
//  FJRTableBlankHeaderViewContext.h
//  FengjrMobile
//
//  Created by 张九州 on 16/2/29.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJRTableViewManagerProtocols.h"

@interface FJRTableBlankSectionViewContext : NSObject<FJRTableSectionViewContext>

+ (instancetype)contextWithHeight:(CGFloat)height;

@end
