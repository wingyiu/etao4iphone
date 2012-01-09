    //
//  EtaoSRPController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRPController.h"
#import "EtaoSRPCell.h"
#import "EtaoLoadMoreCell.h"
#import "EtaoSRPHomeController.h"
#import "NSObject+SBJson.h"
#import "EtaoCategoryNavController.h"
#import "EtaoShowAlert.h"
#import "EtaoNoResultView.h"
#import "ActivityIndicatorMessageView.h"
#import "EtaoAuctionPriceCompareHistoryViewController.h"

#import "ETaoHistoryViewController.h"
#import "etao4iphoneAppDelegate.h"
#import "EtaoSystemInfo.h"
#import "EtaoUIBarButtonItem.h"


@implementation EtaoSRPController
@synthesize _srpdata; 
@synthesize _isLoading; 
@synthesize _tableView; 
@synthesize _keyword;
@synthesize _head ;
@synthesize _ppath;
@synthesize _catid;
@synthesize _rankView ;
@synthesize _sort ;
@synthesize detailDirect = _detailDirect ;
@synthesize _rankbtnv ;
@synthesize _requestFailed ;
@synthesize _httpquery ;

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
//[self sort:@"shopDistance"];
 


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];     
     
	EtaoUIBarButtonItem* nav = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"筛选" bkColor:[UIColor lightGrayColor] target:self action:@selector(navButtonTapped:)]autorelease];
    
//  UIBarButtonItem *nav = [[[UIBarButtonItem alloc]initWithTitle:@"dd" style:UIBarButtonItemStyleBordered target:self action:@selector(navButtonTapped:)]autorelease];
                                  
	self.navigationItem.rightBarButtonItem = nav; 
 	
	UITableView * tablev = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];   
	tablev.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self._tableView = tablev;
	[tablev release];
	[self._tableView setDelegate:self];  
	[self._tableView setDataSource:self];
    self._tableView.separatorStyle = YES;
    [self._tableView setBackgroundColor:[UIColor whiteColor]];//colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0]];
   
    [self._tableView setSeparatorColor:[UIColor colorWithRed:232/255.0f green:232/255.0f blue:232/255.0f alpha:1.0]];
    
    [self.view addSubview:_tableView];
	 	
	self._isLoading = NO; 
	self._requestFailed = NO;
	
	EtaoSRPDataSource * datas = [[EtaoSRPDataSource alloc]init];
	self._srpdata = datas ;
	[datas release];
	
	EtaoLocalListHeadDistanceView *headview = [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
 	self._head = headview;
	[self.view addSubview:headview];
    [headview release];
	
	UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
	self._tableView.tableHeaderView = tmp;
	[tmp release];
	 
	
	EtaoMenuView *pop = [[EtaoMenuView alloc] initWithFrame:CGRectMake(62.5f, 0.0f, 195.0f, 153.0f)];
	self._rankView = pop ; 
	[pop addTarget:self action: @selector(rankbtnselected:)];
	[self.view addSubview:pop]; 
	[pop release];
	
    
//	[self._srpdata clear];
//	[self._tableView reloadData];
	 
//	[self loadMoreFrom:0 TO:10]; 
}


- (void)navButtonTapped:(id)sender { 
  //   if ([sender isKindOfClass:[UIBarButtonItem class]]) {	
    EtaoCategoryNavController * catNavController = [[[EtaoCategoryNavController alloc] initWithWord:_keyword cat:_catid pidvid:_ppath ]autorelease]; 
    
    [self.navigationController pushViewController:catNavController animated:YES]; 
    
    [self._rankView disappeared];
    self._rankbtnv._selected = YES;
    [self._rankbtnv doArrow]; 
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-CategoryFilter"];
		
 //	}
}  
 

-(void) rankClick:(id)sender
{
	if (self._rankView._appeared) {
		UIButton *rankbtn = (UIButton *)sender;
		rankbtn.selected = YES;
		self._rankbtnv._selected = YES;
		[self._rankbtnv doArrow];
		[self._rankView disappeared];
	}
	else {
		self._rankbtnv._selected = NO;
		[self._rankbtnv doArrow];
		[self._rankView appeared];
	} 
}


