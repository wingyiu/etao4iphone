//
//  TBTraceRecord.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-30.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! 物流跟踪记录
@interface TBTraceRecord : TBModel {
    NSString    *acceptAddress;
    NSString    *acceptTime;
    NSString    *remark;
}

//! 完整的记录描述，包括 acceptAddress 及 remark
- (NSString *)fullDescription;

//! 记录地址
@property (nonatomic, retain)  NSString    *acceptAddress;

//! 记录时间
@property (nonatomic, retain)  NSString    *acceptTime;

//! 记录备注
@property (nonatomic, retain)  NSString    *remark;

@end
