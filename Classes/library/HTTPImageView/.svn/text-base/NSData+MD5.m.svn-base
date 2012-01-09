//
//  NSData+MD5.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 11-3-14.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import "NSData+MD5.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (MD5)

- (NSData *)md5Hash {
    const void *bytes = [self bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( bytes, [self length], result );
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}


- (NSString *)md5HashString {
    NSData *data = [self md5Hash];
    const unsigned char *bytes = (const unsigned char *)[data bytes];
    return [NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           bytes[0],  bytes[1],  bytes[2],  bytes[3],
           bytes[4],  bytes[5],  bytes[6],  bytes[7],
           bytes[8],  bytes[9],  bytes[10], bytes[11],
           bytes[12], bytes[13], bytes[14], bytes[15]];
}

@end
