//
//  TBTrade.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-25.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

#import "TBOrder.h"


//! TOP 中的实体，请参考 TOP 文档
@interface TBTrade : TBModel {

    NSString    *sid;
    NSString    *seller_nick;
    NSString    *buyer_nick;
    NSString    *title;
    NSString    *type;

    NSString    *created;
    
    NSString    *iid;
    NSString    *price;
    NSString    *pic_path;
    
    NSUInteger   num;
    NSDecimalNumber   *tid;
    
    NSString    *buyer_message;
    NSString    *shipping_type;
    
    NSString    *alipay_no;
    NSString    *payment;
    NSString    *discount_fee;
    NSString    *adjust_fee;
    
    NSString    *snapshot_url;
    NSString    *snapshot;
    
    NSString    *status;
    
    BOOL         seller_rate;
    BOOL         buyer_rate;
    BOOL         can_rate;
    
    NSString    *buyer_memo;
    NSString    *seller_memo;
    NSString    *trade_memo;
    
    NSString    *pay_time;
    NSString    *end_time;
    NSString    *modified;
    
    NSString    *buyer_obtain_point_fee;
    NSString    *point_fee;
    NSString    *real_point_fee;
    NSString    *total_fee;
    NSString    *post_fee;
    
    NSString    *buyer_alipay_no;
    
    NSString    *receiver_name;
    NSString    *receiver_state;
    NSString    *receiver_city;
    NSString    *receiver_district;
    NSString    *receiver_address;
    NSString    *receiver_zip;
    NSString    *receiver_mobile;
    NSString    *receiver_phone;
    NSString    *consign_time;
    NSString    *buyer_email;
    NSString    *commission_fee;
    
    NSString    *seller_alipay_no;
    NSString    *seller_mobile;
    NSString    *seller_phone;
    NSString    *seller_name;
    NSString    *seller_email;
    
    NSString    *avaiable_confirm_fee;
    NSString    *has_post_fee;
    NSString    *received_payment;
    
    NSString    *cod_fee;
    NSString    *cod_status;
    
    NSString    *timeout_action_time;
    
    BOOL         is_3D;
    
    NSArray     *orders;
    
    NSUInteger   buyer_flag;
    NSUInteger   seller_flag;
    
}

//! 交易状态
+ (NSString *)titleForStatus:(NSString *)status;

//! 交易中所有宝贝的数量
- (NSUInteger)totalGoodsCount;

//! 交易中需要买家评价的定单数量
- (NSUInteger)ordersNeedBuyerRateCount;

//! 交易中需要卖家评价的定单数量
- (NSUInteger)ordersNeedSellerRateCount;

//! 需要买家评价的定单列表
- (NSArray *)ordersNeedBuyerRate;

//! 需要卖家评价的定单列表
- (NSArray *)ordersNeedSellerRate;

//! 运费字符串
- (NSString *)shippingFeeWithFormat:(NSString *)fmt;

@property (nonatomic, copy) NSString    *sid;
@property (nonatomic, copy)	NSString    *seller_nick;
@property (nonatomic, copy)	NSString    *buyer_nick;
@property (nonatomic, copy)	NSString    *title;
@property (nonatomic, copy)	NSString    *type;

@property (nonatomic, copy)	NSString    *created;

@property (nonatomic, copy)	NSString    *iid;
@property (nonatomic, copy)	NSString    *price;
@property (nonatomic, copy)	NSString    *pic_path;

@property (nonatomic, assign)	NSUInteger   num;
@property (nonatomic, copy)	NSDecimalNumber   *tid;

@property (nonatomic, copy)	NSString    *buyer_message;
@property (nonatomic, copy)	NSString    *shipping_type;

@property (nonatomic, copy)	NSString    *alipay_no;
@property (nonatomic, copy)	NSString    *payment;
@property (nonatomic, copy)	NSString    *discount_fee;
@property (nonatomic, copy)	NSString    *adjust_fee;

@property (nonatomic, copy)	NSString    *snapshot_url;
@property (nonatomic, copy)	NSString    *snapshot;

@property (nonatomic, copy)	NSString    *status;

@property (nonatomic, assign)	BOOL         seller_rate;
@property (nonatomic, assign)	BOOL         buyer_rate;
@property (nonatomic, assign)   BOOL         can_rate;

@property (nonatomic, copy)	NSString    *buyer_memo;
@property (nonatomic, copy)	NSString    *seller_memo;
@property (nonatomic, copy)	NSString    *trade_memo;

@property (nonatomic, copy)	NSString    *pay_time;
@property (nonatomic, copy)	NSString    *end_time;
@property (nonatomic, copy)	NSString    *modified;

@property (nonatomic, copy)	NSString    *buyer_obtain_point_fee;
@property (nonatomic, copy)	NSString    *point_fee;
@property (nonatomic, copy)	NSString    *real_point_fee;
@property (nonatomic, copy)	NSString    *total_fee;
@property (nonatomic, copy)	NSString    *post_fee;

@property (nonatomic, copy)	NSString    *buyer_alipay_no;

@property (nonatomic, copy)	NSString    *receiver_name;
@property (nonatomic, copy)	NSString    *receiver_state;
@property (nonatomic, copy)	NSString    *receiver_city;
@property (nonatomic, copy)	NSString    *receiver_district;
@property (nonatomic, copy)	NSString    *receiver_address;
@property (nonatomic, copy)	NSString    *receiver_zip;
@property (nonatomic, copy)	NSString    *receiver_mobile;
@property (nonatomic, copy)	NSString    *receiver_phone;
@property (nonatomic, copy)	NSString    *consign_time;  //签收时间
@property (nonatomic, copy)	NSString    *buyer_email;
@property (nonatomic, copy)	NSString    *commission_fee;

@property (nonatomic, copy)	NSString    *seller_alipay_no;
@property (nonatomic, copy)	NSString    *seller_mobile;
@property (nonatomic, copy)	NSString    *seller_phone;
@property (nonatomic, copy)	NSString    *seller_name;
@property (nonatomic, copy)	NSString    *seller_email;

@property (nonatomic, copy)	NSString    *avaiable_confirm_fee;
@property (nonatomic, copy)	NSString    *has_post_fee;
@property (nonatomic, copy)	NSString    *received_payment;

@property (nonatomic, copy)	NSString    *cod_fee;
@property (nonatomic, copy)	NSString    *cod_status;

@property (nonatomic, copy)	NSString    *timeout_action_time;

@property (nonatomic, assign)	BOOL         is_3D;

@property (nonatomic, retain)	NSArray     *orders;

@property (nonatomic, assign)	NSUInteger   buyer_flag;
@property (nonatomic, assign)	NSUInteger   seller_flag;


@end
