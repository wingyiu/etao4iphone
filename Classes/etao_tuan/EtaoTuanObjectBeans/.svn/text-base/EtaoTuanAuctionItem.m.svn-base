//
//  EtaoTuanAuctionItem.m
//  etao4iphone
//
//  Created by  on 11-11-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanAuctionItem.h"

@implementation EtaoTuanAuctionItem

@synthesize  oriPrice =_oriPrice;
@synthesize  price =_price;
@synthesize  sales =_sales;
@synthesize  webName =_webName;
@synthesize  rate =_rate;
@synthesize  title =_title;
@synthesize  merchantName =_merchantName;
@synthesize  merchantTel =_merchantTel;
@synthesize  merchantAddr =_merchantAddr;
@synthesize  latitude =_latitude;
@synthesize  longitude =_longitude;
@synthesize  extInfo =_extInfo;
@synthesize  hasLbs =_hasLbs;
@synthesize  wapLink =_wapLink;
@synthesize  image =_image;
@synthesize  link =_link;
@synthesize  nid =_nid;
@synthesize  type =_type;
@synthesize  startTime = _startTime;
@synthesize  endTime = _endTime;

@synthesize mode = _mode;

@synthesize coordinate;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        self.oriPrice = [aDecoder decodeObjectForKey:@"oriPrice"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.sales = [aDecoder decodeObjectForKey:@"sales"];
        self.webName = [aDecoder decodeObjectForKey:@"webName"];
        self.rate = [aDecoder decodeObjectForKey:@"rate"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.merchantTel = [aDecoder decodeObjectForKey:@"merchantTel"];
        self.merchantName = [aDecoder decodeObjectForKey:@"merchantName"];
        self.merchantAddr = [aDecoder decodeObjectForKey:@"merchantAddr"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.extInfo = [aDecoder decodeObjectForKey:@"extInfo"];
        self.hasLbs = [aDecoder decodeObjectForKey:@"hasLbs"];
        self.wapLink = [aDecoder decodeObjectForKey:@"wapLink"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.link = [aDecoder decodeObjectForKey:@"link"];
        self.nid = [aDecoder decodeObjectForKey:@"nid"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.startTime = [aDecoder decodeObjectForKey:@"startTime"];
        self.endTime = [aDecoder decodeObjectForKey:@"endTime"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_oriPrice forKey:@"oriPrice"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_sales forKey:@"sales"];
    [aCoder encodeObject:_webName forKey:@"webName"];
    [aCoder encodeObject:_rate forKey:@"rate"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_merchantTel forKey:@"merchantTel"];
    [aCoder encodeObject:_merchantName forKey:@"merchantName"];
    [aCoder encodeObject:_merchantAddr forKey:@"merchantAddr"];
    [aCoder encodeObject:_latitude forKey:@"latitude"];
    [aCoder encodeObject:_longitude forKey:@"longitude"];
    [aCoder encodeObject:_extInfo forKey:@"extInfo"];
    [aCoder encodeObject:_hasLbs forKey:@"hasLbs"];
    [aCoder encodeObject:_wapLink forKey:@"wapLink"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_link forKey:@"link"];
    [aCoder encodeObject:_nid forKey:@"nid"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_startTime forKey:@"startTime"];
    [aCoder encodeObject:_endTime forKey:@"endTime"];
}

- (void)dealloc
{
    [_oriPrice release];
    [_price release];
    [_rate release];
    [_sales release];
    [_webName release]; 
    [_merchantName release];
    [_merchantTel release];
    [_merchantAddr release];
    [_longitude release];
    [_latitude release];
    [_extInfo release];
    [_hasLbs release];
    [_image release]; 
    [_link release];
    [_title release];
    [_nid release];
    [_wapLink release];
    [_type release];
    [_startTime release];
    [_endTime release];
    
    [super dealloc];
}

- (NSString *)title {
    
    if (nil != _merchantName) {
        return _merchantName;
    }
    return _title;
}


- (NSString *)titleStr {
    return _title;
}


- (NSString *)subtitle {
    return nil;//[NSString stringWithFormat:@"%@", _merchantName];
}


- (CLLocationCoordinate2D)coordinate {
    coordinate.latitude = 0;
    
    if (nil != self.latitude) {
        coordinate.latitude = [self.latitude doubleValue];;
    }
   
    coordinate.longitude = 0;
    
    if (nil != self.longitude) {
        coordinate.longitude = [self.longitude doubleValue];
    }
        
    if(coordinate.latitude > coordinate.longitude){
        double tmp = coordinate.latitude;
        coordinate.latitude = coordinate.longitude;
        coordinate.longitude = tmp;
    }
    return coordinate;
}

- (int)key{
    return [self.nid hash];
}

@end
