//
//  TBItemLimitPromotion.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-21.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBItemPromotionBase.h"

//! 限时折扣优惠
@interface TBItemLimitPromotion : TBItemPromotionBase {
    NSString            *idValue;
    NSString            *limitQantity;
    NSString            *lpc;
    NSString            *limitPromotionPrice;
    NSString            *remainingTime;
    NSString            *isInlimitPromotion;
}

//! 优惠ID，创建交易时要用到
@property (nonatomic, copy)		NSString		*idValue;

//! 限制购买的数量
@property (nonatomic, copy)		NSString		*limitQantity;

//! 同 limitQantity
@property (nonatomic, copy)		NSString		*lpc;

//! 限时折扣的价格
@property (nonatomic, copy)		NSString		*limitPromotionPrice;

//! 剩余时间
@property (nonatomic, copy)		NSString		*remainingTime;

//! 是否处于限时折扣状态
@property (nonatomic, copy)		NSString		*isInlimitPromotion;

@end
