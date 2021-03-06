    //
//  EtaoLocalListController.m
//  etao4iphone
//
//  Created by iTeam on 11-8-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalListController.h" 
#import "EtaoLocalListTableViewCell.h"
#import "NSObject+SBJson.h"

#import "EtaoLocalDiscountRequest.h"
#import "EtaoLocalListHeadDistanceView.h"
#import "EtaoLocalDiscountItem.h"
#import "EtaoLocalClassifyView.h"

@implementation EtaoLocalListController

@synthesize _srpdata; 
@synthesize _isLoading;
@synthesize _userLocation;
@synthesize _locationManager;
@synthesize tableView;
@synthesize _head;
@synthesize _parent;
@synthesize _selectedType ;
@synthesize _lastSearchCoordinate ;  
@synthesize _deltaLatitude ;
@synthesize _deltaLongitude ; 
#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


#pragma mark -
#pragma mark View lifecycle

- (id)initWithdataSource:(EtaoLocalListDataSource*)datas {
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	self = [super init];
	if (self) {
		self._srpdata = datas ;
		// Custom initialization.
	}
	return self;
}

- (id)init{
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	self = [super init];
	if (self) {
		EtaoLocalListDataSource * datas = [[EtaoLocalListDataSource alloc]init];
		self._srpdata = datas ;
		[datas release];
	}
	return self;
}
- (void)loadView {
    [super loadView]; 
    
	UITableView * aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height) style:UITableViewStylePlain];   
	aTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[aTableView setDelegate:self]; 
	[aTableView setDataSource:self];
	self.tableView = aTableView;
	[aTableView release];
    [self.view addSubview:self.tableView];
 	
	
	self._isLoading = NO; 
	
	self._selectedType = @"all";
	
//	EtaoLocalListDataSource * datas = [[EtaoLocalListDataSource alloc]init];
//	self._srpdata = datas ;
//	[datas release];
	
	// Create location manager with filters set for battery efficiency.
	CLLocationManager *locationManager = [[CLLocationManager alloc] init];
	self._locationManager = locationManager;
	self._locationManager.delegate = self;
	self._locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
	self._locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	// Start updating location changes.
	[self._locationManager startUpdatingLocation]; 
	[locationManager release];
	/*		
	 EtaoLocalDiscountRequest *httpquery = [[[EtaoLocalDiscountRequest alloc]init]autorelease];  
	 httpquery.delegate = self;
	 httpquery.requestDidFinishSelector = @selector(requestFinished:);
	 httpquery.requestDidFailedSelector = @selector(requestFailed:);
	 
	 [httpquery addParam:@"31.230381" forKey:@"dist_x"];
	 [httpquery addParam:@"121.473727" forKey:@"dist_y"];
	 [httpquery addParam:@"0.6143" forKey:@"dist_x_delta"];
	 [httpquery addParam:@"0.6180" forKey:@"dist_y_delta"];
	 [httpquery addParam:@"all" forKey:@"discount_type"];
	 [httpquery addParam:@"0" forKey:@"s"];
	 [httpquery addParam:@"10" forKey:@"n"];
	 
	 [httpquery start]; 
	 */
	// Your implementation here
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"搜索结果";
	
	EtaoLocalListHeadDistanceView *headview = [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
 	self._head = headview;
	[self.view addSubview:headview];
    [headview release]; 
	
	EtaoLocalClassifyView *tmp = [[EtaoLocalClassifyView alloc] initWithFrame:CGRectMake(0, 0, 320,30)]; 
	tmp.delegate = self;
	tmp.typeButtonClickOnSelector = @selector(typeButtonClickOn:);
	self.tableView.tableHeaderView = tmp;
	[tmp release]; 
	
}


- (void) requestFinished:(EtaoLocalDiscountRequest *)sender { 
	EtaoLocalDiscountRequest * request = (EtaoLocalDiscountRequest *)sender;
	[self._srpdata addItemsByJSON:request.jsonString];
	[self.tableView reloadData];
	self._isLoading = NO; 
	
}


- (void) requestFailed:(EtaoLocalDiscountRequest *)sender{ 
	NSLog(@"retainCount=%d",[sender retainCount]);
	self._isLoading = NO; 
}

- (void) typeButtonClickOn:(NSString*)type { 
	self._selectedType = type;
	[self._srpdata clear];
	[self.tableView reloadData];
	[self loadMoreFrom:0 TO:10];
	
}

