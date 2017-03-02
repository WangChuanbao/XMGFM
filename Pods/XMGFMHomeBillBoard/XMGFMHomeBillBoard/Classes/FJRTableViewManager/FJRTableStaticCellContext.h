//
//  FJRTableStaticCellContext.h
//  FengjrMobile
//
//  Created by 张九州 on 16/2/29.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJRTableViewManagerProtocols.h"

@interface FJRTableStaticCellContext : NSObject<FJRTableRowContext>

+ (instancetype)contextWithCellClass:(Class)cellClass height:(CGFloat)height;

@end
