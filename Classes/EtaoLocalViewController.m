    //
//  EtaoLocalViewController.m
//  etao4iphone
//
//  Created by zhangsuntai on 11-8-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalViewController.h"
#import "EtaoShowAlert.h"
#import "EtaoSRPRequest.h"
#import "EtaoSystemInfo.h"
#import "EtaoShowMessageView.h"
#import "ActivityIndicatorMessageView.h"
#import "EtaoLoadMoreCell.h"
#import "EtaoUIBarButtonItem.h"


@implementation EtaoLocalViewController
 
@synthesize mapView = _mapView ; 
@synthesize locationManager = _locationManager; 
@synthesize srpdata = _srpdata ;
@synthesize userlocation = _userlocation;

@synthesize categoryView = _categoryView;
@synthesize categoryViewlist = _categoryViewlist ; 
@synthesize footView = _footView ;
@synthesize listhead = _listhead; 
@synthesize maphead =  _maphead; 
@synthesize loading = _loading ;
//@synthesize listMode =  _listMode;
@synthesize mapMode = _mapMode;
@synthesize _locationAccessAllowed;
//@synthesize tableView = _tableView;
@synthesize tuanhttpquery = _tuanhttpquery;
@synthesize rankbtnv = _rankbtnv;
//@synthesize rankView = _rankView;

@synthesize _curselectAnnotation;  
@synthesize _selectedType ; 
@synthesize _isLoading,_isLocated ;
@synthesize _hidden; 
@synthesize _s,_e,_lastSelectIdx;
@synthesize _lastSearchCoordinate;  
@synthesize _deltaLatitude ;
@synthesize _deltaLongitude ;
@synthesize _LocatedFailed ;
@synthesize _requestFailed ;
@synthesize _LocatedAlert;
@synthesize _distance;

@synthesize slideView = _slideView;

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


- (void) setMessage{
	
	EtaoSystemInfo *env = [EtaoSystemInfo sharedInstance];
	NSString *count = [env.sysdict objectForKey:@"localMapSearchMessageCountMove"];
	if (count != nil && [count intValue] > 6 ) {
		return;
	}
	int cnt = [count intValue];
	cnt += 1 ;
	[env setValue:[NSString stringWithFormat:@"%d", cnt] forKey:@"localMapSearchMessageCountMove"];
	[env save]; 
	NSString * mess = @"长按地图某点，可以重新搜索。";
	if (cnt %2 == 0) {
		mess = @"单击地图，可以隐藏或显示导航栏。";
	}
	if ([self.view viewWithTag:EtaoShowMessageView_TAG] == nil) {
		EtaoShowMessageView *message = [[[EtaoShowMessageView alloc]initWithFrame:CGRectMake(10,40,200,30) Message:mess]autorelease];
 		[_mapMode addSubview:message];
		[_mapMode bringSubviewToFront:message];
	}	
	
}


- (void) startCheckUserLocation{
	if (_locationManager != nil) {
		[_locationManager startUpdatingLocation]; 
	}  
	
}

- (void) initMapModeView { 
	 
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
	self.mapMode = v ;
	[v release];
   
	 
	_curselectAnnotation = nil ; 	
	
	EtaoLocalMapFootView *foot =  [[EtaoLocalMapFootView alloc]initWithFrame:CGRectMake(60.0-25.0f,320-20+44,185+60,35+40)];
	self.footView = foot;
	[foot addTarget:self action:@selector(FootButtonPress:)];
	[foot release]; 
	
	_mapView.zoomEnabled = YES;
	_mapView.scrollEnabled = YES;
	_mapView.mapType = MKMapTypeStandard;
	_mapView.delegate = self;
	_mapView.showsUserLocation = YES;  
	
	UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(MapPress:)];
	lpress.minimumPressDuration = 0.5;//按0.5秒响应longPress方法
	lpress.allowableMovement = 10.0;
	//给MKMapView加上长按事件
	[_mapView addGestureRecognizer:lpress];//mapView是MKMapView的实例
	[lpress release]; 
	
	
	UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
	[_mapView addGestureRecognizer:mTap];
	[mTap release];
	 
	self.userlocation = nil ; 
	
	[_mapMode addSubview:_mapView]; 
	[_mapMode addSubview:_categoryView];
	[_mapMode addSubview:_maphead]; 
	[_mapMode addSubview:_footView];
    
    [self.view addSubview:_mapMode];
    [_mapMode setHidden:YES];
	
	 
	[self setMessage];
	
	NSLog(@"%@",[_mapMode subviews]);
	
}


//- (void) initlistModeView {  
//    
//	UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//	self.listMode = v ;
//	[v release];
	