- (void) loadMoreFrom:(int)s TO:(int)e {
	if (self._userLocation == nil) {
		return ;
	}
	EtaoLocalDiscountRequest *httpquery = [[[EtaoLocalDiscountRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);

	[httpquery addParam:[NSString stringWithFormat:@"%f",self._userLocation.coordinate.latitude] forKey:@"dist_x"];
	[httpquery addParam:[NSString stringWithFormat:@"%f",self._userLocation.coordinate.longitude] forKey:@"dist_y"];
	[httpquery addParam:_selectedType forKey:@"discount_type"];
	[httpquery addParam:[NSString stringWithFormat:@"%d",s] forKey:@"s"];
	[httpquery addParam:[NSString stringWithFormat:@"%d",e-s] forKey:@"e"];
	[httpquery start]; 
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",indexPath);
	
}

 
/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
	if (self._userLocation == nil) { 
		
		self._userLocation = newLocation ;
		
		EtaoLocalDiscountRequest *httpquery = [[[EtaoLocalDiscountRequest alloc]init]autorelease];  
		httpquery.delegate = self;
		httpquery.requestDidFinishSelector = @selector(requestFinished:);
		httpquery.requestDidFailedSelector = @selector(requestFailed:); 		
		[httpquery addParam:[NSString stringWithFormat:@"%f",self._userLocation.coordinate.latitude] forKey:@"dist_x"];
		[httpquery addParam:[NSString stringWithFormat:@"%f",self._userLocation.coordinate.longitude] forKey:@"dist_y"];
		//		[httpquery addParam:@"0.6143" forKey:@"dist_x_delta"];
		//		[httpquery addParam:@"0.6180" forKey:@"dist_y_delta"];
		[httpquery addParam:@"all" forKey:@"discount_type"];
		[httpquery addParam:@"0" forKey:@"s"];
		[httpquery addParam:@"10" forKey:@"n"];
		
		[httpquery start]; 
		
	}
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. 	 
    int totalCount = self._srpdata._totalCount;
    if (totalCount == -1) {
        return 1;
    } else if ([self._srpdata count] < totalCount) {
        return [self._srpdata count] + 1;
    } else {
        return [self._srpdata count];
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
	return 30.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return self._head;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// 	static NSString *itemCellId = @"itemCell";
	NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d",[indexPath row]] ;	
	static NSString *moreCellId = @"moreCell"; 
	
	NSUInteger row = [indexPath row];
	NSUInteger count = [self._srpdata count]; 
	
	if (row < count) {
		EtaoLocalDiscountItem *item = (EtaoLocalDiscountItem*)[self._srpdata.items objectAtIndex:row];
		[self._head setText:[NSString stringWithFormat:@"%@公里以内",item.shopDistance]];
	}

	
	if (row == count ) {
		
		UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:moreCellId];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
			
			cell.textLabel.text = @"正在加载";
			cell.textLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
			cell.textLabel.textAlignment = UITextAlignmentCenter; 
			
			UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
			activityIndicator.frame = CGRectMake(cell.frame.size.width/2  - 60  ,cell.frame.size.height - 10  , 20.0f, 20.0f);
			activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
			[cell addSubview:activityIndicator];
			[activityIndicator startAnimating]; 
			cell.selectionStyle = UITableViewCellSelectionStyleNone ;
		}	 
		return cell;  
	}
	else 
	{  
		EtaoLocalListTableViewCell* cell = (EtaoLocalListTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:itemCellId];
		if (cell == nil) {
			cell = [[[EtaoLocalListTableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:itemCellId] autorelease];  
 		}	
		EtaoLocalDiscountItem *currentItem = [self._srpdata objectAtIndex:row];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		[cell set:currentItem]; 
		cell._idx = row;
		return cell; 
	} 
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	//UIColor *color = ((indexPath.row % 2) == 0) ? [UIColor colorWithRed:255.0/255 green:255.0/255 blue:145.0/255 alpha:1] : [UIColor clearColor];
	//cell.backgroundColor = [UIColor lightGrayColor];
	
	NSUInteger row = [indexPath row];
	NSUInteger count = [self._srpdata count];  
	// load more
	
	for (id c in self.tableView.visibleCells) {
		if ([ c isKindOfClass:[EtaoLocalListTableViewCell class]]) {
			EtaoLocalListTableViewCell *vc = (EtaoLocalListTableViewCell*)c ; 
			[self._head setText:[NSString stringWithFormat:@"距离您的位置大约%@公里(%d/%d)",vc._item.shopDistance,vc._idx+1,self._srpdata._totalCount]];
		}
	}
	
	if (row == count ) {
		
		if (self._isLoading == YES) {
			return;
		} 
 		self._isLoading = YES; 
		[self loadMoreFrom:count TO:count+10];
		//[self performSelector:@selector(loadMoreFrom:) withObject:count withObject:count+10  afterDelay:0.2];
	} 
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	
	int row = [indexPath row];
	EtaoLocalDiscountDetailController * detailController = [[[EtaoLocalDiscountDetailController alloc]init ]autorelease];
	detailController.item = [self._srpdata objectAtIndex:row]; 
	detailController.userLocation = nil;
	
	detailController.tableview.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
	detailController.title =@"详情"; 
	if (_parent != nil) {
		[_parent.navigationController pushViewController:detailController animated:YES];
	}
	else {
		[self.navigationController pushViewController:detailController animated:YES];
	} 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	self._srpdata = nil;
	self._head = nil;
	self._locationManager = nil ;
}


- (void)dealloc {
	[_head release];
	[_locationManager release];
	[_srpdata release];
    [super dealloc];
}


@end