-(void) rankbtnselected:(id)sender
{
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*) sender;
		NSLog(@"%d",btn.tag);
		NSString *text = @"排序";
		if (btn.tag == 0) {
			_sort = @"sale-desc";
			text = @"销量降序";
		}
		else if(btn.tag == 1){
			_sort = @"price-asc";
			text = @"价格升序";
		}
		else if(btn.tag == 2){
			_sort = @"price-desc";
			text = @"价格降序";
		}
		else if(btn.tag == 3){
			_sort = nil;
			text = @"人气降序";
		} 
		[self._srpdata clear];
		[self searchWord:self._keyword cat:self._catid ppath:self._ppath];
		[self._tableView reloadData];
		[self._rankView disappeared];
		self._rankbtnv._selected = YES;
		[self._rankbtnv setText:text];
		[self._rankbtnv doArrow];
	}
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Sort"];
}	 
	 

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];  
	EtaoCustomButtonView *btnView = [[EtaoCustomButtonView alloc] initWithFrame:CGRectMake(0,0,200,30)];
	btnView.delegate = self;
	btnView.buttonClick = @selector(rankClick:);
	self.navigationItem.titleView = btnView;
	self._rankbtnv = btnView;
	[btnView release];
         
}


- (void) searchWord:(NSString*)word cat:(NSString*)cat ppath:(NSString*)ppath {
	
	ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
	[loadv startAnimating];
	[self.view addSubview:loadv]; 
	[self.view bringSubviewToFront:loadv]; 
	self._tableView.hidden = YES;
	
	_keyword = word ; 
	_catid = cat;
	_ppath = ppath;	 
	
	[self._srpdata clear];
	[self retain];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:10],nil];
	[self loadMoreFrom:startEnds];
	//[self loadMoreFrom:0 TO:10]; 
	[self._tableView reloadData];
}


// first search 
- (void) search:(NSString*)keyword{ 
	
	ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
	[loadv startAnimating];
	[self.view addSubview:loadv]; 
	[self.view bringSubviewToFront:loadv]; 
	self._tableView.hidden = YES;
	
	_keyword = keyword ;//;[NSString stringWithFormat:@"%@",keyword];
	[self._srpdata clear];
	[self._tableView reloadData];
	[self retain];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:10],nil];
	[self loadMoreFrom:startEnds];
	//[self loadMoreFrom:0 TO:10];
}
 

- (void) requestFinished:(EtaoSRPRequest *)sender { 
	NSLog(@"%s", __FUNCTION__);  
	for (UIView *v in [self.view subviews]) {
		if ([v isKindOfClass:[ActivityIndicatorMessageView class]]) {
			ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)v;
			if (loadv!=nil) { 
				[loadv stopAnimating];
			}
		}
	}
    
    [self release]; 
    
	self._tableView.hidden = NO;
	self._requestFailed = NO; 
	EtaoSRPRequest * request = (EtaoSRPRequest *)sender;
	[self._srpdata addItemsByJSON:request.jsonString];
    
    //返回数据为详情页时，显示详情页
    if ([self._srpdata._searchType isEqualToString:@"detail"] == YES) {
        if (_detailDirect == nil) {
            _detailDirect = [[SearchDetailController alloc] init];
            self.view = _detailDirect.view;
			_detailDirect.delegate = self;
        }
        
        [_detailDirect setJsonData:request.jsonString];
        
        self.navigationItem.titleView = nil;
        self._rankbtnv.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.title = @"产品详情";
        
        //add to history
        UIApplication *app = [UIApplication sharedApplication];
        etao4iphoneAppDelegate *delegate = (etao4iphoneAppDelegate *)app.delegate;
        EtaoAuctionPriceCompareHistoryViewController *history = [delegate etaoAuctionPriceCompareHistoryViewController];
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:0];
        if (cell!=nil && [cell isKindOfClass:[EtaoSRPCell class]]) {
            [history insertNewObject:cell]; 
        } 

        return;
    }
    
	NSLog(@"%@",self._srpdata.items);
	NSLog(@"request=%d",[request retainCount]);
	
	if ([self._srpdata emptyForCategory]) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
	 
	if ([self._srpdata.items count] > 0 ) {
		[self._head setTextForSRP:self._keyword Total:self._srpdata._totalCount Now:1];
 	} 
	else {
		[self._head setText:@"很抱歉，没有找到符合条件的商品。"];
	}

		 
	[self._tableView reloadData];
	self._isLoading = NO; 
	NSLog(@"reloadData end"); 
	
	self._httpquery = nil;

}


