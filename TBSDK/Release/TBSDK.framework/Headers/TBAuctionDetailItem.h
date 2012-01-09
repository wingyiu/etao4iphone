//
//  TBAuctionDetailItem.h
//  taobao4iphone
//
//  Created by chenyan on 11-10-26.
//  Copyright (c) 2011年 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBModel.h"

@class TBUser;
@class TBItemPurchaseRuleItem;
@class TBAuctionDeliveryItem;
@class TBAuctionTagGroup;

//! 从mtop.wdetail.getItemDetail 这个接口获取到的宝贝属性具体如下:
 
@interface TBAuctionDetailItem : TBModel {
    TBItemPurchaseRuleItem          *purchaseRule;
    TBAuctionTagGroup               *itemTags;
    TBAuctionDeliveryItem           *delivery;
    TBUser                          *user;
    NSString                        *itemNumId;
    NSString                        *totalSoldQuantity;
}

//! purchaseRule: 购买规则（是否允许购买，是否允许添加到购物车），
@property (nonatomic, retain) TBItemPurchaseRuleItem          *purchaseRule;

//! itemTags: 宝贝的一些标志位，比如是否虚拟，直充，商超，秒杀等;
@property (nonatomic, retain) TBAuctionTagGroup               *itemTags;

//! delivery; 如果用户已经登陆会根据用户的默认收货地址来返回这个宝贝的运费信息，如果没有登陆，则返回到全国的运费信息
@property (nonatomic, retain) TBAuctionDeliveryItem           *delivery;

//! user: 该宝贝的卖家信息
@property (nonatomic, retain) TBUser                          *user;

//! itemNumId: 宝贝id
@property (nonatomic, retain) NSString                        *itemNumId;

//! 销量,商城(B卖家)为总销量，集市(C卖家)为30天内销售量
@property (nonatomic, retain) NSString                        *totalSoldQuantity;

@end
