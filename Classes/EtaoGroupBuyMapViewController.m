//
//  EtaoGroupBuyMapView.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoGroupBuyMapViewController.h"
#import "EtaoTuanAuctionItem.h"
#import "EtaoTuanListDetailController.h"
#import "EtaoTuanHomeViewController.h"
#import "EtaoSystemInfo.h"


@interface  EtaoGroupBuyMapViewController() {
    
    NSString* _userPositionName;
    NSString* _userCityName;

    int _getCityNameByGpsInfoRetryTimes;
    int _distance;

    BOOL isGpsCallBack;
    BOOL isLocalFinished;

    BOOL isAutoPositionMapCenter;
    BOOL _isAotuCallBack;    
    
    EtaoTuanAuctionItem* _selectEtaoTuanAuctionItem;
}

- (void) initMapView;
- (void)loadUserLocation;
- (void)saveUserLocation;


@end


@implementation EtaoGroupBuyMapViewController

@synthesize mapView = _mapView;
@synthesize datasource = _datasource;
@synthesize userGpsPosition;


- (void) loadView {
    
    [super loadView];
    
    _distance = 5000;
    isGpsCallBack = YES;
    isAutoPositionMapCenter = YES;
    isLocalFinished = YES;
    _isAotuCallBack = YES;
    
    if (nil == _mapView) {
        [self initMapView];
    }
    
    
    UIImageView* mapButtomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"groupBuyMapButtom.png"]];
    [mapButtomView setFrame:CGRectMake(0, MAP_HEIGHT-2, 320, 2)];
    [self.view addSubview:mapButtomView];
    [mapButtomView release];
    
    UIButton *btnloc = [[UIButton alloc] initWithFrame:CGRectMake(265, MAP_HEIGHT-60, 45, 45)]; 
    [btnloc setImage:[UIImage imageNamed:@"groupBuyMapPositioning.png"] forState:UIControlStateNormal];  
    [btnloc addTarget:self action:@selector(locatedMe) forControlEvents:UIControlEventTouchUpInside]; 
    [btnloc setTintColor:[UIColor blackColor]];
    [self.view addSubview:btnloc];
    [btnloc release];
    
    //加载上次使用过的数据
    [self loadUserLocation];
    
}


- (void) initMapView { 
    
    if (nil == _mapView) {
        _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];
    }
    
	_mapView.zoomEnabled = YES;
	_mapView.scrollEnabled = YES;
	_mapView.mapType = MKMapTypeStandard;
	_mapView.delegate = self;
	_mapView.showsUserLocation = YES;  
	
    [self.view addSubview:_mapView]; 
}


- (void) setFrame:(CGRect)rect {
    [self.view setFrame:rect];
    [_mapView setFrame:rect];
}


- (void) setHidden:(BOOL)hidden{
	[_mapView setHidden:hidden];
    [self.view setHidden:hidden];
}


- (void)locatedMe{
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-StylePositioning"];

	if (_mapView.userLocation.location == nil) {
		UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘" message:@"定位中，请稍等..." 
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil] autorelease];
		[alert show];
		return ;
	}
    
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, _distance, _distance);
	[_mapView setRegion:userLocation animated:YES];
//	self._lastSearchCoordinate =  _mapView.userLocation.coordinate; 
//	[self typeButtonClickOn:_selectedType]; 
}



- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    isLocalFinished = NO;
    if ([_datasource respondsToSelector:@selector(positonSessionRequestDidFailed:)]) {
        [_datasource performSelector:@selector(positonSessionRequestDidFailed:) withObject:self];
    }
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{	 
    
#if TARGET_IPHONE_SIMULATOR
    CLLocation* emulocation = [[[CLLocation alloc]initWithLatitude:31.230381 longitude:121.473727]autorelease]; // {31.230381,121.473727};
    MKCoordinateRegion emuLoc = MKCoordinateRegionMakeWithDistance(emulocation.coordinate, _distance, _distance);
    
    if (YES == isAutoPositionMapCenter) {
        [_mapView setRegion:emuLoc animated:YES];
        
        isAutoPositionMapCenter = NO;
    }
    
    userGpsPosition.latitude = emulocation.coordinate.latitude;
    userGpsPosition.longitude = emulocation.coordinate.longitude;
    
#elif TARGET_OS_IPHONE
    MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, _distance, _distance);
    userGpsPosition.latitude = userLocation.coordinate.latitude;
    userGpsPosition.longitude = userLocation.coordinate.longitude;
    
    if (YES == isAutoPositionMapCenter) {
        [_mapView setRegion:userLoc animated:YES];

        isAutoPositionMapCenter = NO;
    }
    