- (void) requestFailed:(EtaoSRPRequest *)sender{  
	NSLog(@"%s", __FUNCTION__); 
	self._tableView.hidden = NO;
	//[EtaoShowAlert showAlert];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
	self._isLoading = NO; 
	//httpquery.delegate = nil;
	for (UIView *v in [self.view subviews]) {
		if ([v isKindOfClass:[ActivityIndicatorMessageView class]]) {
			ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)v;
			if (loadv!=nil) { 
				[loadv stopAnimating];
			}
		}
			
	} 
	self._requestFailed = YES;
	[self._tableView reloadData];
	[self release]; 
	self._httpquery = nil;
}


- (void) loadMoreFrom:(int)s TO:(int)e {

	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:); 
	
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	[dict setValue:_keyword forKey:@"q"];
	[dict setValue:[NSNumber numberWithInt:s] forKey:@"s"];
	[dict setValue:[NSNumber numberWithInt:e-s] forKey:@"n"];
	if (_catid != nil) {
		[dict setValue:_catid forKey:@"cat"];
	}
	if (_ppath != nil) {
		[dict setValue:_ppath forKey:@"ppath"];
	}
	if (_sort != nil) {
		[dict setValue:_sort forKey:@"sort"];
	}
	 
	NSString *loginfo = [NSString stringWithFormat:@"%@;srp;search",[UIDevice currentDevice].uniqueIdentifier];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start];  
}


- (void) loadMoreFrom:(NSArray*)startEnds{

	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];
	self._httpquery = httpquery;
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:); 
	
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
	NSNumber *s = (NSNumber*)[startEnds objectAtIndex:0];
	NSNumber *n = (NSNumber*)[startEnds objectAtIndex:1];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	[dict setValue:_keyword forKey:@"q"];
	[dict setValue:s forKey:@"s"];
	[dict setValue:n forKey:@"n"];
	
	if (_catid != nil) {
		[dict setValue:_catid forKey:@"cat"];
	}
	if (_ppath != nil) {
		[dict setValue:_ppath forKey:@"ppath"];
	}
	if (_sort != nil) {
		[dict setValue:_sort forKey:@"sort"];
	}

	EtaoSystemInfo *sys = [EtaoSystemInfo sharedInstance];
	NSString *loginfo = [NSString stringWithFormat:@"%@;srp;search;%@;%@",[UIDevice currentDevice].uniqueIdentifier,sys.userLocation,sys.userLocationDetail];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start];  
}


- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",indexPath);
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	NSLog(@"%@",scrollView);
	[self._rankView disappeared];
	self._rankbtnv._selected = YES;
	[self._rankbtnv doArrow]; 
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
	NSLog(@"scrollViewDidScrollToTop");	
	
}


- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",scrollPosition);
	
}


- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
	//The rest of your stuff you need to do
	return proposedDestinationIndexPath;
}


 /*
 - (void)viewWillAppear:(BOOL)animated {
	 NSLog(@"viewWillAppear");
	 [self retain];
	 [super viewWillAppear:animated];
 }
 
 
 - (void)viewDidAppear:(BOOL)animated {
	 NSLog(@"viewDidAppear");
	  [self release];
	 [super viewDidAppear:animated];
	 NSLog(@"%d,indexPathsForVisibleRows=%@", [self._tableView numberOfRowsInSection:0],[self._tableView indexPathsForVisibleRows]);
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
 

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.  
	if (self._srpdata._totalCount < 0) {
		return 1;
	}
	
	if (self._srpdata._totalCount == 0 ) {
		if (self._requestFailed) {
			return 1 ;
		}
		return 0;
	}
	
	if ([self._srpdata count] < self._srpdata._totalCount ) {
        return [self._srpdata count] + 1;
    } else {
        return [self._srpdata count] ;
    }
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [EtaoSRPCell height];
	
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"";
}


- (void) reloadLastRequest:(id)sender{ 
	int count = [self._srpdata count];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:10],nil];
	//[self loadMoreFrom:startEnds];
	[self retain];
	[self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1];
	return ;
	if ( self._httpquery != nil) {
		[self retain];
		[self._httpquery start];
	} 
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%s", __FUNCTION__); 
	NSLog(@"%d", [indexPath row]); 
	
	static NSString *itemCellId = @"itemCell";
	// 	NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d",[indexPath row]] ;	
	static NSString *moreCellId = @"moreCell"; 
	
	NSUInteger row = [indexPath row];
	NSUInteger count = [self._srpdata count];
	
	if (row == count ) { 
		EtaoLoadMoreCell * cell = (EtaoLoadMoreCell*)[self._tableView dequeueReusableCellWithIdentifier:moreCellId];
        
		if (cell == nil) {
			cell = [[[EtaoLoadMoreCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
            UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            [selectedView release];
            
		} 
		cell._parent = self; 
		if (self._requestFailed) {
			[cell setReload];
			cell.delegate =self;
			cell.action = @selector(reloadLastRequest:);
		}
		return cell; 
	}
	else 
	{   
		EtaoSRPCell * cell = (EtaoSRPCell*)[self._tableView dequeueReusableCellWithIdentifier:itemCellId];
		
        if (cell == nil) {
			cell = [[[EtaoSRPCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellId] autorelease];
            UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            [selectedView release];
        }
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		[cell set:[self._srpdata objectAtIndex:row]]; 
		cell._parent = self;
		cell._idx = row;
		return cell;
	}     
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"%s", __FUNCTION__); 
	NSLog(@"%d",[indexPath row]);
	NSUInteger row = [indexPath row];
	NSUInteger count = [self._srpdata count];
	

	for (id c in self._tableView.visibleCells) {
		if ([ c isKindOfClass:[EtaoSRPCell class]]) {
			EtaoSRPCell *vc = (EtaoSRPCell*)c ;  
			[self._head setTextForSRP:self._keyword Total:self._srpdata._totalCount Now:vc._idx+1]; 
		}
	}
	
	// load more
	if (count == 0 || count == self._srpdata._totalCount) {
		return;
	}
	
	if (row == count ) {
		
		if (self._isLoading == YES || self._requestFailed == YES) {
			return;
		} 
 		self._isLoading = YES;  
		
		NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:10],nil]; 
		[self retain];
		[self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1];
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
	[self._tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //when the cell is selected, we and it to price compare history.(when it exits, core data make sure it won't be add again)
	[self._rankView disappeared];
	self._rankbtnv._selected = YES;
	[self._rankbtnv doArrow]; 
	 
    UIApplication *app = [UIApplication sharedApplication];
    etao4iphoneAppDelegate *delegate = (etao4iphoneAppDelegate *)app.delegate;
  //  EtaoAuctionPriceCompareHistoryViewController *history = [delegate etaoAuctionPriceCompareHistoryViewController];
    
    ETaoHistoryViewController *his = [delegate etaoHistoryViewController];
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	
    if ([cell isKindOfClass:[EtaoSRPCell class]]) {
        EtaoSRPCell *etaoinfo = (EtaoSRPCell*) cell; 
        
        if ( [etaoinfo._item isKindOfClass:[EtaoProductItem class]] ){
            EtaoProductItem *item =  etaoinfo._item;  
            NSString *json = [[item toDictionary] JSONRepresentation];
            
            [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.pid hash]] Name:@"product" JSON:json];
        }
        else {
            EtaoAuctionItem *item =  etaoinfo._item;   
            NSString *json = [[item toDictionary] JSONRepresentation];
            [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.nid hash]] Name:@"auction" JSON:json];
        } 
	} 
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndex"];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	_tableView = nil;
	_srpdata = nil;
	_head = nil;
        
    [super viewDidUnload];
} 
 

- (void)dealloc {  
	//[self wait4Finish]; 
	// 避免table正在加载的时候，导致crash
	_tableView.delegate = nil;
	_tableView.dataSource = nil;
    
	if (self._httpquery != nil) {
		self._httpquery.delegate = nil;
        [_httpquery release];
	} 
    
	[_tableView release]; 
	[_srpdata release]; 
	[_head release]; 
    [_detailDirect release];
    [_rankbtnv release];
    [_rankView release];      
    
	[super dealloc];
}


@end
