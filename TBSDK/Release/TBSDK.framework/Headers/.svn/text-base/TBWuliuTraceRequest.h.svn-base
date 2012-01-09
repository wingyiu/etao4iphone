//
//  WuliuTraceRequest.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-30.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TOPRequest.h"

//! 获取物流跟踪记录的请求
@interface TBWuliuTraceRequest : TOPRequest {
    NSString    *companyId;
    NSString    *mailNo;
}

/*! 根据物流公司的名称获取公司ID */
+ (NSString *)companyIdForName:(NSString *)name;

/*! 根据物流公司名称和物流单号来初始化一个物流跟踪记录请求 */
- (id)initWithCompanyName:(NSString *)name mailNo:(NSString *)aMailNo;

/*! 根据物流公司ID和物流单号来初始化一个物流跟踪记录请求 */
- (id)initWithCompanyId:(NSString *)compId mailNo:(NSString *)aMailNo;

/*! 公司ID */
@property (nonatomic, copy) NSString *companyId;

/*! 物流单号 */
@property (nonatomic, copy) NSString *mailNo;

@end
