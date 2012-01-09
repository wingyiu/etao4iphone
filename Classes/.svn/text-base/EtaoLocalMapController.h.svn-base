//
//  EtaoLocalMapController.h
//  etao4iphone
//
//  Created by iTeam on 11-8-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomCalloutMapAnnotation.h" 
#import "TuanCalloutMapAnnotationView.h" 
#import "EtaoLocalListDataSource.h"
#import "EtaoLocalDiscountItem.h"
#import "EtaoLocalDiscountRequest.h"
#import "EtaoLocalMapFootView.h"
#import "EtaoLocalDiscountDetailController.h"
#import "EtaoDiscountDetailController.h"
#import "EtaoLocalListHeadDistanceView.h"
#import "EtaoUIViewWithBackgroundController.h"
#import "MapLoadingView.h"
#import "EtaoLocalClassifyView.h"

@interface EtaoLocalMapController : EtaoUIViewWithBackgroundController <UIGestureRecognizerDelegate,MKMapViewDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate> {
	MKMapView *mapView;
	 
	CLLocationManager *locationManager; 
	
	EtaoLocalDiscountItem *curselectAnnotation ;
	
	EtaoLocalListDataSource *discountDatas;
	
	CLLocation *userlocation ;  
	
	// 上一次查询的中心位置
	CLLocationCoordinate2D _lastSearchCoordinate ;  
	double _deltaLatitude ;
	double _deltaLongitude ; 
	
	BOOL locationAccessAllowed; 
	
	EtaoLocalMapFootView *_footView;
	
	EtaoLocalListHeadDistanceView *_head;
	
	EtaoLocalClassifyView *_categoryView;
	
	UIViewController *_parent ;
	
	NSString *_selectedType ; 
	
	MapLoadingView *_loading ;
	
	BOOL _isLoading ;
	
	BOOL _hidden ;
	
	int _s ;
	int _e ;
	
	
	
}
 
@property (nonatomic, retain) MKMapView *mapView; 
@property (nonatomic, retain) CLLocationManager *locationManager;  
@property (nonatomic, retain) EtaoLocalListDataSource *discountDatas;
@property (nonatomic, retain) CLLocation *userlocation ; 
@property (nonatomic, retain) EtaoLocalMapFootView *_footView;
@property (nonatomic,retain) EtaoLocalListHeadDistanceView *_head ;
@property (nonatomic,retain) NSString *_selectedType ;
@property (nonatomic,retain) MapLoadingView *_loading ;
@property (nonatomic,retain) EtaoLocalClassifyView *_categoryView;
@property CLLocationCoordinate2D _lastSearchCoordinate; 
@property BOOL locationAccessAllowed ;
@property double _deltaLatitude ;
@property double _deltaLongitude ; 
@property int _s ;
@property int _e ;
@property BOOL _isLoading ;
@property BOOL _hidden ;
@property (nonatomic,assign) EtaoLocalDiscountItem *curselectAnnotation ;
@property (nonatomic,retain) UIViewController *_parent ;

- (id)initWithdataSource:(EtaoLocalListDataSource*)datas ; 

- (NSString *)imageNameForAnnotaion:(id <MKAnnotation>)annotation ; 
- (void)MapPress:(UIGestureRecognizer*)gestureRecognizer ; 
- (void) setSelectedAnnotation:(id < MKAnnotation >)annotation ;  

// 请求数据
- (void) requestFinished:(EtaoLocalDiscountRequest *)sender ;
- (void) requestFailed:(EtaoLocalDiscountRequest *)sender;
 

- (void)FootButtonPress:(id)sender;
- (void)gotoDetail:(id)sender;

- (void) typeButtonClickOn:(NSString*)type ;
- (void) loadMoreFrom:(int)s TO:(int)e withType:(NSString*)type;

- (void) setHidden:(BOOL)hidden;

- (void) hidden;
@end