//	UITableView * t = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height-44) style:UITableViewStylePlain];   
//	self.tableView = t;
//	[t release]; 
//	
//	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//	[_tableView setDelegate:self]; 
//	[_tableView setDataSource:self];
//
//    [_listMode addSubview:_tableView];
// 	  
//	//[_listMode addSubview:_listhead]; 
//	  
//	_tableView.tableHeaderView = _categoryViewlist; 
//}


- (void) sayOpenLocationServices {
 	if ( !self._LocatedAlert)
 	{
        [[ETaoNetWorkAlert alert]showLocation];
    }
}


- (void)willPresentAlertView:(UIAlertView *)alertView{
    self._LocatedAlert = YES; 
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self._LocatedAlert = NO; 
}


- (void) UIBarButtonItemHome:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[super loadView];
	 
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemHome:)]autorelease];
     self.navigationItem.leftBarButtonItem = home;
    
    _distance = 5000 ;
    
	self._selectedType = @"all";
	EtaoLocalListDataSource * datas = [[EtaoLocalListDataSource alloc]init];
	self.srpdata = datas ;
	[datas release]; 
	
	self._lastSelectIdx = 0 ;
	self._isLocated = NO ;
	self._requestFailed = NO;
	self._hidden = NO;
	self.title = @"附近团购";
 
    EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"地图" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(switchButtonTapped:)]autorelease];
    switchbtn.title = @"map";
    						  
	self.navigationItem.rightBarButtonItem = switchbtn;
    
	MKMapView *map = [[MKMapView alloc]initWithFrame:CGRectMake(0,30,320,400)];
	self.mapView = map ;
	[map release];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
	_mapView.delegate = self; 
	
    UIButton *btnloc = [[[UIButton alloc] initWithFrame:CGRectMake(290, 0, 30, 30)]autorelease]; 
    [btnloc setImage:[UIImage imageNamed:@"EtaoLocation.png"] forState:UIControlStateNormal];  
    [btnloc addTarget:self action:@selector(locatedMe) forControlEvents:UIControlEventTouchUpInside]; 
    [btnloc setTintColor:[UIColor blackColor]];

    UIButton *btnloc1 = [[[UIButton alloc] initWithFrame:CGRectMake(290, 0, 30, 30)]autorelease]; 
    [btnloc1 setImage:[UIImage imageNamed:@"EtaoLocation.png"] forState:UIControlStateNormal];  
    [btnloc1 addTarget:self action:@selector(locatedMe) forControlEvents:UIControlEventTouchUpInside]; 
    [btnloc1 setTintColor:[UIColor blackColor]];
    
	EtaoLocalListHeadDistanceView *headview1 = [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
    [headview1 addSubview:btnloc];
 	self.listhead = headview1;
	[headview1 release];
	
	EtaoLocalListHeadDistanceView *headview2 = [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 30, 320,30)];
    [headview2 addSubview:btnloc1];
 	self.maphead = headview2;
	[headview2 release];
	
	EtaoLocalClassifyView *tmp = [[EtaoLocalClassifyView alloc] initWithFrame:CGRectMake(0, 0, 320,30.5)]; 
	self.categoryView = tmp ;
	[tmp release]; 
	
	EtaoLocalClassifyView *tmp1 = [[EtaoLocalClassifyView alloc] initWithFrame:CGRectMake(0, 0, 320,30.5)]; 
	self.categoryViewlist = tmp1 ;
	[tmp1 release];
	 
	
	_categoryView.delegate = self;
	_categoryView.typeButtonClickOnSelector = @selector(typeButtonClickOn:); 
	
	_categoryViewlist.delegate = self;
	_categoryViewlist.typeButtonClickOnSelector = @selector(typeButtonClickOn:); 
 
/*	UIBarButtonItem* nav = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"EtaoLocation.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(locatedMe)]autorelease];
	self.navigationItem.leftBarButtonItem = nav; 
 */	 	
	
    NSString *reqSysVer = @"4.0";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending); 
 	
	[_listhead setText:@"正在定位.."]; 
	[_maphead setText:@"正在定位..."];

	// Create location manager with filters set for battery efficiency.
	CLLocationManager *location = [[CLLocationManager alloc] init];
	self.locationManager = location ;
	[location release];
	_locationManager.delegate = self;
	_locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
	
	if (osVersionSupported) { 
		_locationAccessAllowed = [CLLocationManager locationServicesEnabled] ; 
	}
	else {
		_locationAccessAllowed = _locationManager.locationServicesEnabled ;
	}
	
    if ( ![CLLocationManager locationServicesEnabled] || self._LocatedFailed ) {
		[self sayOpenLocationServices];
	}
    
	[_locationManager startUpdatingLocation]; 
	
    
    self.rankbtnv = [[[EtaoLocalNavTitleView alloc] initWithFrame:CGRectMake(0,0,200,30)]autorelease];
	_rankbtnv.delegate = self;
	_rankbtnv.buttonClick = @selector(rankClick:);
	self.navigationItem.titleView = _rankbtnv; 
    
    
