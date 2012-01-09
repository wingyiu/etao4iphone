//
//  MTOPRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-24.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TOPRequest.h"

//! 无线MTOP的请求
@interface MTOPRequest : TOPRequest {
    NSMutableDictionary     *data;
}

- (void)addTopParam:(NSObject *)param forKey:(NSString *)key;
- (void)removeTopParam:(NSString *)key;

/*! 无线 MTOP 请求的参数 */
@property (nonatomic, readonly) NSMutableDictionary *data;

@end
