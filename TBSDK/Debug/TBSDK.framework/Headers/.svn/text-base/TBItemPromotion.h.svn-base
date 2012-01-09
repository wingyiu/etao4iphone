//
//  TBItemPromotion.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-12-9.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@class TBItem;

#import "TBItemPromotionBase.h"
#import "TBItemLimitPromotion.h"
#import "TBItemDirectionalPromotion.h"
#import "TBItemManjiusongPromotion.h"
#import "TBItemJhsPromotion.h"

//! 宝贝优惠信息
@interface TBItemPromotion : TBModel {
    TBItem                      *item;
    
    TBItemLimitPromotion        *limit_prom;
    TBItemDirectionalPromotion  *fix_prom;
    NSArray                     *mjs_prom;
    TBItemJhsPromotion          *jhs_prom;
}

/*! 是否有任何优惠 */
- (BOOL)hasPromotion;

/*! 是否有价格的优惠，包括聚划算、限时折扣、定向优惠 */
- (BOOL)hasPricePromotion;

/*! 返回优惠ID，限时折扣和定向优惠有优惠ID */
- (NSString *)promotionId;

/*!
 获取宝贝的优惠价格区间
 @return 价格区间数组，如果只有一个元素，说明价格只有一种
 */
- (NSArray *)priceRange;

/*! 获取使用 ~ 连接的价格区间 */
- (NSString *)priceRangeString;

/*! 是否为卖家包邮 */
- (BOOL)isSellerPayPostage;

/*! 限制购买数量 */
- (int)limitBuyCount;

/*! 返回生效的价格优惠对象 */
- (TBItemPromotionBase *)effectedPricePromotion;

/*! 是否有限时折扣优惠 */
- (BOOL)hasLimitPromotion;

/*! 是否有定向优惠 */
- (BOOL)hasDirectionalPromotion;

/*! 是否有满就送优惠 */
- (BOOL)hasManjiusongPromotion;

/*! 是否是聚划算宝贝 */
- (BOOL)hasJuhuasuanPromotion;

@property (nonatomic, assign) TBItem        *item;
@property (nonatomic, retain) TBItemLimitPromotion  *limit_prom;
@property (nonatomic, retain) TBItemDirectionalPromotion  *fix_prom;
@property (nonatomic, retain) NSArray       *mjs_prom;
@property (nonatomic, retain) TBItemJhsPromotion *jhs_prom;

@end
