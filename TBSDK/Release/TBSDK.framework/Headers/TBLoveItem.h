//
//  TBLoveItem.h
//  taobao4iphone
//
//  Created by chenyan on 11-10-13.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBModel.h"


@interface TBLoveItem : TBModel {
    NSString        *picUrl;
    NSString        *operateType;
    NSString        *operateTime;
    NSString        *publishTime;
    NSString        *title;
    NSString        *price;
    NSString        *sellerNick;
    NSString        *buyerNick;

    NSDecimalNumber        *itemId;
    NSDecimalNumber        *buyerId;
    NSDecimalNumber        *sellerId;

    BOOL            isShared;
    BOOL            hasComments;

    NSInteger       anoymous;
    NSInteger       buyerStar;

    NSInteger       sellerStar;
    NSInteger       picHeight;
    NSInteger       picWidth;
    NSInteger       commentsNum;

}

@property (nonatomic, retain) NSString *picUrl;
@property (nonatomic, retain) NSString *operateType;
@property (nonatomic, retain) NSString *operateTime;
@property (nonatomic, retain) NSString *publishTime;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *sellerNick;
@property (nonatomic, retain) NSString *buyerNick;

@property (nonatomic, retain) NSDecimalNumber *itemId;
@property (nonatomic, retain) NSDecimalNumber *buyerId;
@property (nonatomic, retain) NSDecimalNumber *sellerId;

@property (nonatomic, assign) NSInteger sellerStar;
@property (nonatomic, assign) NSInteger picHeight;
@property (nonatomic, assign) NSInteger picWidth;
@property (nonatomic, assign) NSInteger commentsNum;
@property (nonatomic, assign) NSInteger anoymous;
@property (nonatomic, assign) NSInteger buyerStar;

@property (nonatomic, assign) BOOL      isShared;
@property (nonatomic, assign) BOOL      hasComments;

@end
