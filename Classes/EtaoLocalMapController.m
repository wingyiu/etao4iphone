    //
//  EtaoLocalMapController.m
//  etao4iphone
//
//  Created by GuanYuhong(zhangsuntai@taobao.com) on 11-8-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalMapController.h"
#import "EtaoLocalClassifyView.h"
#import "EtaoLocalSelectRegionAnnotation.h"
#import "MapLoadingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation EtaoLocalMapController

@synthesize mapView ; 
@synthesize locationManager; 

@synthesize userlocation;
@synthesize curselectAnnotation; 
@synthesize locationAccessAllowed; 
@synthesize _lastSearchCoordinate;  
@synthesize _deltaLatitude ;
@synthesize _deltaLongitude ;
@synthesize _categoryView ;
@synthesize discountDatas;
@synthesize _footView,_head;
@synthesize _parent;
@synthesize _selectedType ;
@synthesize _s,_e ;
@synthesize _loading ;
@synthesize _isLoading ;
@synthesize _hidden;
//@synthesize selectedAnnotationView;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id)initWithdataSource:(EtaoLocalListDataSource*)datas {
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	self = [super init];
	if (self) {
		self.discountDatas = datas ;
		// Custom initialization.
	}
	return self;
}

- (id)init{
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	self = [super init];
	if (self) {
		EtaoLocalListDataSource * datas = [[EtaoLocalListDataSource alloc]init];
		self.discountDatas = datas ;
		[datas release];
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	self.locationAccessAllowed = NO ;
	self._isLoading = NO ;
	
//	NSString *reqSysVer = @"4.0";
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    self.osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending); 
	
	self._selectedType = @"all";
	mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0,-44,320,460)];
    self.mapView.mapType = MKMapTypeStandard;
	
    self.mapView.showsUserLocation = YES;
	 	
	// Create location manager with filters set for battery efficiency.
	locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	NSString *reqSysVer = @"4.0";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending); 
 	
	if (osVersionSupported) {
		
		self.locationAccessAllowed = [CLLocationManager locationServicesEnabled] ; 
	}
	
	if ( self.locationAccessAllowed ) {
		[self.locationManager startUpdatingLocation]; 
	}
	else
	{ 
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"一淘" message:[NSString stringWithFormat:@"建议您打开定位功能,以便更好的使用一淘客户端的服务\n设置->通用->定位服务"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alert show];
		[alert release]; 
	} 
	
    [self.view addSubview:self.mapView]; 
	
	self.mapView.delegate = self;	 	
	//[self.view sendSubviewToBack: self.mapView];
	
	self.curselectAnnotation = nil ;
	

	// 初始化datasource
	//EtaoLocalListDataSource * datas = [[EtaoLocalListDataSource alloc]init];
	//self.discountDatas = datas ;
	//[datas release]; 
	
	
	EtaoLocalMapFootView *foot =  [[EtaoLocalMapFootView alloc]initWithFrame:CGRectMake(67.5f,320,185,30)];
	self._footView = foot;
	[foot addTarget:self action:@selector(FootButtonPress:)];
	[foot release];
	
	EtaoLocalListHeadDistanceView *headview = [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 30, 320,30)];
 	self._head = headview;
	[headview release];
	
	EtaoLocalClassifyView *tmp = [[EtaoLocalClassifyView alloc] initWithFrame:CGRectMake(0, 0, 320,30)]; 
	tmp.delegate = self;
	tmp.typeButtonClickOnSelector = @selector(typeButtonClickOn:);
	self._categoryView = tmp ;
	[self.view addSubview:tmp];
	[tmp release]; 

	
	[self.view addSubview:self._head]; 
	[self.view addSubview:self._footView];

}
 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.mapView.zoomEnabled = YES;
	self.mapView.scrollEnabled = YES;
	self.mapView.mapType = MKMapTypeStandard;
	self.mapView.delegate = self;
	self.mapView.showsUserLocation = YES;  
	
	UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(MapPress:)];
	lpress.minimumPressDuration = 0.5;//按0.5秒响应longPress方法
	lpress.allowableMovement = 10.0;
	//给MKMapView加上长按事件
	[self.mapView addGestureRecognizer:lpress];//mapView是MKMapView的实例
	[lpress release]; 
 
	
	UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
	[self.mapView addGestureRecognizer:mTap];
	[mTap release];
	
	/*
	UILongPressGestureRecognizer *spress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sMapPress:)];
	spress.minimumPressDuration = 0.05;//按0.5秒响应longPress方法
	spress.allowableMovement = 10.0;
	//给MKMapView加上长按事件
	[self.mapView addGestureRecognizer:spress];//mapView是MKMapView的实例
	[spress release];
	*/
	
	self.userlocation = nil ; 
}


- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
	
	if (self.userlocation != nil) {
		return;
	}
 	userlocation = [[CLLocation alloc]initWithLatitude:31.230381 longitude:121.473727]; // {31.230381,121.473727};
	MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(self.userlocation.coordinate, 1000, 1000);
	[self.mapView setRegion:userLoc animated:NO];
	
	self._lastSearchCoordinate =  self.mapView.region.center;
	[self typeButtonClickOn:self._selectedType];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
	
	if (!self.locationAccessAllowed) {
		return ;
	} 
	if (self.userlocation != nil) {
		return;
	}
	//MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1000, 1000);
	
	userlocation = [[CLLocation alloc]initWithLatitude:31.230381 longitude:121.473727]; // {31.230381,121.473727};
	MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(self.userlocation.coordinate, 1000, 1000.0);
	[self.mapView setRegion:userLoc animated:NO]; 
	
	self._lastSearchCoordinate =  self.mapView.region.center;
	[self typeButtonClickOn:self._selectedType];
 	
}


- (void) typeButtonClickOn:(NSString*)type { 
	self._selectedType = type;  
	
	MKMapRect mRect = self.mapView.visibleMapRect;
	MKMapPoint minMapPoint = MKMapPointMake(mRect.origin.x  , mRect.origin.y );  
	CLLocationCoordinate2D mCoord = MKCoordinateForMapPoint(minMapPoint); 	
	self._deltaLatitude = fabs(self.mapView.region.center.latitude - mCoord.latitude);
	self._deltaLongitude = fabs(self.mapView.region.center.longitude - mCoord.longitude);  
	
	[self.discountDatas clear];
	[self loadMoreFrom:0 TO:20 withType:type]; 
	 
	
}

- (void)FootButtonPress:(id)sender{
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*) sender; 
		if (btn.tag == 1 ) { 
			if (self.curselectAnnotation == nil  ) {
				return ;
			}  
			
			int idx = [self.discountDatas.items indexOfObject:self.curselectAnnotation]; 
			
			if (idx == 0) {
				return;
			} 
			[self setSelectedAnnotation:[self.discountDatas.items objectAtIndex:idx-1]];
		}
		else if ( btn.tag == 2 ){
			if (self.curselectAnnotation == nil ) {
				return ;
			} 
			
			int idx = [self.discountDatas.items indexOfObject:self.curselectAnnotation]; 
			
			if (idx >= self.discountDatas._totalCount - 1) {
				return;
			}
			if ( idx == [self.discountDatas.items count] -1 ) {  
				MapLoadingView *loading = [[[MapLoadingView alloc] initWithFrame:CGRectMake(140.0f,280.0f ,40.0f, 40.0f) Message:@"正在搜索"]autorelease];
				[self.view addSubview:loading];
				
				[self loadMoreFrom:[self.discountDatas.items count] TO:20 withType:_selectedType];
			}
			else {
				[self setSelectedAnnotation:[self.discountDatas.items objectAtIndex:idx+1]];
			}
		}
		else {
			if (!self.locationAccessAllowed) {  
				UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘"   message:@"您需要打开定位功能来使用该功能"   delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil] autorelease];
				[alert show];
				return ;
			}
			if (self.mapView.userLocation.location == nil) {
				UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘"   message:@"定位中，请稍等..."   delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil] autorelease];
				[alert show];
				return ;
			}
			MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 1000.0, 1000.0);
			[self.mapView setRegion:userLocation animated:YES];
			self._lastSearchCoordinate =  self.mapView.userLocation.coordinate; 
			[self typeButtonClickOn:_selectedType]; 
		} 
	}
	 }
 


- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    NSLog(@"%s", __FUNCTION__);
	
