//
//  TBWapPromotionInfo.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-11-24.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

/*!
 无线优惠信息
 @deprecated    已过期，使用 TBDirectionalPromotion
 */
@interface TBWapPromotionInfo : TBModel {
    NSString            *promId;
    NSString            *policyId;
    NSString            *attributes;
    NSString            *promPrice;
    
    NSMutableDictionary *attributesDict;
}

//! 价格区间字符串
- (NSString *)priceRange;

//! 优惠价
- (float)promotionPrice;

//! 价格区间中低的价格
- (NSString *)lowerPriceOfRange;

@property (nonatomic, copy)	NSString            *promId;
@property (nonatomic, copy)	NSString            *policyId;
@property (nonatomic, copy)	NSString            *attributes;
@property (nonatomic, copy)	NSString            *promPrice;

@end
