//
//  TBAuctionDeliveryItem.h
//  TBSDK
//
//  Created by chenyan on 11-10-26.
//  Copyright (c) 2011年 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBModel.h"

//! 宝贝运费属性：

@interface TBAuctionDeliveryItem : TBModel {
    NSString    *deliveryFeeType;
    NSString    *destination;
    NSString    *title;
    NSArray     *deliveryFees;
}

//! deliveryFeeType: 是否需要运费，哪方负责运费，0-虚拟商品不需要运费     1－买家承担运费    2-卖家承担运费
@property (nonatomic, retain) NSString  *deliveryFeeType;

//! destination: 运送目的地，如果用户登陆，则为用户的默认收货地址的省份，如果没有登陆，则为全国
@property (nonatomic, retain) NSString  *destination;

//!  title: 运费类型标题，对应不同deliveryFeeType为固定这符串，deliveryFeeType=0 虚拟商品不需运费 deliveryFeeType=1 买家承担运费  deliveryFeeType=2 卖家承担运费 
@property (nonatomic, retain) NSString  *title;

//!  deliveryFees: 投递方式及费用，如"平邮：5.00元", "快递：4.00元",EMS：6.00元
@property (nonatomic, retain) NSArray   *deliveryFees;

- (NSString *)deliveryFeesString;

@end
