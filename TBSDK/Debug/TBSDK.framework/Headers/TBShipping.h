//
//  TBShipping.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-30.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@class TBLocation;

//! TOP 中的实体，请参考 TOP 文档
@interface TBShipping : TBModel {
    NSDecimalNumber     *tid;
    NSString	*seller_nick;
    NSString	*buyer_nick;
    NSString	*delivery_start;
    NSString	*delivery_end;
    NSString	*out_sid;
    NSString	*item_title;
    
    NSString    *created;
    NSString    *modified;
    
    NSString	*receiver_name;
    NSUInteger	 receiver_phone;
    NSUInteger	 receiver_mobile;
    TBLocation	*location;
    
    NSString	*status;
    NSString	*type;
    NSString	*freight_payer;
    NSString	*seller_confirm;
    
    NSString	*company_name;
    
    NSString	*is_success;
}

@property (nonatomic, copy)	NSDecimalNumber	 *tid;
@property (nonatomic, copy)	NSString	*seller_nick;
@property (nonatomic, copy)	NSString	*buyer_nick;
@property (nonatomic, copy)	NSString	*delivery_start;
@property (nonatomic, copy)	NSString	*delivery_end;
@property (nonatomic, copy)	NSString	*out_sid;
@property (nonatomic, copy)	NSString	*item_title;

@property (nonatomic, copy) NSString    *created;
@property (nonatomic, copy) NSString    *modified;

@property (nonatomic, copy)	NSString	*receiver_name;
@property (nonatomic, assign)	NSUInteger	 receiver_phone;
@property (nonatomic, assign)	NSUInteger	 receiver_mobile;
@property (nonatomic, assign)	TBLocation	*location;

@property (nonatomic, copy)	NSString	*status;
@property (nonatomic, copy)	NSString	*type;
@property (nonatomic, copy)	NSString	*freight_payer;
@property (nonatomic, copy)	NSString	*seller_confirm;

@property (nonatomic, copy)	NSString	*company_name;

@property (nonatomic, copy)	NSString	*is_success;

@end
