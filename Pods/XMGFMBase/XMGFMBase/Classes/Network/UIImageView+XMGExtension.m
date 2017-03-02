//
//  UIImageView+XMGExtension.m
//  百思不得姐
//
//  Created by 王顺子 on 16/6/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImageView+XMGExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+XMGImage.h"


@implementation UIImageView (XMGExtension)


- (void)setURLImageWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))progress complete: (void(^)())complete {

    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progress != nil)
        {
            progress(1.0 * receivedSize / expectedSize);
        }

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image;
        if (complete != nil)
        {
            complete();
        }
    }];

}

- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle {

    if (isCircle) {
        [self sd_setImageWithURL:url placeholderImage:[placeHoldImage circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            UIImage *resultImage = [image circleImage];

            // 6. 处理结果图片
            if (resultImage == nil) return;
            self.image = resultImage;
            
            
        }];

    }else {
        [self sd_setImageWithURL:url placeholderImage:placeHoldImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            // 6. 处理结果图片
            if (image == nil) return;
            self.image = image;
            
            
        }];

    }


}

@end
