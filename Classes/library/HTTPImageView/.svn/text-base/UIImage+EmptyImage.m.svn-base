//
//  UIImage+EmptyImage.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-8-8.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import "UIImage+EmptyImage.h"
#import "UIImage+ImageWithName.h"

@implementation UIImage (EmptyImage)

+ (UIImage *)emptyImageForSize:(CGSize)size {
    int width = MAX(size.width, size.height);
    width = ceil(width/20.0) * 20;
    
    UIImage *img = [UIImage imageWithName:[NSString stringWithFormat:@"no_picture_%dx%d", width, width]];
    return img ? img : [UIImage imageWithName:@"no_picture_310x310"];
}

@end