//
//  EtaoLocalDiscountMapController.h
//  etao4iphone
//
//  Created by iTeam on 11-8-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EtaoLocalDiscountItem.h"
#import "ETaoUIViewController.h"
@interface EtaoLocalDiscountMapController : ETaoUIViewController <MKMapViewDelegate>{

	MKMapView *mapView;
}

@property(nonatomic,retain) MKMapView *mapView;

- (void) locate:(EtaoLocalDiscountItem*)item;

@end
