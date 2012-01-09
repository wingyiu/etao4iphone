//
//  TBItemPromotionBase.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-21.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@class TBItem;

//! 优惠信息的基类，如果需要添加新优惠类型，需要继承此类
@interface TBItemPromotionBase : TBModel {
    TBItem              *item;
}

//! 是否有这个优惠
- (BOOL)hasPromotion;

//! 使用这个优惠后的价格区间
- (NSArray *)priceRange;

//! 使用这个优惠后的价格区间字符串，使用 ~ 连接
- (NSString *)priceRangeString;

//! 创建交易时需要传递给服务端的优惠ID
- (NSString *)promotionId;

//! 使用此优惠时限制购买的数量，为 0 则表示不限制
- (int)limitBuyCount;

//! 使用此优惠时是否卖家包邮
- (BOOL)isSellerPayPostage;

@property (nonatomic, assign) TBItem *item;

@end
