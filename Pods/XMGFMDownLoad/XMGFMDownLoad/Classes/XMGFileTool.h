//
//  XMGFileTool.h
//  Pods
//
//  Created by 王顺子 on 16/10/23.
//
//

#import <Foundation/Foundation.h>

@interface XMGFileTool : NSObject

+ (long long int)getFileSizeWithPath: (NSString *)filePath;

+ (void)removeFileAtPath: (NSString *)filePath;

+ (float)calculateFileSizeInUnit:(unsigned long long)contentLength;

+ (NSString *)calculateUnit:(unsigned long long)contentLength;




@end
