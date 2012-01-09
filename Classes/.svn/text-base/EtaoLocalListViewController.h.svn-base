//
//  EtaoLocalListViewController.h
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoLocalListDataSource.h"
#import "HttpRequest.h"
#import "ASIHTTPRequest.h"
#import "EtaoLocalDiscountDetailController.h"

@interface EtaoLocalListViewController : UITableViewController <UINavigationBarDelegate,CLLocationManagerDelegate>{

	EtaoLocalListDataSource *_srpdata;
	
	CLLocationManager *_locationManager ;
	CLLocation *_userLocation;
	
	BOOL _isLoading ;
}

- (void) requestFinished:(HttpRequest *)request;

- (void) requestFailed:(HttpRequest *)request;

- (void) loadMoreFrom:(int)s TO:(int)e;

@property (nonatomic,retain) EtaoLocalListDataSource *_srpdata; 
@property (nonatomic,assign) BOOL _isLoading ;
@property (nonatomic,retain) CLLocation *_userLocation;
@property (nonatomic,retain) CLLocationManager *_locationManager ;


@end
