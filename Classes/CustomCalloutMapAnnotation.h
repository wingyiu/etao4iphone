//
//  CustomCalloutMapAnnotation.h
//  netaogo
//
//  Created by iTeam on 11-6-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface CustomCalloutMapAnnotation : NSObject <MKAnnotation> {
	NSString * itemTitle;    
    NSString * itemImageURL; 
    NSString * itemDiscount; //宝贝折扣 
    NSString * itemPresentPrice;
	NSString * shopName;       //商户名称
    NSString * shopAddress;  
    
	CLLocationDegrees latitude;
	CLLocationDegrees longitude;
	
	CLLocationCoordinate2D coordinate;
}

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;

@property (nonatomic, retain) NSString * itemTitle;
@property (nonatomic, retain) NSString * itemImageURL;
@property (nonatomic, retain) NSString * itemDiscount;
@property (nonatomic, retain) NSString * itemPresentPrice;
@property (nonatomic, retain) NSString * shopName;
@property (nonatomic, retain) NSString * shopAddress;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
 

@end
