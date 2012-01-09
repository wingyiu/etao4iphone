//
//  EtaoTuanMapController.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanMapController.h"
#import "EtaoTuanHomeViewController.h"

@implementation EtaoTuanMapController
@synthesize datasourceKey = _datasourceKey;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
   
    EtaoGroupBuyAuctionDataSource* datasource1 = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:self.datasourceKey];
    [ datasource1 removeObserver:self forKeyPath:@"status"];
    
    EtaoGroupBuyLocationDataSource* datasource2 = (EtaoGroupBuyLocationDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    [datasource2 removeObserver:self forKeyPath:@"status"];
    
    _mapView.delegate = nil;
    [_mapView release];
    [_datasourceKey release];
    [_items release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];

    //初始化本地数组     
    _items = [[NSMutableArray alloc]init];
    _notification_lock= NO;
    _last_selected = -1;
    
    if (nil == _mapView) {
        _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];
        _mapView.zoomEnabled = YES;
        _mapView.scrollEnabled = YES;
        _mapView.mapType = MKMapTypeStandard;
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        
        
        [self.view addSubview:_mapView]; 
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
    
    //添加消息回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleListSelected:)
                                                 name:ET_NF_GROUPBUY_LIST2MAP_SELECTITEM
                                               object:nil];


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -v MapView Delegate
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

- (void)gotoDetail:(id)sender { 	
    if(_last_selected < _items.count){        
        ETPageSwipeController* detailSwipe = [[[ETPageSwipeController alloc]initWithItems:_items 
                                                                             withDelegate:self 
                                                                                  atIndex:_last_selected 
                                                                            byDetailClass:[EtaoTuanListDetailController class]]autorelease];
        
        [[EtaoTuanHomeViewController getNavgationController] pushViewController:detailSwipe animated:YES];
    }
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
    
	if ([view.annotation isKindOfClass:[EtaoTuanAuctionItem class]]) { 
		EtaoTuanAuctionItem* selectEtaoTuanAuctionItem = (EtaoTuanAuctionItem*)view.annotation ; 
		NSString *imageUnselectedName = [self imageNameForAnnotaion:view.annotation];
		view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@hover.png", imageUnselectedName]]; 
        int index = [_items indexOfObject:selectEtaoTuanAuctionItem];
        _last_selected = index;
        
        //发送消息
        if(!_notification_lock){
            NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init]autorelease];
            [dict setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [dict setObject:_datasourceKey forKey:@"datasourceKey"];
            [[NSNotificationCenter defaultCenter] postNotificationName:ET_NF_GROUPBUY_MAP2LIST_SELECTITEM object:nil userInfo:dict];
        }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view { 
 	if ([view.annotation isKindOfClass:[EtaoTuanAuctionItem class]]) {
        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self imageNameForAnnotaion:view.annotation]]];
    }   
}

#pragma mark -v datasource event respond function

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoGroupBuyAuctionDataSource class]]){
        EtaoGroupBuyAuctionDataSource* datasource = object;
        ET_DS_GROUPBUY_AUCTION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_DS_GROUPBUY_AUCTION_OK: //数据加载完成
                [self items2items:datasource.items toItems:_items];
                break;
            case ET_DS_GROUPBUY_AUCTION_LOADING: //加载数据中
                break;
            default:
                break;
        }
    }
    else if([object isKindOfClass:[EtaoGroupBuyLocationDataSource class]]){
        EtaoGroupBuyLocationDataSource* datasource = object;
        ET_DS_GROUPBUY_LOCATION_STATUS new_status = [[change objectForKey:@"new"] intValue];
        switch (new_status) {
            case ET_DS_GROUPBUY_LOCATION_CHANGE: //定位成功
                {
                    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(datasource.currentLocation.coordinate, DISTANCE, DISTANCE);
                    [_mapView setRegion:userLocation animated:YES];
                    break;
                }
            case ET_DS_GROUPBUY_LOCATION_LOCAL: //定位中
                break;
            default:
                break;
        }

    }
}

