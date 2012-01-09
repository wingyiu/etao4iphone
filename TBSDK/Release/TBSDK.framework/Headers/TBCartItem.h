//
//  TBCartItem.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-5-5.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@class TBWapItem;
@class TBUser;

//! 购物车中的一项
@interface TBCartItem : TBModel {
    TBWapItem           *item;
    TBUser              *seller;
    NSDictionary        *skuProps;
    
    NSString            *cartId;
    NSString            *outerId;
    NSString            *outerIdType;
    NSString            *quantity;
    NSString            *status;
    NSString            *stockCount;
    NSString            *unitPrice;
    NSDictionary        *skuDO;
}

- (float)itemPrice;
- (NSString *)itemPriceString;
- (NSString *)skuPropsString;

@property (nonatomic, retain)  TBWapItem           *item;
@property (nonatomic, retain)  TBUser              *seller;
@property (nonatomic, retain)  NSDictionary        *skuProps;

@property (nonatomic, retain)  NSString            *cartId;
@property (nonatomic, retain)  NSString            *outerId;
@property (nonatomic, retain)  NSString            *outerIdType;
@property (nonatomic, retain)  NSString            *quantity;
@property (nonatomic, retain)  NSString            *status;
@property (nonatomic, retain)  NSString            *stockCount;
@property (nonatomic, retain)  NSString            *unitPrice;
@property (nonatomic, retain)  NSDictionary        *skuDO;


@end
