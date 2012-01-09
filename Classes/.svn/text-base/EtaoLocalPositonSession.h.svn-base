//
//  EtaoLocalPositonSession.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "EtaoLocalPositonSessionDelegate.h"

@interface EtaoLocalPositonSession: NSObject <CLLocationManagerDelegate>{

    CLLocationManager *_locationManager; 
    CLLocation *_userlocation;
    
    id<EtaoLocalPositonSessionDelegate> delegate;
}

- (void) getLocalPositon;

@property(nonatomic, retain) CLLocationManager *locationManager; 
@property(nonatomic, retain) CLLocation *userlocation;

@property BOOL isLocatedAlert;
@property BOOL isLocatedFailed;
@property BOOL isLocationAccessAllowed;

@property int distance;

@end