#endif

    //保存GPS
    [self saveUserLocation];
    
    isLocalFinished = YES;
    
    //根据GPS获取城市信息
    if (nil == _reverseGeocoder) {
        _reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:userGpsPosition];  
        _reverseGeocoder.delegate = self; 
        [_reverseGeocoder performSelector:@selector(start) withObject:nil afterDelay:5];  
    }
    
    if (isGpsCallBack == YES) {
        if ([_datasource respondsToSelector:@selector(positonSessionRequestDidFinish:)]) {
            [_datasource performSelector:@selector(positonSessionRequestDidFinish:) withObject:self];

            isGpsCallBack = NO;
        }
    }
    
    _getCityNameByGpsInfoRetryTimes = 0;
    
    NSLog(@"%f,%f",userGpsPosition.latitude,userGpsPosition.longitude);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
}


- (NSString *)imageNameForAnnotaion:(id <MKAnnotation>)annotation {
    NSString * image = nil;
    if ([annotation isKindOfClass:[EtaoTuanAuctionItem class]]) {
		EtaoTuanAuctionItem *item = (EtaoTuanAuctionItem*)annotation;
                
        if ([item.type isEqualToString:@"餐饮美食"]) {
            image = @"food";
        }else if ([item.type isEqualToString:@"休闲娱乐"]) {
            image = @"yule";
        }else if ([item.type isEqualToString:@"美容保健"]) {
            image = @"meirong";
        }else if ([item.type isEqualToString:@"网上购物"]) {
            image = @"shopping";
        }else if ([item.type isEqualToString:@"旅游酒店"]) {
            image = @"fly";
        }else if ([item.type isEqualToString:@"其它"]) {
            image = @"other";
        }
    }
	
    return image;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	static NSString * locationIdentifier = @"LocationPoint";
	if ([annotation isKindOfClass:[EtaoTuanAuctionItem class]]) { 
        
		NSString *imageUnselectedName = [self imageNameForAnnotaion:annotation];
		UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imageUnselectedName]];
		
		
        MKAnnotationView * pinAnnotationView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:locationIdentifier];
        if (pinAnnotationView != nil) {
			[pinAnnotationView setAnnotation:annotation]; 
            pinAnnotationView.canShowCallout = YES;
        }else {  
            pinAnnotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:locationIdentifier] autorelease];
			pinAnnotationView.canShowCallout = YES;
			UIButton* disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			
           [disclosureButton addTarget:self
								 action:@selector(gotoDetail:)
					   forControlEvents:UIControlEventTouchUpInside];
			pinAnnotationView.rightCalloutAccessoryView = disclosureButton;
        }
        
		pinAnnotationView.image = image;
     
        return pinAnnotationView;  
        
    }

	return nil;	
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views { 
	MKAnnotationView *aV; 
	for (aV in views) {
//		if ( ![aV isKindOfClass:[MKPinAnnotationView class]]) {
//			continue ;
//		}
		CGRect endFrame = aV.frame;
		
		aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 230.0, aV.frame.size.width, aV.frame.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[aV setFrame:endFrame];
		[UIView commitAnimations];
	}
}


- (void)gotoDetail:(id)sender { 	
	
    EtaoTuanListDetailController* listDetail = [[[EtaoTuanListDetailController alloc]init]autorelease];
    listDetail.item = _selectEtaoTuanAuctionItem;
    listDetail.title = @"详情页";
    [[EtaoTuanHomeViewController getNavgationController] pushViewController:listDetail animated:YES];
}


- (void)showFirstMapAuctions {
    
    if (_mapView.hidden == NO) {
    
        //删除以前第
        [_mapView removeAnnotations:_mapView.annotations];
        
        [self showNextMapAuctions];
    }
}


