//
//  EtaoLocalDiscountItem.h
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef enum {
    EtaoDiscountItemTypeAll = 0,
    EtaoDiscountItemTypeCatering = 1,
    EtaoDiscountItemTypeEntertainment = 2,
    EtaoDiscountItemTypeLiving = 3,
    EtaoDiscountItemTypeLeisure,
} EtaoDiscountItemType;


@interface EtaoLocalDiscountItem :TBModel <MKAnnotation>{
    
	
	NSString * itemTitle; //宝贝
	NSString * itemID;  //宝贝ID
    NSString * itemType;
    
    NSString * itemURL;    //宝贝链接
    NSString * itemImageURL; //宝贝图片链接
	//	NSString * itemInfo;
    NSString * itemRank; //宝贝平均评论分数
    
    NSString * itemDiscount; //宝贝折扣
    NSString * itemOriginalPrice;
    NSString * itemPresentPrice;
	NSString * itemComeFrom;
    
	//   NSNumber * alipaySupported;
	//   NSArray * supportedService;
    
	NSString * shopName;       //商户名称
	NSString * shopDistance;   //宝贝的距离和方位
    NSString * shopAddress;
    NSString * shopTelephone;
	//NSString * shopInfo;
	
	NSString * locationLatitude;
    NSString * locationLongitude;
	CLLocationCoordinate2D coordinate;
}


//@property (nonatomic, retain) TBLocationPoint * location;

@property (nonatomic, retain) NSString * itemID;
@property (nonatomic, retain) NSString * itemTitle;
@property (nonatomic, retain) NSString * itemType;

@property (nonatomic, retain) NSString * itemURL;
@property (nonatomic, retain) NSString * itemImageURL;

//@property (nonatomic, retain) NSString * itemInfo;
@property (nonatomic, retain) NSString * itemRank;


@property (nonatomic, retain) NSString * itemDiscount;
@property (nonatomic, retain) NSString * itemOriginalPrice;
@property (nonatomic, retain) NSString * itemPresentPrice;
@property (nonatomic, retain) NSString * itemComeFrom;

//@property (nonatomic, retain) NSNumber * alipaySupported;
//@property (nonatomic, copy) NSArray * supportedService;

@property (nonatomic, retain) NSString * shopName;
@property (nonatomic, retain) NSString * shopDistance;
@property (nonatomic, retain) NSString * shopAddress;
@property (nonatomic, retain) NSString * shopTelephone;
//@property (nonatomic, retain) NSString * shopInfo;

@property (nonatomic, retain) NSString * locationLatitude;
@property (nonatomic, retain) NSString * locationLongitude;


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
 
@end
