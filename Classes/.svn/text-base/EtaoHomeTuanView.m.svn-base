//
//  EtaoHomeTuanView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoHomeTuanView.h"
#import "EtaoSystemInfo.h"

@implementation EtaoHomeTuanView
@synthesize typeButtonClickOnSelector ;
@synthesize delegate;
@synthesize _locationManager ;
@synthesize _userLocation ;
@synthesize _reverseGeocoder ;
@synthesize _retry;
@synthesize _mapView ;
@synthesize _mapViewLocated ;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 75.0f, 30.0f)];
		title.text = @"附近团购";
		title.backgroundColor = [UIColor clearColor]; 
		title.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
		[self addSubview:title];
		[title release];
		
		UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40.0f, 300,1)];
		line.backgroundColor =  [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0];
		[self addSubview:line]; 
		[line release];

		UIImageView *pin = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"EtaoHomeLocation.png"]];
		pin.frame = CGRectMake(80.0f, 15.0f, 15.0f,18.0f);
		pin.tag = 101 ;
		pin.alpha = 0.0; 
		[self addSubview:pin];	
		[pin release];
		
		UILabel *place = [[UILabel alloc] initWithFrame:CGRectMake(95.0f, 13.0f, 200.0f, 30.0f)];
		place.text = @"";
		place.font = [UIFont systemFontOfSize:12]; 
		place.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
		place.backgroundColor = [UIColor clearColor]; 
		place.tag = 102;
		place.alpha = 0.0; 
		[self addSubview:place];
		[place release];
		
		
		UIButton *food = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 50.0f, 90.0f, 40.0f)]; 
		[food setTitle:@"catering" forState:UIControlStateNormal];
		[food setImage:[UIImage imageNamed:@"EtaoHomeTuanFood.png"] forState:UIControlStateNormal];
		[food addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:food];
		[food release];
		
		UIButton *life = [[UIButton alloc] initWithFrame:CGRectMake(105.0f, 50.0f, 90.0f, 40.0f)]; 
		[life setTitle:@"living" forState:UIControlStateNormal];
		[life setImage:[UIImage imageNamed:@"EtaoHomeTuanLife.png"] forState:UIControlStateNormal];
		[life addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:life];
		[life release];
		
		UIButton *enter = [[UIButton alloc] initWithFrame:CGRectMake(210.0f, 50.0f, 90.0f, 40.0f)];
		[enter setTitle:@"entertainment" forState:UIControlStateNormal];
		[enter setImage:[UIImage imageNamed:@"EtaoHomeTuanEnter.png"] forState:UIControlStateNormal];
		[enter addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:enter];
		[enter release];
		
		CLLocationManager *locationManager = [[CLLocationManager alloc] init];
		self._locationManager = locationManager;
		self._locationManager.delegate = self;
		self._locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
		self._locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		
        // Start updating location changes.
		// [self._locationManager startUpdatingLocation]; 
		[locationManager release];
		
		/* 
		MKMapView *map = [[MKMapView alloc]initWithFrame:CGRectMake(0,0,0,0)];
		self._mapView = map ;
		[map release];
		self._mapView.mapType = MKMapTypeStandard;
		self._mapView.showsUserLocation = YES;
		self._mapView.delegate = self; 
		 */
		_mapViewLocated = NO ;
		_retry = 0;
		
		
    }
    return self;
}

- (void) downButtonPressed:(id)sender
{
 	UIButton *button = (UIButton*)sender ;
	for (UIView *subView in [button.superview subviews]) {//遍历这个view的subViews
        if ([subView isKindOfClass:NSClassFromString(@"UIButton")] )
		{	  
			UIButton *btn = (UIButton*) subView;
			if (btn.selected) {
				[btn setSelected:NO];
			} 
			
		}
	} 
	[button setSelected:YES]; 	
	if (self.delegate && self.typeButtonClickOnSelector && [delegate respondsToSelector:self.typeButtonClickOnSelector]) {
		[delegate performSelectorOnMainThread:self.typeButtonClickOnSelector withObject:button.titleLabel.text waitUntilDone:YES];
	}
}

