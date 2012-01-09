//
//  TBItemDirectionalPromotion.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-21.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBItemPromotionBase.h"

//! 定向优惠信息
@interface TBItemDirectionalPromotion : TBItemPromotionBase {
    NSString            *promId;
    NSString            *policyId;
    NSString            *promPrice;
    NSString            *attributes;
    
    NSMutableDictionary *attributesDict;
}

//! 优惠ID
@property (nonatomic, copy)		NSString		*promId;

//! 策略ID，创建交易时要用到这个ID
@property (nonatomic, copy)		NSString		*policyId;

//! 优惠后的价格，如果优惠后价格是区间，则这个属性为为空
@property (nonatomic, copy)		NSString		*promPrice;

//! 优惠的属性，如果一个宝贝有Sku并且优惠价格不一样，则这个属性会包含 price_range 用来表示价格区间
@property (nonatomic, copy)     NSString        *attributes;

@end
