//
//  EtaoGroupBuyMapView.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EtaoTuanAuctionDataSource.h"
#import "EtaoLocalPositonSessionDelegate.h"

#ifndef MAP_HEIGHT
#define MAP_HEIGHT 252
#endif

@interface EtaoGroupBuyMapViewController: UIViewController <MKMapViewDelegate, MKReverseGeocoderDelegate,EtaoTuanAuctionDataSourceDelegate>{
    
    MKMapView *_mapView;
    
    EtaoTuanAuctionDataSource<EtaoLocalPositonSessionDelegate>* _datasource;
    
    //获取城市名称 Session
    MKReverseGeocoder *_reverseGeocoder;
    //获取程序，重试的次数    
}


- (void) setHidden:(BOOL)hidden;

- (void)setMapCenter:(CLLocationCoordinate2D)gpsPositon;
- (void)upDateGps;
- (CLLocationCoordinate2D)getUserGPS;
- (NSString*)getUserPositionName;
- (NSString*)getUserCityName;


@property(nonatomic, retain) MKMapView *mapView;
@property(nonatomic, retain) EtaoTuanAuctionDataSource* datasource;
@property CLLocationCoordinate2D userGpsPosition;

@end
