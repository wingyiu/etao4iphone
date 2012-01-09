//
//  EtaoLocalPositonSession.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalPositonSession.h"

@implementation EtaoLocalPositonSession

@synthesize locationManager = _locationManager;
@synthesize userlocation = _userlocation;

@synthesize isLocatedAlert;
@synthesize isLocatedFailed;
@synthesize isLocationAccessAllowed;
@synthesize distance;


- (void)initPosition{
    
    NSString *reqSysVer = @"4.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending); 
 	
//	[_listhead setText:@"正在定位.."]; 
//	[_maphead setText:@"正在定位..."];
    
	// Create location manager with filters set for battery efficiency.
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.delegate = self;
	_locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
	
    
	if (osVersionSupported) { 
		self.isLocationAccessAllowed = [CLLocationManager locationServicesEnabled] ; 
	}
	else {
		self.isLocationAccessAllowed = _locationManager.locationServicesEnabled;
	}
}


- (void)getLocalPositon {
    
    if (nil == _locationManager) {
        [self initPosition];
    }
    
    if (_locationManager != nil) {
        [_locationManager startUpdatingLocation]; 
    }   
}


- (void) sayOpenLocationServices {
 	if ( !self.isLocatedAlert) {
        [[ETaoNetWorkAlert alert]showLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
	[self sayOpenLocationServices];
//	[_listhead setText:@"定位失败"]; 
//	[_maphead  setText:@"定位失败"];
	
    self.isLocatedFailed = YES; 
	[_locationManager stopUpdatingLocation];
	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:30.0];

	[delegate PositonSessionRequestDidFailed:nil];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    
	[_locationManager stopUpdatingLocation]; 
    //	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:3.0];
	if (!isLocationAccessAllowed) {
		return;
	} 
	if (_userlocation != nil) {
		return;
	}
    
	
	//MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1000, 1000);
	self.userlocation = newLocation; 
	self.isLocatedFailed = NO; 
	MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(_userlocation.coordinate, self.distance, self.distance);
//	[_mapView setRegion:userLoc animated:NO]; 
//	self._lastSearchCoordinate =  _mapView.region.center;
//	if (!self._isLocated) {
//		self._isLocated = YES;
//		[self typeButtonClickOn:self._selectedType];
//	}  
    [delegate PositonSessionRequestDidFinish:nil];
}


//- (void) sayOpenLocationServices {
// 	if ( !self._LocatedAlert)
// 	{
//        [[ETaoNetWorkAlert alert]showLocation];
//    }
//}
//
//
//- (void)willPresentAlertView:(UIAlertView *)alertView{
//    self._LocatedAlert = YES; 
//}
//
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    self._LocatedAlert = NO; 
//}


- (void) dealloc {
    
    [_locationManager release];
    [_userlocation release];
    
    [super dealloc];
}

@end