//    self.rankView  = [[[ETaoLocalMenuView alloc] initWithFrame:CGRectMake(62.5f, 0.0f, 195.0f, 187.0f)]autorelease];
//	[_rankView addTarget:self action: @selector(rankbtnselected:)];
//	[_listMode addSubview:_rankView];   
               
//    [self.view addSubview:_listMode];

    [self initMapModeView];
    
    if (_slideView == nil) {
        _slideView = [[EtaoTuanHomeViewController alloc] init];
        //[_slideView.view setFrame:CGRectMake(0,0,320,480-44)];
        [self.view addSubview: _slideView.view];
    }
}


-(void) rankClick:(id)sender {
//	if (_rankView._appeared) {
//		UIButton *rankbtn = (UIButton *)sender;
//		rankbtn.selected = YES;
//		_rankbtnv._selected = YES;
//		[_rankbtnv doArrow];
//		[_rankView disappeared];
//	}
//	else {
//		_rankbtnv._selected = NO;
//		[_rankbtnv doArrow];
//		[_rankView appeared];
//	} 
}


-(void) rankbtnselected:(id)sender
{
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*) sender;
		NSLog(@"%d",btn.tag);
		NSString *text = @"5000米";
        
        _distance = 5000;
        
		if (btn.tag == 0) { 
			text = @"10000米";
            _distance = 10000;
		}
		else if(btn.tag == 1){ 
			text = @"5000米";
             _distance = 5000;
		}
		else if(btn.tag == 2){ 
			text = @"2000米";
             _distance = 2000;
		}
		else if(btn.tag == 3){ 
			text = @"1000米";
             _distance = 1000;
		} 
        else if(btn.tag == 4){ 
			text = @"500米";
             _distance = 500;
		}  
        
//		[_rankView disappeared];
		_rankbtnv._selected = YES;
		[_rankbtnv setText:text];
		[_rankbtnv doArrow];
        
        if ( ![CLLocationManager locationServicesEnabled] || self._LocatedFailed ) {
            [self sayOpenLocationServices];
            return ;
        }
        
        [self startCheckUserLocation];
        if (_mapView.userLocation.location == nil) {
            UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘" message:@"定位中，请稍等..." delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil] autorelease];
            [alert show];
            return ;
        }
        
        MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, _distance, _distance);
        [_mapView setRegion:userLocation animated:YES];
        self._lastSearchCoordinate =  _mapView.userLocation.coordinate; 
        [self typeButtonClickOn:_selectedType]; 
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChooseRange" arg2:text arg3:nil];
	}
}


- (void)switchButtonTapped:(EtaoUIBarButtonItem*)sender{
	if ( ![CLLocationManager locationServicesEnabled] || self._LocatedFailed ) {
		[self sayOpenLocationServices];
	}
     
//    [_rankView disappeared];
	_rankbtnv._selected = YES;
	[_rankbtnv doArrow];  
	
    if ([sender isKindOfClass:[EtaoUIBarButtonItem class]]) { 
		if ( [sender.title isEqualToString:@"list"] ) {              
//            [_rankView removeFromSuperview]; 
//            [_listMode addSubview:_rankView]; 
//            [_listMode bringSubviewToFront:_rankView];
//			[_tableView reloadData];
             
			if ([_srpdata count] > 0 ) {
//				[_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
				//[_tableView scrollToRowAtIndexPath:indPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
			} 
            EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"地图" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(switchButtonTapped:)]autorelease];
            switchbtn.title = @"map";
            self.navigationItem.rightBarButtonItem = switchbtn;
             
//            if (  [_mapMode superview] )
//                [_mapMode removeFromSuperview];
            
            
            [UIView beginAnimations:nil context:nil];
 //           [self.view addSubview:_listMode];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.4]; 
            //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];             
            [_slideView.view setFrame:CGRectMake(0, 0, 320, 480-44)];
            [UIView setAnimationDidStopSelector:@selector(finishedMapShadow)];
            [UIView commitAnimations]; 

            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChangeListMode"];
		}
		else 
		{  
            EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"列表" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(switchButtonTapped:)]autorelease];
            switchbtn.title = @"list";
            self.navigationItem.rightBarButtonItem = switchbtn;
			 
            [_mapMode setHidden:NO];
			[self setMapAnnotation]; 
