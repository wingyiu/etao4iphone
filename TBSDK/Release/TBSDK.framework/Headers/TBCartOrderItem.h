//
//  TBCartOrderItem.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-5-13.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


@class TBUser;
@class TBCartOrderPostMode;

@interface TBCartOrderItem : TBModel {
    NSArray             *items;
    
    TBUser              *seller;
    NSArray             *postModes;
    
    NSString            *freePostFee;
    NSString            *totalFee;
    NSString            *realAllTotalFee;
    NSString            *saleWinSeq;
    NSString            *discountFee;
    NSString            *sellerPostFee;
    NSString            *postMode;
    
    NSString            *selectedOrderPostMode;
}

- (float)totalFeeWithPost;
- (float)totalPostFee;
- (BOOL)isFreeShipping;

- (TBCartOrderPostMode *)selectedPostMode;
- (NSString *)selectedPostModeString;

@property (nonatomic, retain)  NSArray             *items;
@property (nonatomic, retain)  NSArray             *postModes;
@property (nonatomic, retain)  TBUser              *seller;

@property (nonatomic, retain)  NSString            *freePostFee;
@property (nonatomic, retain)  NSString            *totalFee;
@property (nonatomic, retain)  NSString            *realAllTotalFee;
@property (nonatomic, retain)  NSString            *saleWinSeq;
@property (nonatomic, retain)  NSString            *discountFee;
@property (nonatomic, retain)  NSString            *sellerPostFee;
@property (nonatomic, retain)  NSString            *postMode;

@property (nonatomic, retain)  NSString            *selectedOrderPostMode;

@end
