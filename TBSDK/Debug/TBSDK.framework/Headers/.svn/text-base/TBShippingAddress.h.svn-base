//
//  TBShippingAddress.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-7-8.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! 无线MTOP中收货地址信息
@interface TBShippingAddress : TBModel {
    NSString        *deliverId;
    NSString        *fullName;
    NSString        *mobile;
    NSString        *post;
    NSString        *divisionCode;
    NSString        *province;
    NSString        *city;
    NSString        *area;
    NSString        *addressDetail;
    NSString        *status;
}


//! 收货地址的地区ID
- (NSString *)division;

//! 完整的地址字符串
- (NSString *)fullAddress;

//! 是否为默认收货地址
- (BOOL)isDefault;

@property (nonatomic, copy)	NSString        *deliverId;
@property (nonatomic, copy)	NSString        *fullName;
@property (nonatomic, copy)	NSString        *mobile;
@property (nonatomic, copy)	NSString        *post;
@property (nonatomic, copy)	NSString        *divisionCode;
@property (nonatomic, copy)	NSString        *province;
@property (nonatomic, copy)	NSString        *city;
@property (nonatomic, copy)	NSString        *area;
@property (nonatomic, copy)	NSString        *addressDetail;
@property (nonatomic, copy)	NSString        *status;

@end