//              
//            if (  [_listMode superview] )
//                [_listMode removeFromSuperview];
                     
            [UIView beginAnimations:nil context:nil]; 
            [UIView setAnimationDuration:0.4];
            //[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];             
                     
            [_mapMode setFrame:CGRectMake(0, 0, 320, 300)];
            [_slideView.view setFrame:CGRectMake(0, 300, 320, 100)];
            [_mapView setFrame:CGRectMake(0, 0, 300, 200)];
            
            [UIView commitAnimations]; 

//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:2];
//            [UIView setAnimationDelegate:self];
//            [UIView setAnimationDidStopSelector:@selector(finishedFading)];
//            self.view.alpha = 0.0;
//            splashImageView1.frame = CGRectMake(0, 0, 320, 160);
//            splashImageView2.frame = CGRectMake(0, 160, 320, 160);
//            splashImageView3.frame = CGRectMake(0, 320, 320, 160);
//            [UIView commitAnimations];
            
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChangeMapMode"];
		} 
	} 	

}


//地图覆盖动画结束，完全被列表覆盖后，隐藏地图，提高List刷新速度
- (void)finishedMapShadow {
    [_mapMode setHidden:YES];
}


- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",indexPath);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	NSLog(@"%@",scrollView);
//	[_rankView disappeared];
	_rankbtnv._selected = YES;
	[_rankbtnv doArrow]; 
}

 
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
	NSLog(@"scrollViewDidScrollToTop");	
	
}

- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",scrollPosition);
	
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
	self._LocatedFailed = YES; 
    [self sayOpenLocationServices];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{	 
	self._LocatedFailed = NO;
	double dist = 0.0;
	if (_userlocation != nil) {
		dist = [userLocation.location distanceFromLocation:_userlocation ];  
		if (dist < 800.00) {
			return ;
		}
	}  
	self.userlocation =userLocation.location; 
 	
#ifdef __TEST__
    self.userlocation = [[[CLLocation alloc]initWithLatitude:31.230381 longitude:121.473727]autorelease]; // {31.230381,121.473727};
#endif
    
    MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(_userlocation.coordinate, _distance, _distance);
	[_mapView setRegion:userLoc animated:NO];
	self._lastSearchCoordinate =  _mapView.region.center;
	if ( !self._isLocated  || dist > 800.00) {  		
		self._isLocated = YES; 
		[self typeButtonClickOn:self._selectedType];
		return;
	}
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
	[self sayOpenLocationServices];
	[_listhead setText:@"定位失败"]; 
	[_maphead  setText:@"定位失败"];
	//[self sayOpenLocationServices];
	self._LocatedFailed = YES; 
	[_locationManager stopUpdatingLocation];
	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:30.0];
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
  
	[_locationManager stopUpdatingLocation]; 
//	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:3.0];
	if (!_locationAccessAllowed) {
		return ;
	} 
	if (_userlocation != nil) {
		return ;
	}
 	 
	
	//MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1000, 1000);
	self.userlocation = newLocation; 
	self._LocatedFailed = NO; 
	MKCoordinateRegion userLoc = MKCoordinateRegionMakeWithDistance(_userlocation.coordinate, _distance, _distance);
	[_mapView setRegion:userLoc animated:NO]; 
	self._lastSearchCoordinate =  _mapView.region.center;
	if (!self._isLocated) {
		self._isLocated = YES;
		[self typeButtonClickOn:self._selectedType];
	}  
}


- (void) typeButtonClickOn:(NSString*)type { 
    
//    [_rankView disappeared];
	_rankbtnv._selected = YES;
	[_rankbtnv doArrow];  
    
	self._selectedType = type;  
	[_categoryViewlist setSelected:type];
	[_categoryView setSelected:type];
	 
	if ( ![CLLocationManager locationServicesEnabled] || self._LocatedFailed ) {
		[self sayOpenLocationServices];
	}
	
	if ( self._lastSearchCoordinate.latitude == 0 && _userlocation == nil) {
		return ;
	}
	
	MKMapRect mRect = _mapView.visibleMapRect;
	MKMapPoint minMapPoint = MKMapPointMake(mRect.origin.x  , mRect.origin.y );  
	CLLocationCoordinate2D mCoord = MKCoordinateForMapPoint(minMapPoint); 	
	self._deltaLatitude = fabs(_mapView.region.center.latitude - mCoord.latitude);
	self._deltaLongitude = fabs(_mapView.region.center.longitude - mCoord.longitude);  
	 
//	if ([_listMode superview]) {        
//	/*	ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
//		[loadv startAnimating];
//		[self.view addSubview:loadv]; 
//		[self.view bringSubviewToFront:loadv]; */
//		[_listhead setText:@"正在加载..."];
//		//_tableView.hidden = YES;
//	}
	[_maphead setText:@"正在加载..."];
	[_srpdata clear];
	
	NSArray *tmp = [NSArray arrayWithArray:_mapView.annotations];
	for (id anno in tmp) { 
		if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalDiscountItem") ]) {
			[_mapView removeAnnotation:anno];
		} 
	}
	
