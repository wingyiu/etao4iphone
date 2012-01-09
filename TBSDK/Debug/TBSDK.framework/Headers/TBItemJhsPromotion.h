//
//  TBItemJhsPromotion.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-21.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBItemPromotionBase.h"
#import "TBJhsItem.h"


//! 聚划算优惠信息
@interface TBItemJhsPromotion : TBItemPromotionBase {
    NSString            *jhsKey;
    TBJhsItem           *jhsItem;
}

//! 聚划算的验证key
@property (nonatomic, copy) NSString *jhsKey;

@property (nonatomic, retain) TBJhsItem *jhsItem;

@end
