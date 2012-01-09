//
//  NSData+MD5.h
//  taobao4iphone
//
//  Created by Xu Jiwei on 11-3-14.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (MD5)

- (NSData *)md5Hash;
- (NSString *)md5HashString;

@end