//	[_tableView reloadData];
	[self loadMoreFrom:0 TO:20 withType:type];  
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__); 
//    [_rankView disappeared];
	_rankbtnv._selected = YES;
	[_rankbtnv doArrow];  
}

- (void)locatedMe{
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-StylePositioning"];
    
	if ( ![CLLocationManager locationServicesEnabled] || self._LocatedFailed ) {
		[self sayOpenLocationServices];
		return ;
	}

//    [_rankView disappeared];
	_rankbtnv._selected = YES;
	[_rankbtnv doArrow];  
    
	[self startCheckUserLocation];
	if (_mapView.userLocation.location == nil) {
		UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘"   message:@"定位中，请稍等..."   delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil] autorelease];
		[alert show];
		return ;
	}
	MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, _distance, _distance);
	[_mapView setRegion:userLocation animated:YES];
	self._lastSearchCoordinate =  _mapView.userLocation.coordinate; 
	[self typeButtonClickOn:_selectedType]; 
    
    
}

- (void)FootButtonPress:(id)sender{
	if ([_srpdata count]== 0) {
		return ;
	}
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*) sender; 
		if (btn.tag == 1 ) { 
			int idx = self._lastSelectIdx  ;
			if (_curselectAnnotation != nil) {
				idx = [_srpdata.items indexOfObject:_curselectAnnotation];
			} 
			if (idx == 0 ) {
				return ;
			}  			
			[self setSelectedAnnotation:[_srpdata.items objectAtIndex:idx-1]];
		}
		else if ( btn.tag == 2 ){ 
			
			int idx = self._lastSelectIdx  ;
			if (_curselectAnnotation != nil) {
				idx = [_srpdata.items indexOfObject:_curselectAnnotation];
			} 
			
			if (idx >= _srpdata._totalCount - 1) {
				return;
			}
			if ( idx == [_srpdata.items count] -1 ) {  
				MapLoadingView *loading = [[[MapLoadingView alloc] initWithFrame:CGRectMake(140.0f,280.0f ,40.0f, 40.0f) Message:@"正在搜索"]autorelease];
				[self.view addSubview:loading];
				
				[self loadMoreFrom:[_srpdata.items count] TO:20 withType:_selectedType];
			}
			else {
				[self setSelectedAnnotation:[_srpdata.items objectAtIndex:idx+1]];
			}
		}
		else {
			if ( ![CLLocationManager locationServicesEnabled] || self._LocatedFailed ) {
				[self sayOpenLocationServices];
				return ;
			}
			if (_mapView.userLocation.location == nil) {
				UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘"   message:@"定位中，请稍等..."   delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil] autorelease];
				[alert show];
				return ;
			}
			MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, 1000.0, 1000.0);
			[_mapView setRegion:userLocation animated:YES];
			self._lastSearchCoordinate =  _mapView.userLocation.coordinate; 
			[self typeButtonClickOn:_selectedType]; 
		} 
	} 
}

- (void)setMapAnnotation{
	
	NSArray *tmp = [NSArray arrayWithArray:_mapView.annotations];
	
	for (id anno in tmp) { 
		if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalDiscountItem") ]) {
			[_mapView removeAnnotation:anno];
		} 
	} 
	[_mapView addAnnotations:_srpdata.items]; 
	
	//if ([_srpdata.items count] > 0 ) { 
	//	[self setSelectedAnnotation:[_srpdata objectAtIndex:0]];
	//} 
}
 

- (void) JustLogInfo{
	 
	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = nil;
	httpquery.requestDidFailedSelector = nil; 
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"]; 
	 
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1]; 
//	if ([_listMode superview]){
//		NSString *loginfo = [NSString stringWithFormat:@"%@;list;local",[UIDevice currentDevice].uniqueIdentifier];
//		[dict setValue:loginfo forKey:@"_app_from_"];
//	}else {
		NSString *loginfo = [NSString stringWithFormat:@"%@;map;local",[UIDevice currentDevice].uniqueIdentifier];
		[dict setValue:loginfo forKey:@"_app_from_"];	
//	}

	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start]; 
	
}

