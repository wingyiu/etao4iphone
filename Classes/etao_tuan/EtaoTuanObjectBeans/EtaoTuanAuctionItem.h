//
//  EtaoTuanAuctionItem.h
//  etao4iphone
//
//  Created by  on 11-11-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>


@interface EtaoTuanAuctionItem : ETaoModel <MKAnnotation>{     
    
    
    NSString * _image ; 
    NSString * _link ;
    NSString * _oriPrice;
    NSString * _price;
    NSString * _rate;
    NSString * _sales;
    NSString * _webName;
    NSString * _title ;  
    NSString * _merchantName;
    NSString * _merchantTel;
    NSString * _merchantAddr;
    NSString * _longitude;
    NSString * _latitude;
    NSString * _hasLbs;
    NSString * _extInfo;
    NSString * _wapLink;
    NSString * _nid;
    NSString * _type;
    NSString * _startTime;
    NSString * _endTime;
    
    NSString * _mode;  //大小图切换
}

@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *wapLink;
@property (nonatomic, copy) NSString *oriPrice;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *sales;
@property (nonatomic, copy) NSString *webName;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSString *merchantTel;
@property (nonatomic, copy) NSString *merchantAddr;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *hasLbs;
@property (nonatomic, copy) NSString *extInfo;
@property (nonatomic, copy) NSString *title ; 
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *nid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString* mode;

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

- (NSString *)titleStr;

- (int)key;

@end
