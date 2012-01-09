//
//  EtaoHomeTuanView.h
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@interface EtaoHomeTuanView : UIView <MKReverseGeocoderDelegate,CLLocationManagerDelegate,MKMapViewDelegate>{
	
	CLLocationManager *_locationManager ;  
	CLLocation *_userLocation;
	MKReverseGeocoder *_reverseGeocoder;
	id delegate ;
}
@property (nonatomic, assign) id delegate; 
@property (nonatomic, assign) SEL typeButtonClickOnSelector; 

@property (nonatomic,retain) CLLocationManager *_locationManager ;
@property (nonatomic,retain) CLLocation *_userLocation;

@property (nonatomic, retain) MKMapView *_mapView; 
@property BOOL _mapViewLocated; 
@property (nonatomic,retain) MKReverseGeocoder *_reverseGeocoder;
@property int _retry;
@end