- (void) requestFinished:(EtaoLocalDiscountRequest *)sender {  
	
//	_tableView.hidden = NO;
	self._requestFailed = NO; 
	
	[self JustLogInfo];
//	_listMode.hidden = NO;
	_maphead.hidden = NO ;
	int beforeIdx = [_srpdata count] ;
	EtaoLocalDiscountRequest * request = (EtaoLocalDiscountRequest *)sender; 
	[_srpdata addItemsByJSON:request.jsonString]; 
	
	// 根据经纬度，重新计算到原点的距离，更新引擎的结果
	for(EtaoLocalDiscountItem *tbdicount in _srpdata.items){ 
		CLLocation *dest = [[[CLLocation alloc] initWithLatitude:tbdicount.coordinate.latitude longitude: tbdicount.coordinate.longitude]autorelease]; 
		tbdicount.shopDistance = [NSString stringWithFormat:@"%0.2f",[[_locationManager location] distanceFromLocation:dest]/1000]; 
		[_maphead setTextForLocal:tbdicount.shopDistance Total:_srpdata._totalCount Now:1];

	}  
	
//	if ([_listMode superview]) { 
////		[_tableView reloadData];
//		if ([_srpdata.items count] == 0 ) { 
//			[_listhead setText:[NSString stringWithFormat:@"附近没有团购呢..."]];
//		} 
//
//	}
//	else 
//	{ 
		if ([_srpdata.items count] == 0 ) { 
			[_maphead setText:[NSString stringWithFormat:@"附近没有团购呢..."]];
		} 
		_e = _s + [_srpdata count];
		
		NSArray *tmp = [NSArray arrayWithArray:_mapView.annotations];
		
		for (id anno in tmp) { 
			if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalDiscountItem") ]) {
				[_mapView removeAnnotation:anno];
			} 
		}

		
		[_mapView addAnnotations:_srpdata.items]; 	
		
		for ( UIView *v in [self.view subviews] ){
			if ( [v isKindOfClass:[MapLoadingView class]] ){
				MapLoadingView *loading = (MapLoadingView*)v;
				[loading stopAnimating];
				[v removeFromSuperview];
			}
		}
		if ([_srpdata.items count] > 0 && beforeIdx < [_srpdata.items count]  ) {
			[self setSelectedAnnotation:[_srpdata objectAtIndex:beforeIdx]];
		}  
//	}
 
	self._isLoading = NO; 
	 
}


- (void) requestFailed:(EtaoLocalDiscountRequest *)sender{
	self._requestFailed = YES;
	//[EtaoShowAlert showAlert];  
    [[ETaoNetWorkAlert alert]show];
	//UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
	for ( UIView *v in [self.view subviews] ){
		if ( [v isKindOfClass:[MapLoadingView class]] ){
			MapLoadingView *loading = (MapLoadingView*)v;
			[loading stopAnimating];
			[v removeFromSuperview];
		}
	}
	
//	_categoryViewlist.hidden = YES;
//	_maphead.hidden = YES ;
	NSLog(@"retainCount=%d",[sender retainCount]); 
	
//	[_tableView reloadData];
	_isLoading = NO ;
}



- (void) loadMoreFrom:(int)s TO:(int)n withType:(NSString*)type{
	if ( _isLoading == YES ) {
		//return ;
	} 
	for ( UIView *v in [self.view subviews] ){ 
		if ( [v isKindOfClass:[MapLoadingView class]] ){
			MapLoadingView *loading = (MapLoadingView*)v;
			[loading startAnimating];
		}
	}
	_s = s;
	_e = s+n;
	EtaoLocalDiscountRequest *httpquery = [[[EtaoLocalDiscountRequest alloc]init]autorelease];  
    self.tuanhttpquery = httpquery;
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._lastSearchCoordinate.latitude] forKey:@"dist_x"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._lastSearchCoordinate.longitude] forKey:@"dist_y"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._deltaLatitude] forKey:@"dist_x_delta"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._deltaLongitude] forKey:@"dist_y_delta"];
	[httpquery addParam:type forKey:@"discount_type"];
	[httpquery addParam:[NSString stringWithFormat:@"%d",s] forKey:@"s"];
	[httpquery addParam:[NSString stringWithFormat:@"%d",n-s] forKey:@"n"];
	[httpquery start];	
	_isLoading = YES; 	
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    
	static NSString * locationIdentifier = @"LocationPoint";
	if ([annotation isKindOfClass:[EtaoLocalDiscountItem class]]) { 
		
		NSString *imageUnselectedName = [self imageNameForAnnotaion:annotation];
		UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", imageUnselectedName]];
		
		
        MKAnnotationView * pinAnnotationView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:locationIdentifier];
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
		_curselectAnnotation = (EtaoLocalDiscountItem*)view.annotation ; 
		NSString *imageUnselectedName = [self imageNameForAnnotaion:view.annotation];
		view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected.png", imageUnselectedName]]; 
		int idx = [_srpdata.items indexOfObject:_curselectAnnotation]+1;
		[_maphead setTextForLocal:_curselectAnnotation.shopDistance Total:_srpdata._totalCount Now:idx]; 	}
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view { 
	//	self.curselectAnnotation = nil ;
 	if ([view.annotation isKindOfClass:[EtaoLocalDiscountItem class]]) {
        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self imageNameForAnnotaion:view.annotation]]];
    }   
}


