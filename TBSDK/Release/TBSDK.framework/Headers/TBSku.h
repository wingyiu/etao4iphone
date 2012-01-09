//
//  TBSku.h
//  TBSDK
//
//  Created by Xu Jiwei on 10-7-6.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"

//! TOP 中的实体，请参考 TOP 文档
@interface TBSku : TBModel {
    NSDecimalNumber     *sku_id;
    NSString            *iid;
    NSString            *num_iid;
    NSString            *properties;
    NSUInteger           quantity;
    NSString            *price;
    NSString            *outer_id;
    NSString            *created;
    NSString            *modified;
    NSString            *status;
}

@property (nonatomic, copy)     NSDecimalNumber *sku_id;
@property (nonatomic, copy)     NSString        *iid;
@property (nonatomic, copy)     NSString        *num_iid;
@property (nonatomic, copy)     NSString        *properties;
@property (nonatomic, assign)	NSUInteger      quantity;
@property (nonatomic, copy)     NSString        *price;
@property (nonatomic, copy)     NSString        *outer_id;
@property (nonatomic, copy)     NSString        *created;
@property (nonatomic, copy)     NSString        *modified;
@property (nonatomic, copy)     NSString        *status;

@end
