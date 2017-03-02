//
//  FJRTableRow.h
//  FengjrMobile
//
//  Created by 张九州 on 16/2/25.
//  Copyright © 2016年 fengjr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJRTableViewManagerProtocols.h"

@class FJRTableSection;

@interface FJRTableRow : NSObject

@property (nonatomic, weak, readonly) FJRTableSection *section;
@property (nonatomic, strong, readonly) id<FJRTableRowContext> context;

+ (instancetype)rowWithContext:(id<FJRTableRowContext>)context;
- (instancetype)init NS_UNAVAILABLE;

@end