/*	NSString *address = [NSString stringWithFormat:@"您的位置:%@%@%@%@", 
						 // placemark.country,
						 placemark.administrativeArea,
						 placemark.locality,
						 placemark.subLocality,
						 placemark.thoroughfare
						 // placemark.subThoroughfare
						 ];
	
	NSLog(@"经纬度所对应的详细:%@", address);
 
	*/
	[geocoder cancel];
	[geocoder release]; 

}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
	if (geocoder != nil) {
		[geocoder cancel];
		[geocoder release];
	} 
}


- (void) requestFinished:(EtaoLocalDiscountRequest *)sender { 
	EtaoLocalDiscountRequest * request = (EtaoLocalDiscountRequest *)sender; 
	
	int beforeIdx = [self.discountDatas count] ;
	[self.discountDatas addItemsByJSON:request.jsonString]; 
	_e = _s + [self.discountDatas count]; 
 
	
	NSArray *tmp = [NSArray arrayWithArray:self.mapView.annotations];
	
	for (id anno in tmp) { 
		if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalDiscountItem") ]) {
			[self.mapView removeAnnotation:anno];
		} 
	}
 	  
	// 根据经纬度，重新计算到原点的距离，更新引擎的结果
	for(EtaoLocalDiscountItem *tbdicount in self.discountDatas.items){ 
	//	CLLocation *dest = [[[CLLocation alloc] initWithLatitude:tbdicount.coordinate.latitude longitude: tbdicount.coordinate.longitude]autorelease]; 
		//	tbdicount.shopDistance = [NSString stringWithFormat:@"%0.2f",[[self.locationManager location] distanceFromLocation:dest]/1000];
		//[self._head setText:[NSString stringWithFormat:@"距离约%@公里以内,(%d-%d)共%d个",tbdicount.shopDistance,_s,_e,self.discountDatas._totalCount]];
	} 
	
	[self.mapView addAnnotations:self.discountDatas.items]; 	
	
	for ( UIView *v in [self.view subviews] ){
		if ( [v isKindOfClass:[MapLoadingView class]] ){
			MapLoadingView *loading = (MapLoadingView*)v;
			[loading stopAnimating];
			[v removeFromSuperview];
		}
	}
	if ([self.discountDatas.items count] > 0 && beforeIdx < [self.discountDatas.items count]) {
		[self setSelectedAnnotation:[self.discountDatas objectAtIndex:beforeIdx]];
	} 
	_isLoading = NO ;
}


- (void) requestFailed:(EtaoLocalDiscountRequest *)sender{ 
	NSLog(@"retainCount=%d",[sender retainCount]);
	_isLoading = NO ;
}

 

- (void) loadMoreFrom:(int)s TO:(int)n withType:(NSString*)type{
	if (_isLoading == YES) {
//		return ;
	}
	if (self.userlocation == nil) {
		return ;
	}   
	for ( UIView *v in [self.view subviews] ){
		NSLog(@"%@",v);
		if ( [v isKindOfClass:[MapLoadingView class]] ){
			MapLoadingView *loading = (MapLoadingView*)v;
			[loading startAnimating];
		}
	}
	_s = s;
	_e = s+n;
	EtaoLocalDiscountRequest *httpquery = [[[EtaoLocalDiscountRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._lastSearchCoordinate.latitude] forKey:@"dist_x"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._lastSearchCoordinate.longitude] forKey:@"dist_y"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._deltaLatitude] forKey:@"dist_x_delta"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._deltaLongitude] forKey:@"dist_y_delta"];
	[httpquery addParam:type forKey:@"discount_type"];
	[httpquery addParam:[NSString stringWithFormat:@"%d",s] forKey:@"s"];
	[httpquery addParam:[NSString stringWithFormat:@"%d",n] forKey:@"n"];
	[httpquery start];	
	_isLoading = YES; 	
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	static NSString * locationIdentifier = @"LocationPoint";
	if ([annotation isKindOfClass:[EtaoLocalDiscountItem class]]) { 
		
		NSString *imageUnselectedName = [self imageNameForAnnotaion:annotation];
		UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imageUnselectedName]];
	  
		
        MKAnnotationView * pinAnnotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:locationIdentifier];
        if (pinAnnotationView != nil) {
			[pinAnnotationView setAnnotation:annotation]; 
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
	if ( [annotation isKindOfClass:[EtaoLocalSelectRegionAnnotation class]] ) {
		MKPinAnnotationView *pinAnnotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
		pinAnnotationView.canShowCallout = NO;  
		[pinAnnotationView setAnnotation:annotation];
		return pinAnnotationView ;
	}
	return nil;	
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views { 
	MKAnnotationView *aV; 
	 
	for (aV in views) {
		if ( ![aV isKindOfClass:[MKPinAnnotationView class]]) {
			continue ;
		}
		CGRect endFrame = aV.frame;
		
		aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 230.0, aV.frame.size.width, aV.frame.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[aV setFrame:endFrame];
		[UIView commitAnimations];
		
	}
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	NSLog(@"didSelectAnnotationView.userlocation=%@",view.annotation );
	if ([view.annotation isKindOfClass:[EtaoLocalDiscountItem class]]) { 
		self.curselectAnnotation = (EtaoLocalDiscountItem*)view.annotation ; 
		NSString *imageUnselectedName = [self imageNameForAnnotaion:view.annotation];
		view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected.png", imageUnselectedName]]; 
		int idx = [self.discountDatas.items indexOfObject:self.curselectAnnotation]+1;
		[self._head setText:[NSString stringWithFormat:@"距离约%@公里以内,%d/%d",self.curselectAnnotation.shopDistance,idx,self.discountDatas._totalCount]];

	}
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view { 
//	self.curselectAnnotation = nil ;
 	if ([view.annotation isKindOfClass:[EtaoLocalDiscountItem class]]) {
        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self imageNameForAnnotaion:view.annotation]]];
    }   
}

