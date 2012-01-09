//
//  TBItem.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-10.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"
#import "TBLocation.h"
#import "TBPostage.h"
#import "TBPropList.h"
#import "TBItemPromotion.h"
#import "TBSku.h"
#import "TBUser.h"
#import "TBAuctionDetailItem.h"

//! TOP 中的实体，请参考 TOP 文档
@interface TBItem : TBModel {
    NSString    *iid;
    NSString    *detail_url;
    NSDecimalNumber    *num_iid;
    NSString    *title;
    NSString    *nick;
    NSString    *type;
    NSUInteger   cid;
    NSString    *seller_cids;
    NSString    *props;
    NSString    *input_pids;
    NSString    *input_str;
    NSString    *desc;
    NSString    *pic_url;
    NSUInteger   num;
    NSUInteger   valid_thru;
    NSString    *list_time;
    NSString    *delist_time;
    NSString    *stuff_status;

    TBLocation  *location;
    
    NSString    *price;
    NSString    *post_fee;
    NSString    *express_fee;
    NSString    *ems_fee;
    BOOL         has_discount;
    NSString    *freight_payer;
    BOOL         has_invoice;
    BOOL         has_warranty;
    BOOL         has_showcase;
    
    NSString    *modified;
    NSString    *increment;
    BOOL         auto_repost;
    NSString    *approve_status;
    NSUInteger   postage_id;
    NSUInteger   product_id;
    NSUInteger   auction_point;
    NSString    *property_alias;
    
    NSArray     *item_imgs;
    NSArray     *prop_imgs;
    NSArray     *skus;
    
    NSString    *outer_id;
    
    BOOL         is_virtual;
    BOOL         is_taobao;
    BOOL         is_ex;
    BOOL         is_timing;
    
    NSArray     *videos;
    
    NSString    *is_3D;
    NSUInteger   score;
    NSUInteger   volume;
    BOOL         one_station;
    
    NSString    *second_kill;
    NSString    *auto_fill;
    NSString    *props_name;
    
    TBPostage   *postage;
    
    NSString        *promoted_service;
    
    NSString        *ssid;
    
    NSDictionary    *propNamesMap;
    NSMutableArray  *skuPropsList;
    TBItemPromotion *itemPromotion;
    TBSku           *selectedSku;
    
    TBUser          *sellerInfo;
    
    NSDictionary    *extraProperties;
    TBAuctionDetailItem     *auctionMoreDetail;
}

//! 获取sku的个数
- (int)skusCount;

//! 获取对应地区的运费信息列表
- (NSArray *)postageModesForDivision:(NSString *)divisionCode;

//! 获取宝贝属性的map
- (NSDictionary *)propValuesMap;

//! 获取宝贝所有sku可以选择的属性列表
- (NSArray *)skuPropsList;

//! 宝贝状态标题
- (NSString *)stuffStatusTitle;

//! 宝贝的价格区间
- (NSArray *)priceRange;

//! 根据 selectedSku 的信息获取价格区间
- (NSArray *)priceRangeWithSku;

//! 价格区间字符串
- (NSString *)priceRangeString;

//! 宝贝链接，供桌面浏览器使用
- (NSString *)itemLinkForWeb;

//! 宝贝链接，供移动设备使用
- (NSString *)itemLinkForWap;

//! 判断是否为票务凭证或者二维码宝贝
- (BOOL)isTicketCodeAuction;

//! 获取淘客相关的参数
- (NSString *)taokeParams;


@property (nonatomic, copy)		NSString		*iid;
@property (nonatomic, copy)		NSString		*detail_url;
@property (nonatomic, copy)		NSDecimalNumber	*num_iid;
@property (nonatomic, copy)		NSString		*title;
@property (nonatomic, copy)		NSString		*nick;
@property (nonatomic, copy)		NSString		*type;
@property (nonatomic, assign)	NSUInteger		cid;
@property (nonatomic, copy)		NSString		*seller_cids;
@property (nonatomic, copy)		NSString		*props;
@property (nonatomic, copy)		NSString		*input_pids;
@property (nonatomic, copy)		NSString		*input_str;
@property (nonatomic, copy)		NSString		*desc;
@property (nonatomic, copy)		NSString		*pic_url;
@property (nonatomic, assign)	NSUInteger		num;
@property (nonatomic, assign)	NSUInteger		valid_thru;
@property (nonatomic, copy)		NSString		*list_time;
@property (nonatomic, copy)		NSString		*delist_time;
@property (nonatomic, copy)		NSString		*stuff_status;

@property (nonatomic, retain)	TBLocation		*location;

@property (nonatomic, copy)		NSString		*price;
@property (nonatomic, copy)		NSString		*post_fee;
@property (nonatomic, copy)		NSString		*express_fee;
@property (nonatomic, copy)		NSString		*ems_fee;
@property (nonatomic, assign)	BOOL			has_discount;
@property (nonatomic, copy)		NSString		*freight_payer;
@property (nonatomic, assign)	BOOL			has_invoice;
@property (nonatomic, assign)	BOOL			has_warranty;
@property (nonatomic, assign)	BOOL			has_showcase;

@property (nonatomic, copy)		NSString		*modified;
@property (nonatomic, copy)		NSString		*increment;
@property (nonatomic, assign)	BOOL			auto_repost;
@property (nonatomic, copy)		NSString		*approve_status;
@property (nonatomic, assign)	NSUInteger		postage_id;
@property (nonatomic, assign)	NSUInteger		product_id;
@property (nonatomic, assign)	NSUInteger		auction_point;
@property (nonatomic, copy)		NSString		*property_alias;

@property (nonatomic, copy)		NSArray			*item_imgs;
@property (nonatomic, copy)		NSArray			*prop_imgs;
@property (nonatomic, copy)		NSArray			*skus;

@property (nonatomic, copy)		NSString		*outer_id;

@property (nonatomic, assign)	BOOL			is_virtual;
@property (nonatomic, assign)	BOOL			is_taobao;
@property (nonatomic, assign)	BOOL			is_ex;
@property (nonatomic, assign)	BOOL			is_timing;

@property (nonatomic, copy)		NSArray			*videos;

@property (nonatomic, copy)		NSString		*is_3D;
@property (nonatomic, assign)	NSUInteger		score;
@property (nonatomic, assign)	NSUInteger		volume;
@property (nonatomic, assign)	BOOL			one_station;

@property (nonatomic, copy)		NSString		*second_kill;
@property (nonatomic, copy)		NSString		*auto_fill;
@property (nonatomic, copy)		NSString		*props_name;

@property (nonatomic, retain)	TBPostage		*postage;

@property (nonatomic, copy)		NSString		*promoted_service;

//! 统计跟踪用的ssid
@property (nonatomic, copy)		NSString		*ssid;

//! 宝贝对应的优惠信息
@property (nonatomic, retain)   TBItemPromotion *itemPromotion;

//! 这个宝贝当前选中的Sku，在购买时计算价格要用到
@property (nonatomic, assign)   TBSku           *selectedSku;

//! 宝贝的卖家信息
@property (nonatomic, retain)   TBUser          *sellerInfo;

//! 宝贝的额外信息，例如淘客的参数
@property (nonatomic, retain)   NSDictionary    *extraProperties;

@property (nonatomic, retain)   TBAuctionDetailItem     *auctionMoreDetail;

@end