- (void)showNextMapAuctions {
    
    if (_mapView.hidden == YES) {
        return; 
    }
    
    if (_mapView.hidden == NO) {
        NSArray *tmpItems = [NSArray arrayWithArray:_datasource.items];
        
        //NSArray *tmp2 = [NSArray arrayWithArray:self.mapView.annotations];
        
        for (id item in tmpItems) { 
            if ( [item isKindOfClass:NSClassFromString(@"EtaoTuanAuctionItem") ]) {
                //[_mapView removeAnnotation:anno];
                
                EtaoTuanAuctionItem* tempItem = item;
                
                if (([tempItem.latitude doubleValue]!=0) && ([tempItem.longitude doubleValue]!=0)) {
                    
                    //如果商家经纬度写反了，帮纠正过来。
                    if([tempItem.latitude doubleValue] > [tempItem.longitude doubleValue]){
                        NSString* tmp = tempItem.latitude;
                        tempItem.latitude = tempItem.longitude;
                        tempItem.longitude = tmp;
                    }
                    
                    //（北纬53°30′），南到南沙群岛南端的曾母暗沙（北纬4°），跨纬度49度多；东起黑龙江与乌苏里江汇合处（东经135°05′），西到帕米尔高原（东经73°40′）
                    if(([tempItem.latitude doubleValue] > 3) 
                       &&([tempItem.latitude doubleValue] < 54)
                       &&([tempItem.longitude doubleValue] > 73)
                       &&([tempItem.longitude doubleValue] < 136)) {
                        
                        [_mapView addAnnotation:tempItem];    
                    }
                }
            } 
        }
        
    }   
}


//ListDelegate
- (void)autoMoveWhenSelect:(int)index {
    if (nil != _datasource) {
        
        if ([[_datasource items] count] <= index) {
            return;
        }
        
        EtaoTuanAuctionItem* item = [[_datasource items] objectAtIndex:index];
        
        if (([item.latitude doubleValue]!=0) && ([item.longitude doubleValue]!=0)) {
            CLLocation* emulocation = [[[CLLocation alloc]initWithLatitude:[item.latitude doubleValue] longitude:[item.longitude doubleValue]]autorelease];
            MKCoordinateRegion emuLoc = MKCoordinateRegionMake(emulocation.coordinate, [_mapView region].span);
            [_mapView setRegion:emuLoc animated:YES];
            
            //地图上显示已选中的POI
            MKAnnotationView *tempView = [_mapView viewForAnnotation:item];
            if ([tempView.annotation isKindOfClass:[EtaoTuanAuctionItem class]]) { 
                _selectEtaoTuanAuctionItem = (EtaoTuanAuctionItem*)tempView.annotation;
                NSString *imageUnselectedName = [self imageNameForAnnotaion:tempView.annotation];
                tempView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@hover.png", imageUnselectedName]]; 
           
                _isAotuCallBack = NO;
                [_mapView selectAnnotation:tempView.annotation animated:YES];
                _isAotuCallBack = YES;
            }
        }else {
            _isAotuCallBack = NO;
            [_mapView deselectAnnotation:_selectEtaoTuanAuctionItem animated:YES];
            _isAotuCallBack = YES;
        }
    }
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	NSLog(@"didSelectAnnotationView.userlocation=%@",view.annotation );
	if ([view.annotation isKindOfClass:[EtaoTuanAuctionItem class]]) { 
		_selectEtaoTuanAuctionItem = (EtaoTuanAuctionItem*)view.annotation ; 
		NSString *imageUnselectedName = [self imageNameForAnnotaion:view.annotation];
		view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@hover.png", imageUnselectedName]]; 
        
        //联动
        //ListDelegate
        int index = [[_datasource items] indexOfObject:_selectEtaoTuanAuctionItem];
        
        if (YES == _isAotuCallBack) {
            [[_datasource delegate] autoMoveWhenSelect:index];
        }
    }
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view { 
	//	self.curselectAnnotation = nil ;
 	if ([view.annotation isKindOfClass:[EtaoTuanAuctionItem class]]) {
        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self imageNameForAnnotaion:view.annotation]]];
    }   
}


- (void) setSelectedAnnotation:(id < MKAnnotation >)annotation {
	_selectEtaoTuanAuctionItem = (EtaoTuanAuctionItem*)annotation; 
	[_mapView selectAnnotation:_selectEtaoTuanAuctionItem animated:YES]; 	
}


- (void) setDeselectedAnnotation:(id < MKAnnotation >)annotation {  
	
	[_mapView deselectAnnotation:annotation animated:YES]; 
	
}


- (void)mapView:(MKMapView *)mapView  annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	//	[self gotoDetail:nil];
}


