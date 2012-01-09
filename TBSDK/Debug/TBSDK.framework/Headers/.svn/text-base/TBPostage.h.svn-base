//
//  TBPostage.h
//  TBSDK
//
//  Created by Nowa on 10-6-30.
//  Copyright 2010 nowa.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import	"TBModel.h"

@class TBItem;
@class TBPostageMode;


//! TOP 中的实体，请参考 TOP 文档
@interface TBPostage : TBModel {
	NSString			*postage_id;
	NSString			*name;
	NSString			*memo;
	NSString			*created;
	NSString			*modified;
	NSString			*post_price;
	NSString			*post_increase;
	NSString			*express_price;
	NSString			*express_increase;
	NSString			*ems_price;
	NSString			*ems_increase;
	
	NSArray             *postage_modes;
}


//! 获取对应宝贝的运费信息列表
+ (NSArray *)postageModesForAuction:(TBItem *)auction;

//! 获取对应地区的运费信息
- (NSArray *)postageModesForDivision:(NSString *)divisionCode;

@property (nonatomic, copy) NSString *name, *memo, *created, *modified, *post_price, *post_increase;
@property (nonatomic, copy) NSString *express_price, *express_increase, *ems_price, *ems_increase;
@property (nonatomic, retain) NSArray *postage_modes;

@end
