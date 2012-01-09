//
//  TBShop.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-6-30.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

@class TBShopScore;

//! TOP 中的实体，请参考 TOP 文档
@interface TBShop : TBModel {
    NSDecimalNumber         *sid;
    NSDecimalNumber         *cid;
	NSString				*nick;
	NSString				*title;
	NSString				*desc;
	NSString				*bulletin;
	NSString				*pic_path;
	NSString				*created;
	NSString				*modified;
	NSDecimalNumber         *remain_count;
    
    NSUInteger              sellerGrade;
    NSString                *keyBiz;
    
    TBShopScore             *shop_score;
}

@property (nonatomic, copy) NSString *nick, *title, *desc, *bulletin, *pic_path, *created, *modified;
@property (nonatomic, copy) NSDecimalNumber *sid, *cid, *remain_count;
@property (nonatomic, retain) TBShopScore *shop_score;
@property (nonatomic, copy) NSString *keyBiz;
@property (nonatomic, assign) NSUInteger sellerGrade;

@end
