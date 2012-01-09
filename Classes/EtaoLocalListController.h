//
//  EtaoLocalListController.h
//  etao4iphone
//
//  Created by iTeam on 11-8-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "EtaoLocalListDataSource.h"
#import "HttpRequest.h"
#import "ASIHTTPRequest.h"
#import "EtaoLocalListHeadDistanceView.h"
#import "EtaoLocalDiscountDetailController.h"
#import "EtaoUIViewWithBackgroundController.h"

@interface EtaoLocalListController : EtaoUIViewWithBackgroundController <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,CLLocationManagerDelegate>{
	
	EtaoLocalListDataSource *_srpdata;
	
	CLLocationManager *_locationManager ;
	CLLocation *_userLocation;
	
	UITableView *tableView; 
	
	EtaoLocalListHeadDistanceView *_head ;
	
	BOOL _isLoading ;
	
	UIViewController *_parent ;
	
	NSString *_selectedType ;
	
	// 上一次查询的中心位置
	MKMapView *mapView;
	CLLocationCoordinate2D _lastSearchCoordinate ;  
	double _deltaLatitude ;
	double _deltaLongitude ; 
	  	  
}

- (id)initWithdataSource:(EtaoLocalListDataSource*)datas ; 

- (void) requestFinished:(HttpRequest *)request;

- (void) requestFailed:(HttpRequest *)request;

- (void) loadMoreFrom:(int)s TO:(int)e;

- (void) typeButtonClickOn:(NSString*)type ;

@property (nonatomic,retain) EtaoLocalListDataSource *_srpdata; 
@property (nonatomic,assign) BOOL _isLoading ;
@property (nonatomic,retain) CLLocation *_userLocation;
@property (nonatomic,retain) CLLocationManager *_locationManager ;
@property (nonatomic,retain) UITableView *tableView; 
@property (nonatomic,retain) EtaoLocalListHeadDistanceView *_head ;
@property (nonatomic,retain) UIViewController *_parent ;
@property (nonatomic,retain) NSString *_selectedType ;
@property CLLocationCoordinate2D _lastSearchCoordinate;  
@property double _deltaLatitude ;
@property double _deltaLongitude ; 

@end