- (void) setSelectedAnnotation:(id < MKAnnotation >)annotation {
	self.curselectAnnotation = (EtaoLocalDiscountItem*)annotation; 
	[self.mapView  selectAnnotation:self.curselectAnnotation animated:YES]; 
	
}
- (void) setDeselectedAnnotation:(id < MKAnnotation >)annotation {  
	[self.mapView  deselectAnnotation:annotation animated:YES]; 
	
}
- (void)mapView:(MKMapView *)mapView  annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
 //	[self gotoDetail:nil];
}

- (void)gotoDetail:(id)sender { 	
 
	EtaoLocalDiscountDetailController * detailController = [[[EtaoLocalDiscountDetailController alloc] init]autorelease];
	detailController.item = self.curselectAnnotation ; 
	if (self.userlocation == nil) {
		detailController.userLocation = nil;
	}
	else 
	{
		detailController.userLocation = self.userlocation;
	} 	
	detailController.tableview.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
	detailController.title =@"详情";
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.mapView  deselectAnnotation:self.curselectAnnotation animated:YES]; 
	
	if (_parent != nil) {
		[_parent.navigationController pushViewController:detailController animated:YES];
	}
	else {
		[self.navigationController pushViewController:detailController animated:YES];
	}  
}

- (NSString *)imageNameForAnnotaion:(id <MKAnnotation>)annotation {
    NSString * image = nil;
    if ([annotation isKindOfClass:[EtaoLocalDiscountItem class]]) {
		EtaoLocalDiscountItem *item = (EtaoLocalDiscountItem*)annotation;
        switch ([item.itemType intValue]) {
            case EtaoDiscountItemTypeCatering:
                image = @"annotation_image_category_catering";
                break;
            case EtaoDiscountItemTypeEntertainment:
                image = @"annotation_image_category_entertainment";
                break;
            case EtaoDiscountItemTypeLiving:
                image = @"annotation_image_category_living";
                break;
            default:
                break;
        }
        
    }
	
    return image;
}

