    //
//  EtaoCategoryNavController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoCategoryNavController.h"
#import "NSObject+SBJson.h"
#import "EtaoPropertyCell.h"
#import "EtaoUIBarButtonItem.h"
@implementation EtaoCategoryNavController
  
@synthesize _srpdata; 
@synthesize _isLoading,_isCatMode; 
@synthesize _tableView; 
@synthesize _keyword;
@synthesize _catid ;
@synthesize _pidvid ;
@synthesize _ppath;

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
 
- (id) initWithWord:(NSString*)word cat:(NSString*)cat pidvid:(NSString*)pv {
	
    self = [super init];
    if (self) {
		self._keyword = word; 
		self._catid = cat ;
		self._ppath = pv ; 
		self._isCatMode = YES;
    }
    return self;
}

- (void)dealloc {
    _tableView.delegate = nil ;
    _tableView.dataSource = nil ;
    
	[_pidvid release];
	[_tableView release];
    [_srpdata release];
    [super dealloc];
}



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	UITableView * tablev = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height) style:UITableViewStyleGrouped]; 
    tablev.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	self._tableView = tablev;
	[tablev release];
	
	[self._tableView setDelegate:self];  
	[self._tableView setDataSource:self];
	 
	EtaoSRPDataSource * datas = [[EtaoSRPDataSource alloc]init];
	self._srpdata = datas ;
	[datas release];

	
    [self.view addSubview:self._tableView];
	
	self._isLoading = NO; 
	 
	self.view.backgroundColor = [UIColor blackColor]; 
	
	self._pidvid = [NSMutableDictionary dictionaryWithCapacity:10];
	
	[self._srpdata clear]; 
	[self loadMoreFrom:0 TO:10];
	
}

- (void) navDone { 
	NSMutableString * ppath = [NSMutableString stringWithFormat:@""];
	for ( NSString *s in [self._pidvid allKeys]) {
		[ppath appendFormat:@"%@;",s];
	}
	self._ppath = ppath;
	
	EtaoSRPController  * srpController = nil;
    for (UIViewController *c  in self.navigationController.viewControllers) {
        if ( [c isKindOfClass:[EtaoSRPController class]]) {
            srpController = (EtaoSRPController*) c;
        }
    }
	[srpController searchWord:_keyword cat:_catid ppath:_ppath];
	[self.navigationController popToViewController:srpController animated:YES];
}

- (void) search { 
	[self._srpdata clear];
	//[self._tableView reloadData];
	[self loadMoreFrom:0 TO:10];
}

- (void) searchWord:(NSString*)word cat:(NSString*)cat pidvid:(NSString*)pv {
	self._keyword = word; 
	self._catid = cat ;
	self._ppath = pv ;
	
	[self._srpdata clear];
	[self loadMoreFrom:0 TO:10];
	
}

- (void) check {
	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinishedCheck:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:); 
	
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	
	[dict setValue:_keyword forKey:@"q"];
	[dict setValue:[NSNumber numberWithInt:0] forKey:@"s"];
	[dict setValue:[NSNumber numberWithInt:10] forKey:@"n"];
	if (_catid != nil) {
		[dict setValue:_catid forKey:@"cat"];
	}
	if (_ppath != nil) {
		[dict setValue:_ppath forKey:@"ppath"];
	}
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start];
}

- (void) requestFinishedCheck:(EtaoSRPRequest *)sender { 
	EtaoSRPRequest * request = (EtaoSRPRequest *)sender;
	[self._srpdata clear];
	[self._srpdata addItemsByJSON:request.jsonString];
	
	// 如果catlist为空，出现属性
	if ([self._srpdata.catList count] == 0 ) {
		if ([self._srpdata._propList count] > 0 ) {
			self._isCatMode = NO ;
		} 
	}
 
	if (self._isCatMode) {
		// 没有子类目了，显示完成
		if ([self._srpdata.catList count] == 0 ) {  
            EtaoUIBarButtonItem* done = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor lightGrayColor] target:self action:@selector(navDone)]autorelease];
            self.navigationItem.rightBarButtonItem = done; 
		}
	}
}


- (void) requestFailed:(EtaoSRPRequest *)sender{ 
	self._isLoading = NO; 
	[self release];
}



- (void) requestFinished:(EtaoSRPRequest *)sender { 
	EtaoSRPRequest * request = (EtaoSRPRequest *)sender;
	[self._srpdata addItemsByJSON:request.jsonString];
	
	// 如果catlist为空，出现属性
	if ([self._srpdata.catList count] == 0 ) {
		if ([self._srpdata._propList count] > 0 ) {
			self._isCatMode = NO ;
		} 
	}
	
	if (!self._isCatMode) { 			
        
        EtaoUIBarButtonItem* done = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor lightGrayColor] target:self action:@selector(navDone)]autorelease];
		self.navigationItem.rightBarButtonItem = done;  
	}
	
	[self._tableView reloadData];
	if (self._isCatMode) {
		// 没有子类目了，显示完成
		if ([self._srpdata.catList count] == 0 ) { 
			EtaoUIBarButtonItem* done = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor lightGrayColor] target:self action:@selector(navDone)]autorelease];			
			self.navigationItem.rightBarButtonItem = done;  
			
		//	EtaoSRPController  * srpController = (EtaoSRPController*)[self.navigationController.viewControllers objectAtIndex:1];
		//	[srpController searchWord:_keyword cat:_catid ppath:_ppath];
		//	[self.navigationController popToViewController:srpController animated:YES];
		}
	}
	[self release];
}

 

- (void) loadMoreFrom:(int)s TO:(int)e {

	[self retain];
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
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start]; 
	
}
 

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
	return [self._srpdata._forDisplay count]  ;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSDictionary *dict = [self._srpdata._forDisplay objectAtIndex:section];
    NSArray *arr = (NSArray*)[dict objectForKey:@"values"];
	return [ arr count]  ; 
}
 
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	int sec = [indexPath section];
	int row = [indexPath row];
	
	NSDictionary *dict = [self._srpdata._forDisplay objectAtIndex:sec];
	id val = [[dict objectForKey:@"values"] objectAtIndex:row];
	if ( [val isKindOfClass:[EtaoCategoryItem class]]) {
		EtaoCategoryCell *cell = [[[EtaoCategoryCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		EtaoCategoryItem *item = (EtaoCategoryItem*)val; 
		cell._parent = self;
		[cell setCat:item];
		return cell;
	}
	else if ([val isKindOfClass:[EtaoPidVidItem class]] )
	{
		EtaoPropertyCell *cell = [[[EtaoPropertyCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		EtaoPidVidItem *vid = (EtaoPidVidItem*)val;
		EtaoPidVidItem *pid = (EtaoPidVidItem*)[dict objectForKey:@"key"];
		cell._parent = self;
		[cell setPid:pid Vid:vid]; 
		return cell;
	}
	else {
		EtaoPropertyCell *cell = [[[EtaoPropertyCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		return cell;
	}

}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self._tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	_tableView = nil ;
	_pidvid = nil ;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