- (void) setSelectedAnnotation:(id < MKAnnotation >)annotation {
	_curselectAnnotation = (EtaoLocalDiscountItem*)annotation; 
	self._lastSelectIdx = [_srpdata.items indexOfObject:_curselectAnnotation];
	[_mapView  selectAnnotation:_curselectAnnotation animated:YES]; 
	
}


- (void) setDeselectedAnnotation:(id < MKAnnotation >)annotation {  
	
	[_mapView  deselectAnnotation:annotation animated:YES]; 
	
}


- (void)mapView:(MKMapView *)mapView  annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	//	[self gotoDetail:nil];
}


- (void)gotoDetail:(id)sender { 	
	
	EtaoLocalDiscountDetailController * detailController = [[[EtaoLocalDiscountDetailController alloc] init ]autorelease];
	detailController.item = _curselectAnnotation ; 
	if (_userlocation == nil) {
		detailController.userLocation = nil;
	}
	else 
	{
		detailController.userLocation = _userlocation;
	} 	
	detailController.tableview.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
	detailController.title =@"详情";
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[_mapView  deselectAnnotation:_curselectAnnotation animated:YES]; 
	 
	if ( self._hidden) {
		[self setHidden:self._hidden];
		[self.navigationController pushViewController:detailController animated:NO];
	}
	else 
	{
		[self.navigationController pushViewController:detailController animated:YES]; 
	}
	
}


- (NSString *)imageNameForAnnotaion:(id <MKAnnotation>)annotation {
    NSString * image = nil;
    if ([annotation isKindOfClass:[EtaoLocalDiscountItem class]]) {
		EtaoLocalDiscountItem *item = (EtaoLocalDiscountItem*)annotation;
        switch ([item.itemType intValue]) {
            case EtaoDiscountItemTypeCatering:
                image = @"etao_annotation_catering";
                break;
            case EtaoDiscountItemTypeEntertainment:
                image = @"etao_annotation_entertainment";
                break;
            case EtaoDiscountItemTypeLiving:
                image = @"etao_annotation_living";
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
		CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
		CLLocationCoordinate2D touchMapCoordinate =[_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
		
		//CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
		self._lastSearchCoordinate =  touchMapCoordinate; 
		
		//	MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(touchMapCoordinate, 1000.0, 1000.0);
		//	[self.mapView setRegion:userLocation animated:YES]; 
		EtaoLocalSelectRegionAnnotation * annotation = [[[EtaoLocalSelectRegionAnnotation alloc] init]autorelease];
		annotation.title = @"当前位置";
		annotation.coordinate = touchMapCoordinate;
		NSArray *tmp = [NSArray arrayWithArray:_mapView.annotations];
		for (id anno in tmp) { 
			if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalSelectRegionAnnotation") ]) {
				[_mapView removeAnnotation:anno];
			} 
		} 
		[_mapView addAnnotation:annotation];
		
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
	for(UIView *view in self.navigationController.view.subviews){
		if([view isKindOfClass:[UINavigationBar class]]){   //处理UITabBar视图
			NSLog(@"%@",view);
			if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-74, view.frame.size.width,view.frame.size.height)];
				
			} else {
				if (view.frame.origin.y < 0) {
					[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+74, view.frame.size.width,view.frame.size.height)];

				}
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
	 
	if (hidden) {
		[_categoryView setFrame:CGRectMake(_categoryView.frame.origin.x, _categoryView.frame.origin.y-74, _categoryView.frame.size.width,_categoryView.frame.size.height)];
 	}
	else {
		[_categoryView setFrame:CGRectMake(_categoryView.frame.origin.x, _categoryView.frame.origin.y+74, _categoryView.frame.size.width,_categoryView.frame.size.height)];
		
	}
	 
	if (hidden) {
		[_maphead setFrame:CGRectMake(_maphead.frame.origin.x, _maphead.frame.origin.y-74, _maphead.frame.size.width,_maphead.frame.size.height)];
 	}
	else {
		[_maphead setFrame:CGRectMake(_maphead.frame.origin.x, _maphead.frame.origin.y+74, _maphead.frame.size.width,_maphead.frame.size.height)];
	} 
	
	if (hidden) {
		[_mapView setFrame:CGRectMake(_mapView.frame.origin.x, _mapView.frame.origin.y-74, _mapView.frame.size.width,_mapView.frame.size.height+74+48)];
 	}
	else {
		[_mapView setFrame:CGRectMake(_mapView.frame.origin.x, _mapView.frame.origin.y+74, _mapView.frame.size.width,_mapView.frame.size.height-74-48)];
	}
	
	[UIView commitAnimations]; 
	
	 NSLog(@"%s", __FUNCTION__); 
}


- (void)HideTabBar:(BOOL)hidden{ 	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; 	
	for(UIView *view in self.tabBarController.view.subviews){
		if([view isKindOfClass:[UITabBar class]]){   //处理UITabBar视图
			if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width,view.frame.size.height)];
				
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, 480-48, view.frame.size.width,view.frame.size.height)];			
			}
			
		}else{   //处理其它视图
		 	if (hidden) {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,480)];
				
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,480-48)];
			}
			
		}
		
	} 
	
	UIView *view = _footView;
	if (hidden) {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+48, view.frame.size.width,view.frame.size.height)];
 	}
	else {
		[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-48, view.frame.size.width,view.frame.size.height)];
		
	}
	
	[UIView commitAnimations]; 
	 NSLog(@"%s", __FUNCTION__); 
}