- (void)MapPress:(UIGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){  //这个状态判断很重要
        //坐标转换
		CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
		CLLocationCoordinate2D touchMapCoordinate =[self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
  		 	
		//CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
		self._lastSearchCoordinate =  touchMapCoordinate; 
		
	//	MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(touchMapCoordinate, 1000.0, 1000.0);
	//	[self.mapView setRegion:userLocation animated:YES]; 
		EtaoLocalSelectRegionAnnotation * annotation = [[[EtaoLocalSelectRegionAnnotation alloc] init]autorelease];
		annotation.title = @"当前位置";
		annotation.coordinate = touchMapCoordinate;
		NSArray *tmp = [NSArray arrayWithArray:self.mapView.annotations];
		for (id anno in tmp) { 
			if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalSelectRegionAnnotation") ]) {
				[self.mapView removeAnnotation:anno];
			} 
		} 
		[self.mapView addAnnotation:annotation];
		
		MapLoadingView *loading = [[[MapLoadingView alloc] initWithFrame:CGRectMake(touchPoint.x-20, touchPoint.y-10, 40.0f, 40.0f) Message:@"正在搜索"]autorelease];
 		[self.view addSubview:loading];
		
		[self typeButtonClickOn:_selectedType]; 		
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {   
    return YES;
}
 

- (void)HideNavbBar:(BOOL)hidden{ 	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; 	
	for(UIView *view in _parent.navigationController.view.subviews){
		if([view isKindOfClass:[UINavigationBar class]]){   //处理UITabBar视图
			NSLog(@"%@",view);
			if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-74, view.frame.size.width,view.frame.size.height)];
				
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+74, view.frame.size.width,view.frame.size.height)];
			}
			
		}else{   //处理其它视图
		/*	if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,0)];
				
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,0-44)];
			}
			*/
		}
		
	} 
	
	UIView *view = self._categoryView;
	if (hidden) {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-74, view.frame.size.width,view.frame.size.height)];
 	}
	else {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+74, view.frame.size.width,view.frame.size.height)];
		
	}
	
	view = self._head;
	if (hidden) {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-74, view.frame.size.width,view.frame.size.height)];
 	}
	else {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+74, view.frame.size.width,view.frame.size.height)];
		
	} 
	
	[UIView commitAnimations]; 
}

- (void)HideTabBar:(BOOL)hidden{ 	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; 	
	for(UIView *view in _parent.tabBarController.view.subviews){
		if([view isKindOfClass:[UITabBar class]]){   //处理UITabBar视图
			if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width,view.frame.size.height)];
				
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, 480-48, view.frame.size.width,view.frame.size.height)];			}
			
		}else{   //处理其它视图
		 	if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,480)];
								
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,480-48)];
			}
			 
		}
		
	} 
	
	UIView *view = self._footView;
	if (hidden) {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+48, view.frame.size.width,view.frame.size.height)];
 	}
	else {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-48, view.frame.size.width,view.frame.size.height)];
		
	}
	
	[UIView commitAnimations]; 
}



- (void) hidden{ 
	[self setHidden:YES];
}

- (void) setHidden:(BOOL)hidden{
	if (hidden) {
		_hidden = NO;
		[self HideTabBar:YES];
		[self HideNavbBar:YES];	}
	else {
		_hidden = YES;
		[self HideTabBar:NO];
		[self HideNavbBar:NO];;
	}

}
- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){  //这个状态判断很重要
		//坐标转换
	CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
	CLLocationCoordinate2D touchMapCoordinate =[self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
	NSLog(@"%f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
	float min = 100.0f ;
	NSArray *tmp = [NSArray arrayWithArray:self.mapView.annotations];
	EtaoLocalDiscountItem *sel = nil;
	for (id anno in tmp) { 
		if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalDiscountItem") ]) { 
			EtaoLocalDiscountItem *an = (EtaoLocalDiscountItem*)anno;
			if (an == self.curselectAnnotation) {
				continue;
			}
			float diff = fabs(touchMapCoordinate.latitude - an.coordinate.latitude) + fabs(touchMapCoordinate.longitude - an.coordinate.longitude);
			if (diff < min ) {
				min = diff ;
				sel = an ; 
			}
			NSLog(@"%f",an.coordinate.latitude);
			NSLog(@"%f",an.coordinate.longitude); 
		} 
	}  
	
	MKMapRect mRect = self.mapView.visibleMapRect; 	
	if ( min < mRect.size.width / 10240000.0f  ) {
		[self setSelectedAnnotation:sel];
	}
	else 
	{
		// 
		if (self.curselectAnnotation != nil) {
			[self.mapView  deselectAnnotation:self.curselectAnnotation animated:YES]; 
			self.curselectAnnotation = nil ;
		}
		else {
			[self setHidden:self._hidden];  
			// 
		} 
	}

	NSLog(@"%f",min); 
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.mapView = nil;
	self.locationManager.delegate = nil;
    self.locationManager = nil; 
	self.discountDatas = nil;
	self._head = nil;
	self._footView = nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_footView release];
	[_head release];
	[mapView release];
    [locationManager release];
	[discountDatas release];
    [super dealloc];
}


@end