//根据GPS获取城市信息，回调
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    NSLog(@"%s", __FUNCTION__); 
    
    if (nil != _userPositionName) {
        [_userPositionName release];
	}
    
    if (nil != _userCityName) {
        [_userCityName release];
    }
    
    _userCityName = [placemark.locality retain];
    
    _userPositionName = [[NSString stringWithFormat:@"%@%@%@%@", 
						 // placemark.country,
						 placemark.administrativeArea,
						 placemark.locality,
						 placemark.subLocality,
						 placemark.thoroughfare
						 // placemark.subThoroughfare
						 ] retain];
        
    //Need change
    if ([_datasource respondsToSelector:@selector(userLocationInfoRequestDidFinish:)]) {
        [_datasource performSelector:@selector(userLocationInfoRequestDidFinish:)withObject:self];
    }
    
    //保存
    [self saveUserLocation];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	NSLog(@"%s", __FUNCTION__);  
	_getCityNameByGpsInfoRetryTimes += 1 ;
	[NSThread sleepForTimeInterval:2];
	if ( _getCityNameByGpsInfoRetryTimes < 3) {
        [self performSelector:@selector(getCityAgain) withObject:nil afterDelay:3];
	} 
}


- (void)getCityAgain {
    [_reverseGeocoder start];        
}


- (void)setMapCenter:(CLLocationCoordinate2D)gpsPositon {
    
    if (gpsPositon.latitude==0 || gpsPositon.longitude==0) {
        return;
    }
    
    CLLocation* emulocation = [[[CLLocation alloc]initWithLatitude:gpsPositon.latitude longitude:gpsPositon.longitude]autorelease];
    MKCoordinateRegion emuLoc = MKCoordinateRegionMakeWithDistance(emulocation.coordinate, _distance, _distance);
	[_mapView setRegion:emuLoc animated:YES];
    
    userGpsPosition.latitude = emulocation.coordinate.latitude;
    userGpsPosition.longitude = emulocation.coordinate.longitude;
}


- (void)upDateGps {
    isGpsCallBack = YES;
    _mapView.showsUserLocation = YES;
    
    [_mapView showsUserLocation];
    
    //延时回调
    [self performSelector:@selector(callBack) withObject:nil afterDelay:3];
}

- (void) callBack {
    if( YES == isGpsCallBack ) {
        if(isLocalFinished ==YES){
        //先用同步模拟
            if ([_datasource respondsToSelector:@selector(positonSessionRequestDidFinish:)]) {
                [_datasource performSelector:@selector(positonSessionRequestDidFinish:)];
            }
        }
        else{
            if ([_datasource respondsToSelector:@selector(positonSessionRequestDidFailed:)]) {
                [_datasource performSelector:@selector(positonSessionRequestDidFailed:)];
            }
        }
    }
}


//获取用户当前GPS
- (CLLocationCoordinate2D)getUserGPS {
    return self.userGpsPosition;
}


- (NSString*)getUserPositionName {
    return _userPositionName;
}


- (NSString*)getUserCityName {
    return _userCityName;
}


- (void)loadUserLocation {
    //当下载失败时，读取上次存储的数据。
    NSString* tempStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"USERPOSITIONNAME"];
    
    if (nil != tempStr) {
        if (nil != _userPositionName) {
            [_userPositionName release];
        }
        _userPositionName = [tempStr retain];
    }
    
//    NSString* tempCityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERCITYNAME"];
//    
//    if (nil != tempCityName) {
//        if (nil != _userCityName) {
//            [_userCityName release];
//        }
//        _userCityName = [tempCityName retain];
//    }
    
    
    double lat = [[NSUserDefaults standardUserDefaults] doubleForKey:@"ETAOLOCATIONLAT"];
    double lon = [[NSUserDefaults standardUserDefaults] doubleForKey:@"ETAOLOCATIONLON"];
    CLLocationCoordinate2D tempLocation;
    tempLocation.latitude = lat;
    tempLocation.longitude = lon;
    self.userGpsPosition = tempLocation;
    
}


- (void)saveUserLocation {
    //保存成功的数据，以防止下次失败时使用。
    
    if (nil != _userPositionName) {
        [[NSUserDefaults standardUserDefaults] setObject:_userPositionName forKey:@"USERPOSITIONNAME"];        
    }
    
//    if (nil != _userCityName) {
//        [[NSUserDefaults standardUserDefaults] setObject:_userCityName forKey:@"USERCITYNAME"];    
//    }
    
    [[NSUserDefaults standardUserDefaults] setDouble:self.userGpsPosition.latitude forKey:@"ETAOLOCATIONLAT"];
    [[NSUserDefaults standardUserDefaults] setDouble:self.userGpsPosition.longitude forKey:@"ETAOLOCATIONLON"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) dealloc {
    
    _datasource.delegateForMap = nil;
    [_datasource release];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView release];
    [_reverseGeocoder release];
    
    [_userPositionName release];
    _userPositionName = nil;
   
    [_userCityName release];
     _userCityName = nil;
    
    [super dealloc];
}


@end