- (void) hidden{ 
	[self setHidden:self._hidden];
}


- (void) setHidden:(BOOL)hidden{
 	 
	
	if ( hidden ) {
		_hidden = NO;
		[self HideTabBar:NO];
		[self HideNavbBar:NO]; 
	}
	else {
		_hidden = YES;
		[self HideTabBar:YES];
		[self HideNavbBar:YES]; 
	}
	
}
 

- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
	//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){  //这个状态判断很重要
	//坐标转换 
	
	EtaoShowMessageView *message = (EtaoShowMessageView*)[self.view viewWithTag:EtaoShowMessageView_TAG];
	if (message != nil) { 
		[message deleteMe];
	} 
	
	CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
	CLLocationCoordinate2D touchMapCoordinate =[_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
	NSLog(@"%f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
	float min = 100.0f ;
	NSArray *tmp = [NSArray arrayWithArray:_mapView.annotations];
	EtaoLocalDiscountItem *sel = nil;
	for (id anno in tmp) { 
		if ( [anno isKindOfClass:NSClassFromString(@"EtaoLocalDiscountItem") ]) { 
			EtaoLocalDiscountItem *an = (EtaoLocalDiscountItem*)anno;
			if (an == _curselectAnnotation) {
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
	
	MKMapRect mRect = _mapView.visibleMapRect; 	
	if ( min < mRect.size.width / 10240000.0f  ) {
		[self setSelectedAnnotation:sel];
	}
	else 
	{
		// 
		if (_curselectAnnotation != nil) {
			[_mapView  deselectAnnotation:_curselectAnnotation animated:YES]; 
			_curselectAnnotation = nil ;
		}
		else {
			[self setHidden:self._hidden];  
			// 
		} 
	}
	
	NSLog(@"%f",min); 
	 NSLog(@"%s", __FUNCTION__); 
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. 	 
	if (_srpdata._totalCount < 0) {
	//	return 1;
	}
	
	if (_srpdata._totalCount <= 0 ) {
		if (self._requestFailed) {
			return 1 ;
		}
		return 0;
	}
	
	if ([_srpdata count] < _srpdata._totalCount) {
        return [_srpdata count] + 1;
    } else {
        return [_srpdata count];
    }
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [EtaoLocalListTableViewCell height];
	
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//	if ( _categoryViewlist.hidden || _srpdata._totalCount < 0) {
//		return 0.0f;
//	}
	return 30.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return _listhead;
}

- (void) reloadLastRequest:(id)sender{ 
	self._isLoading = YES; 
	int count = [_srpdata count];
	[self loadMoreFrom:count TO:count+10 withType:_selectedType]; 

}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"EtaoLocalViewController didReceiveMemoryWarning");
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	_mapView = nil;
//	_tableView = nil; 
    _mapMode = nil ;
//    _listMode = nil ;
    _locationManager = nil; 
	_srpdata = nil;
	_maphead = nil;
	_categoryViewlist = nil;
	_footView = nil;
	_categoryView = nil ;
	_categoryViewlist = nil ;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    _mapView.delegate = nil ;
    _locationManager.delegate = nil ;
//    _tableView.delegate = nil;
    if (_tuanhttpquery != nil) {
        _tuanhttpquery.delegate = nil;
        [_tuanhttpquery release];
    } 
    
	[_mapView release];
//	[_tableView release];
	[_locationManager release];
	[_srpdata release];
	[_maphead release];
	[_listhead release];
    [_mapMode release];
//    [_listMode release];
	[_footView release]; 
	[_categoryView release];
	[_categoryViewlist release];
 	
    [_slideView release];
	
    [super dealloc];
}


@end
