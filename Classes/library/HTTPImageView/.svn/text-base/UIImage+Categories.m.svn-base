//
//  UIImage+Categories.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 11-1-27.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import "UIImage+Categories.h"
#import "UIImage+ImageWithName.h"

@implementation UIImage (Categories)

+ (UIImage *)placeHolderForSize:(CGSize)size {
    int width = MAX(size.width, size.height);
    width = ceil(width/20.0) * 20;
    
    UIImage *img = [UIImage imageWithName:[NSString stringWithFormat:@"picture_holder_%dx%d", width, width]];
    return img ?: [UIImage imageWithName:@"picture_holder_360x360"];
}

@end
