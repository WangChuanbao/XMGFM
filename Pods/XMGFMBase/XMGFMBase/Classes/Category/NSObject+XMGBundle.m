//
//  NSBundle+XMGBundle.m
//  XMGLY-Parts
//
//  Created by 王顺子 on 16/9/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSObject+XMGBundle.h"

@implementation NSObject (XMGBundle)

//static NSBundle * _currentBundle;

+ (NSBundle *)currentBundle {

    NSBundle *bundle = [NSBundle bundleForClass:self];
    return bundle;
//    if (_currentBundle == nil) {
//        NSArray *frames = [NSBundle allFrameworks];
//        for (NSBundle *bundle in frames) {
//            NSString *bundleName = bundle.bundleURL.lastPathComponent;
//            if ([bundleName containsString:@"DiscoverModule"]) {
//                _currentBundle = bundle;
//                break;
//            }
//        }
//    }
//    if (_currentBundle == nil) {
//        return [NSBundle mainBundle];
//    }
//    return _currentBundle;
}

@end