- (void) startCheckUserLocation{
	self._mapView.showsUserLocation = YES ;
//	if (self._locationManager != nil) {
//		[self._locationManager startUpdatingLocation]; 
//	}  
	
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{ 
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{ 
	_mapViewLocated = YES;
	
	//UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"定位" message:@"hi" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]autorelease];[alert show]; 
	
	self._mapView.showsUserLocation = NO ;
	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:60.0];
	double dist = 0.0;
	if (self._userLocation == nil) {
		UIImageView *pin = (UIImageView*)[self viewWithTag:101];
		pin.alpha = 0.0; 
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		pin.alpha = 1.0;
		[UIView commitAnimations];   
		
	} 
	else {   
		dist = [[userLocation location] distanceFromLocation:self._userLocation ];  
		if (dist < 500.00) { 
			return ;
		} 
	}  	 
	
	
	EtaoSystemInfo *etaosys =  [EtaoSystemInfo sharedInstance];
	etaosys.userLocation = [NSString stringWithFormat:@"%f,%f",[userLocation location].coordinate.longitude,[userLocation location].coordinate.latitude];
	
	self._userLocation = userLocation.location;
	self._reverseGeocoder = [[[MKReverseGeocoder alloc] initWithCoordinate:self._userLocation.coordinate]autorelease];
	self._reverseGeocoder.delegate = self; 
	[self._reverseGeocoder start];
	self._retry = 1 ; 
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:10.0];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation); 
	EtaoSystemInfo *etaosys =  [EtaoSystemInfo sharedInstance];
	etaosys.userLocation = [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude];
	
	if (_mapViewLocated) {
		return ;
	}
	[self._locationManager stopUpdatingLocation];
	[self performSelector:@selector(startCheckUserLocation) withObject:nil  afterDelay:30.0];
	double dist = 0.0;
	if (self._userLocation == nil) {
		UIImageView *pin = (UIImageView*)[self viewWithTag:101];
		pin.alpha = 0.0; 
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		pin.alpha = 1.0;
		[UIView commitAnimations];   
		
	} 
	else {   
		dist = [newLocation distanceFromLocation:self._userLocation ];  
		if (dist < 500.00) { 
			return ;
		} 
	}  	
	/*
	NSString *ss = [NSString stringWithFormat:@"%@,%f",self._userLocation ,dist];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:ss delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];*/
	
	self._userLocation = newLocation;
	self._reverseGeocoder = [[[MKReverseGeocoder alloc] initWithCoordinate:self._userLocation.coordinate]autorelease];
	self._reverseGeocoder.delegate = self; 
	[self._reverseGeocoder start];
	self._retry = 1 ; 
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    NSLog(@"%s", __FUNCTION__); 
	NSString *address = [NSString stringWithFormat:@"%@%@%@%@", 
						 // placemark.country,
						 placemark.administrativeArea,
						 placemark.locality,
						 placemark.subLocality,
						 placemark.thoroughfare
						 // placemark.subThoroughfare
						 ];
	 
	EtaoSystemInfo *etaosys =  [EtaoSystemInfo sharedInstance];
	etaosys.userLocationDetail = address;
	
	UILabel *place = (UILabel*)[self viewWithTag:102];
	place.text = [NSString stringWithFormat:@"位置:%@",address];
	place.alpha = 0.0; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	place.alpha = 1.0;
	[UIView commitAnimations]; 
	 
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	NSLog(@"%s", __FUNCTION__);  
	self._retry += 1 ;
	[NSThread sleepForTimeInterval:2];
	if ( self._retry < 20) {
		[self._reverseGeocoder start];
	} 
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[_reverseGeocoder release]; 
	
    [super dealloc];
}


@end
