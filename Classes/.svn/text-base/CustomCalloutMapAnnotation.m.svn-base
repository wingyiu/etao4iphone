//
//  CustomCalloutMapAnnotation.m
//  netaogo
//
//  Created by iTeam on 11-6-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCalloutMapAnnotation.h"


@implementation CustomCalloutMapAnnotation

@synthesize coordinate,latitude,longitude,itemTitle,itemImageURL,itemDiscount,itemPresentPrice,shopName,shopAddress;



- (id)initWithLatitude:(CLLocationDegrees)nlatitude
		  andLongitude:(CLLocationDegrees)nlongitude {
	if (self = [super init]) {
		self.latitude = nlatitude;
		self.longitude = nlongitude;
		coordinate.latitude = nlatitude;
		coordinate.longitude = longitude;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinate1;
	coordinate1.latitude = self.latitude;
	coordinate1.longitude = self.longitude;
	return coordinate1;
}
 
- (void)dealloc { 
    [super dealloc];
}
@end
