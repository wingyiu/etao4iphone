//
//  TBOrder.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-25.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

//! TOP 中的实体，请参考 TOP 文档
@interface TBOrder : TBModel {
    NSDecimalNumber *num_iid;
    NSString    *iid;
    NSString    *sku_id;
    NSString    *sku_properties_name;
    NSString    *item_meal_name;
    
    NSUInteger   num;
    
    NSString    *title;
    NSString    *price;
    NSString    *pic_path;
    NSString    *seller_nick;
    NSString    *buyer_nick;
    NSString    *type;
    
    NSString    *created;
    
    NSString    *refund_status;
    NSDecimalNumber    *oid;
    NSString    *outer_iid;
    NSString    *outer_sku_id;
    
    NSString    *total_fee;
    NSString    *payment;
    NSString    *discount_fee;
    NSString    *adjust_fee;
    
    NSString    *status;
    NSString    *snapshot_url;
    NSString    *snapshot;
    
    NSString    *timeout_action_time;
    
    BOOL        buyer_rate;
    BOOL        seller_rate;
    
    NSUInteger   refund_id;
    
    NSString    *seller_type;
    NSString    *modified;
}

//! 买家是否已评价
- (BOOL)buyerRated;

//! 卖家是否已评价
- (BOOL)sellerRated;

@property (nonatomic, copy) NSDecimalNumber *num_iid;

@property (nonatomic, copy)	NSString    *iid;
@property (nonatomic, copy)	NSString    *sku_id;
@property (nonatomic, copy)	NSString    *sku_properties_name;
@property (nonatomic, copy)	NSString    *item_meal_name;

@property (nonatomic, assign)	NSUInteger   num;

@property (nonatomic, copy)	NSString    *title;
@property (nonatomic, copy)	NSString    *price;
@property (nonatomic, copy)	NSString    *pic_path;
@property (nonatomic, copy)	NSString    *seller_nick;
@property (nonatomic, copy)	NSString    *buyer_nick;
@property (nonatomic, copy)	NSString    *type;

@property (nonatomic, copy)	NSString    *created;

@property (nonatomic, copy)	NSString    *refund_status;
@property (nonatomic, copy)	NSDecimalNumber    *oid;
@property (nonatomic, copy)	NSString    *outer_iid;
@property (nonatomic, copy)	NSString    *outer_sku_id;

@property (nonatomic, copy)	NSString    *total_fee;
@property (nonatomic, copy)	NSString    *payment;
@property (nonatomic, copy)	NSString    *discount_fee;
@property (nonatomic, copy)	NSString    *adjust_fee;

@property (nonatomic, copy)	NSString    *status;
@property (nonatomic, copy)	NSString    *snapshot_url;
@property (nonatomic, copy)	NSString    *snapshot;

@property (nonatomic, copy)	NSString    *timeout_action_time;

@property (nonatomic, assign)	BOOL    buyer_rate;
@property (nonatomic, assign)	BOOL    seller_rate;

@property (nonatomic, assign)	NSUInteger   refund_id;

@property (nonatomic, copy)	NSString    *seller_type;
@property (nonatomic, copy)	NSString    *modified;

@end
