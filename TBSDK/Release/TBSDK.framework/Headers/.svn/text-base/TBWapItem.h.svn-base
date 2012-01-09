//
//  TBWapItem.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-8-4.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBItem.h"
#import "TBWapPromotionInfo.h"


//! 无线搜索接口返回的宝贝信息
@interface TBWapItem : TBItem {
    //NSString *title;
    NSString *pic_path;
    //NSString *price;
    NSString *item_id;
    NSString *auctionURL;
    //NSString *nick;
    //NSString *type;
    NSString *quantity;
    //NSString *location;
    NSString *sold;
    NSString *ratesum;
    NSString *shipping;
    NSString *spuId;
    NSString *isCod;
    NSString *isprepay;
    NSString *isB2c;
    NSString *ordinaryPostFee;
    NSString *autoPost;
    NSString *userId;
    NSString *promotedService;
    NSString *auctionFlag;  
    NSString *fastPostFee;
    
    NSString *sellerLoc;
    
    // 限时打折
    NSString    *isInLimitPromotion;
    NSString    *priceWithRate;
    
    NSString    *promotionPrice;
    
    // 定向优惠
    TBWapPromotionInfo      *directionalPromotion;
}

//! 宝贝所在地字符串
- (NSString *)locationString;

//! 是否为限时折扣宝贝
- (BOOL)isLimitPromotionAuction;

//! 限时折扣的折扣率
- (float)limitPromotionRate;

//! 限时折扣的价格区间
- (NSString *)limitPromotionPriceRange;

//! 优惠后价格
- (NSString *)promotionPrice;

//@property (nonatomic, copy)	NSString *title;
@property (nonatomic, copy)	NSString *pic_path;
//@property (nonatomic, copy)	NSString *price;
@property (nonatomic, copy)	NSString *item_id;
@property (nonatomic, copy)	NSString *auctionURL;
//@property (nonatomic, copy)	NSString *nick;
//@property (nonatomic, copy)	NSString *type;
@property (nonatomic, copy)	NSString *quantity;
//@property (nonatomic, copy)	NSString *location;
@property (nonatomic, copy) NSString *sold;
@property (nonatomic, copy)	NSString *ratesum;
@property (nonatomic, copy)	NSString *shipping;
@property (nonatomic, copy)	NSString *spuId;
@property (nonatomic, copy)	NSString *isCod;
@property (nonatomic, copy)	NSString *isprepay;
@property (nonatomic, copy)	NSString *isB2c;
@property (nonatomic, copy)	NSString *ordinaryPostFee;
@property (nonatomic, copy)	NSString *autoPost;
@property (nonatomic, copy)	NSString *userId;
@property (nonatomic, copy)	NSString *promotedService;
@property (nonatomic, copy)	NSString *auctionFlag;
@property (nonatomic, copy) NSString *fastPostFee;
@property (nonatomic, copy) NSString *sellerLoc;

@property (nonatomic, copy) NSString *isInLimitPromotion;
@property (nonatomic, copy) NSString *priceWithRate;

@property (nonatomic, copy) NSString *promotionPrice;

@property (nonatomic, retain) TBWapPromotionInfo *directionalPromotion;

@end
