//
//  TBJhsItem.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-19.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

//! 聚划算宝贝状态类型
typedef enum {
    TBJhsItemStatusUnknown,         //! 未知状态
    TBJhsItemStatusWillBegin,       //! 将要开始
    TBJhsItemStatusOnSale,          //! 正在出售
    TBJhsItemStatusWaitRelease,     //! 还有机会
    TBJhsItemStatusSoldOut,         //! 已经卖完
    TBJhsItemStatusEnded            //! 团购结束
} TBJhsItemStatus;


//! 聚划算宝贝信息
@interface TBJhsItem : TBModel {
    NSInteger               platform_id;
    NSInteger               category_id;
    NSInteger               child_category;
    NSInteger               parent_category;
    
    NSInteger               original_price;
    NSInteger               activity_price;
    NSString                *discount;
    NSString                *pay_postage;
    NSInteger               current_stock;
    BOOL                    exist_hold_stock;
    NSInteger               sold_count;
    NSString                *is_lock;
    
    NSString                *item_desc;
    NSString                *item_guarantee;
    NSDecimalNumber         *item_id;
    NSString                *item_status;
    NSString                *item_url;
    NSString                *long_name;
    NSString                *pic_url;
    NSString                *pic_url_from_ic;
    NSString                *pic_wide_url;
    NSDecimalNumber         *online_end_time;
    NSDecimalNumber         *online_start_time;
    
    NSInteger               seller_credit;
    NSUInteger              seller_id;
    NSString                *seller_nick;
    NSString                *shop_type;
    NSString                *short_name;
}

- (NSString *)fullWidePicUrl;
- (NSString *)fullPicUrl;
- (TBJhsItemStatus)itemStatus;
- (NSString *)itemStatusTitle;

@property (nonatomic, assign)   NSInteger               platform_id;
@property (nonatomic, assign)   NSInteger               category_id;
@property (nonatomic, assign)   NSInteger               child_category;
@property (nonatomic, assign)   NSInteger               parent_category;

@property (nonatomic, assign)   NSInteger               original_price;
@property (nonatomic, assign)   NSInteger               activity_price;
@property (nonatomic, copy)     NSString                *discount;
@property (nonatomic, copy)     NSString                *pay_postage;
@property (nonatomic, assign)   NSInteger               current_stock;
@property (nonatomic, assign)	BOOL                    exist_hold_stock;
@property (nonatomic, assign)	NSInteger               sold_count;
@property (nonatomic, copy)     NSString                *is_lock;

@property (nonatomic, copy)     NSString                *item_desc;
@property (nonatomic, copy)     NSString                *item_guarantee;
@property (nonatomic, copy)     NSDecimalNumber         *item_id;
@property (nonatomic, copy)     NSString                *item_status;
@property (nonatomic, copy)     NSString                *item_url;
@property (nonatomic, copy)     NSString                *long_name;
@property (nonatomic, copy)     NSString                *pic_url;
@property (nonatomic, copy)     NSString                *pic_url_from_ic;
@property (nonatomic, copy)     NSString                *pic_wide_url;
@property (nonatomic, copy)     NSDecimalNumber         *online_end_time;
@property (nonatomic, copy)     NSDecimalNumber         *online_start_time;

@property (nonatomic, assign)   NSInteger               seller_credit;
@property (nonatomic, assign)	NSUInteger              seller_id;
@property (nonatomic, copy)     NSString                *seller_nick;
@property (nonatomic, copy)     NSString                *shop_type;
@property (nonatomic, copy)     NSString                *short_name;

@end
