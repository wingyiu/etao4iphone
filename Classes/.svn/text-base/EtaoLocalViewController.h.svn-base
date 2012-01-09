//
//  EtaoLocalViewController.h
//  etao4iphone
//
//  Created by iTeam on 11-8-31.
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

#import "EtaoUIViewWithBackgroundController.h"
 
#import "EtaoLocalClassifyView.h"
#import "EtaoLocalSelectRegionAnnotation.h"
#import "MapLoadingView.h"

#import "EtaoLocalListTableViewCell.h"
#import "NSObject+SBJson.h"

#import "EtaoLocalDiscountRequest.h"
#import "EtaoLocalListHeadDistanceView.h"
#import "EtaoLocalDiscountItem.h"
#import "EtaoLocalClassifyView.h"

#import "EtaoLocalListHeadDistanceView.h"
#import "EtaoLocalDiscountDetailController.h"
#import "EtaoUIViewWithBackgroundController.h"
#import "EtaoLocalNavTitleView.h"
#import "ETaoLocalMenuView.h"
#import <QuartzCore/QuartzCore.h>
#import "ETaoUIViewController.h"

#import "EtaoTuanHomeViewController.h"


@interface EtaoLocalViewController: ETaoUIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate> {
 
	EtaoLocalListDataSource *_srpdata;
	
	MKMapView *_mapView;
	CLLocationManager *_locationManager; 
	EtaoLocalDiscountItem *_curselectAnnotation ;
	
	CLLocation *_userlocation ; 
	
	// 上一次查询的中心位置
	CLLocationCoordinate2D _lastSearchCoordinate ;  
	double _deltaLatitude ;
	double _deltaLongitude ;  
	
	//
	EtaoLocalMapFootView *_footView;
	EtaoLocalListHeadDistanceView *_listhead;
	EtaoLocalListHeadDistanceView *_maphead;
	EtaoLocalClassifyView *_categoryView;
 	EtaoLocalClassifyView *_categoryViewlist; 
	
	NSString *_selectedType ; 
	
	MapLoadingView *_loading ;
	
	BOOL _isLoading ;
	
	BOOL _hidden ; 	
	
//	UIView* _listMode;
	UIView* _mapMode;
    
    EtaoLocalDiscountRequest *_tuanhttpquery ;
    
    //ETaoLocalMenuView *_rankView ; 
	EtaoLocalNavTitleView *_rankbtnv;
    
    int _distance ;
    
    EtaoTuanHomeViewController* _slideView;
}

@property (nonatomic, retain) MKMapView *mapView; 
//@property (nonatomic, retain) UIView* listMode;
@property (nonatomic, retain) UIView* mapMode;
@property (nonatomic, retain) CLLocationManager *locationManager;   
@property (nonatomic, retain) CLLocation *userlocation ; 
@property (nonatomic, retain) EtaoLocalMapFootView *footView;
@property (nonatomic, retain) EtaoLocalListHeadDistanceView *listhead ;
@property (nonatomic, retain) EtaoLocalListHeadDistanceView *maphead ;
@property (nonatomic, assign) NSString *_selectedType ;
@property (nonatomic, retain) MapLoadingView *loading ;
@property (nonatomic, retain) EtaoLocalClassifyView *categoryView;
@property (nonatomic, retain) EtaoLocalClassifyView *categoryViewlist;
@property (nonatomic, retain) EtaoLocalDiscountRequest *tuanhttpquery ;
@property BOOL _locationAccessAllowed ;
@property CLLocationCoordinate2D _lastSearchCoordinate;  
@property double _deltaLatitude ;
@property double _deltaLongitude ;  
@property BOOL _isLoading ;
@property BOOL _hidden ;
@property int _s ;
@property int _e ;
@property int _lastSelectIdx ;
@property BOOL _isLocated ;
@property BOOL _LocatedFailed ;
@property BOOL _LocatedAlert ;
@property  int _distance ;
@property (nonatomic,assign) EtaoLocalDiscountItem *_curselectAnnotation ; 
@property (nonatomic,assign) BOOL _requestFailed ;

@property (nonatomic,retain) EtaoLocalListDataSource *srpdata;
// tableview 
//@property (nonatomic,retain) UITableView *tableView;  
 

//@property (nonatomic,retain) ETaoLocalMenuView *rankView ; 
@property (nonatomic,retain) EtaoLocalNavTitleView *rankbtnv;

@property (nonatomic, retain) EtaoTuanHomeViewController* slideView;

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
- (void)setMapAnnotation;
@end
