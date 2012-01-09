//
//  TBErrorResponse.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-23.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! TOP 返回错误信息时的实体
@interface TBErrorResponse : TBModel {
    NSString    *code;
    NSString    *msg;
    NSString    *sub_code;
    NSString    *sub_msg;
    
    NSDictionary *args;
    
    NSDictionary *raw;
}

//! 错误代码
@property (nonatomic, copy)    NSString    *code;

//! 错误信息
@property (nonatomic, retain)  NSString    *msg;

//! 子错误代码
@property (nonatomic, retain)  NSString    *sub_code;

//! 子错误信息
@property (nonatomic, retain)  NSString    *sub_msg;

//! 调用接口时传递的参数
@property (nonatomic, retain)  NSDictionary *args;

//! 原始错误信息
@property (nonatomic, retain)  NSDictionary *raw;

@end
