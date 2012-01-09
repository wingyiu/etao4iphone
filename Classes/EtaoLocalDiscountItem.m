//
//  EtaoLocalDiscountItem.m
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalDiscountItem.h"


@implementation EtaoLocalDiscountItem

@synthesize itemID;
@synthesize itemTitle; //宝贝
@synthesize itemType;

@synthesize itemURL;
@synthesize itemImageURL;
//@synthesize itemInfo;
@synthesize itemRank; //宝贝平均评论分数

@synthesize itemDiscount; //宝贝折扣
@synthesize itemOriginalPrice;
@synthesize itemPresentPrice;
@synthesize itemComeFrom;    //商品来源

//@synthesize alipaySupported;
//@synthesize supportedService;

@synthesize shopName;    //商户名称
@synthesize shopDistance;
@synthesize shopAddress;
@synthesize shopTelephone;
//@synthesize shopInfo;

@synthesize locationLatitude;
@synthesize locationLongitude;

- (NSString *)title {
    return itemTitle;
}


- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@", shopName];
}
 


- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = [self.locationLatitude doubleValue];
    coordinate.longitude = [self.locationLongitude doubleValue];
    return coordinate;
}


@end
