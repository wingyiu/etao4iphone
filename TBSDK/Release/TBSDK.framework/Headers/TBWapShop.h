//
//  TBWapShop.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-10-19.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBShop.h"

//! 无线店铺搜索接口返回的店铺信息
@interface TBWapShop : TBShop {
    NSString            *sellerId;
    NSString            *picUrl;
    NSString            *isb;
    NSString            *location;
    NSString            *rateSum;
    NSString            *shopType;
    NSString            *bShopType;
    NSString            *uid;
    NSString            *pureKeyBiz;
}

//! 是否为商城店铺
- (BOOL)isMallShop;

@property (nonatomic, copy)	NSString            *sellerId;
@property (nonatomic, copy)	NSString            *picUrl;
@property (nonatomic, copy)	NSString            *isb;
@property (nonatomic, copy)	NSString            *location;
@property (nonatomic, copy)	NSString            *rateSum;
@property (nonatomic, copy)	NSString            *pureKeyBiz;
@property (nonatomic, copy)	NSString            *shopType;
@property (nonatomic, copy)	NSString            *bShopType;
@property (nonatomic, copy)	NSString            *uid;

@end