#pragma mark -v swipe delegate
- (void)swipeAtIndex:(NSNumber *)index withCtrls:(UIViewController *)controller{
    if([index intValue] > _items.count -5){
        EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource *)[[ETDataCenter dataCenter]getDataSourceWithKey:[EtaoGroupBuyAuctionDataSource keyName:_datasourceKey]];
        [datasource loadmore];
    }
}


#pragma mark -v APIs
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
    
    NSLog(@"%f",self.view.frame.size.height);
    
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, DISTANCE, DISTANCE);
	[_mapView setRegion:userLocation animated:YES];
}

- (void)handleListSelected:(NSNotification*)notification {
    
    NSNumber* index = [[notification userInfo] objectForKey:@"index"];
    if([index intValue]>=[_items count])return;
    EtaoTuanAuctionItem* item = [_items objectAtIndex:[index intValue]];
    if (([item.latitude doubleValue]!=0) && ([item.longitude doubleValue]!=0)) {
        CLLocationCoordinate2D coordinate =  item.coordinate;
        CLLocation* emulocation = [[[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude]autorelease];
        MKCoordinateRegion emuLoc = MKCoordinateRegionMakeWithDistance(emulocation.coordinate, DISTANCE,DISTANCE);
        [_mapView setRegion:emuLoc animated:YES];
        
        //地图上显示已选中的POI
        MKAnnotationView *tempView = [_mapView viewForAnnotation:item];
        if ([tempView.annotation isKindOfClass:[EtaoTuanAuctionItem class]]) { 
            NSString *imageUnselectedName = [self imageNameForAnnotaion:tempView.annotation];
            tempView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@hover.png", imageUnselectedName]]; 
            _notification_lock = YES;
            [_mapView selectAnnotation:tempView.annotation animated:YES];
            _notification_lock = NO;
        }
    }
    else{
        if(_last_selected == -1)return;
        if(_last_selected >= _items.count){
            _last_selected = -1;
            return;
        }
        EtaoTuanAuctionItem* selectEtaoTuanAuctionItem = [_items objectAtIndex:_last_selected];
        [_mapView deselectAnnotation:selectEtaoTuanAuctionItem animated:YES];
        _last_selected = -1;
    }
}

#pragma mark -v Watch
/* 监视相关*/

- (void)watchWithKey:(NSString *)key{
    //去除上一个watch的auction
    EtaoGroupBuyAuctionDataSource* last_datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:self.datasourceKey];
    [ last_datasource removeObserver:self forKeyPath:@"status"];
    
    //watch新的auction
    self.datasourceKey = key;
    EtaoGroupBuyAuctionDataSource* new_datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    [new_datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
    _last_selected = -1;
    [self items2items:new_datasource.items toItems:_items];
}

- (void)watchWithDatasource:(id)datasource{
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
    EtaoGroupBuyLocationDataSource* ds = (EtaoGroupBuyLocationDataSource*)datasource;
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(ds.currentLocation.coordinate, DISTANCE, DISTANCE);
	[_mapView setRegion:userLocation animated:YES];
}

#pragma mark -v logic function
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

- (void)items2items:(NSMutableArray*)items1 toItems:(NSMutableArray*)items2{
    //已显示的数据集合
   
    NSMutableArray* oriArray = [items2 copy];
    NSSet* oriSet = [[[NSSet alloc]initWithArray:oriArray]autorelease];
    
    [items2 removeAllObjects];
    EtaoTuanAuctionItem* item;
    for (item in items1){
        [items2 addObject:item];
        //如果存在了，就不重画
        if([oriSet containsObject:item])continue;
        [_mapView addAnnotation:item]; 
    }
    
    //新宝贝的数据集合
    NSSet* newSet = [[[NSSet alloc]initWithArray:items1]autorelease];
    for(item in oriArray){
        //如果存在了，就不删除
        if([newSet containsObject:item])continue;
        [_mapView removeAnnotation:item];
    }
    [oriArray release];
    
}
@end
