//
//  ETaoSearchTopQueryController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoSearchTopQueryController.h"
#import "HttpRequest.h"
#import "EtaoSystemInfo.h"
#import "NSObject+SBJson.h"
#import "EtaoSRPController.h"
#import "EtaoUIBarButtonItem.h"
@implementation ETaoSearchTopQueryController

@synthesize tableView = _tableView ;
@synthesize topQuery = _topQuery;
@synthesize request = _request;
@synthesize parent = _parent;
@synthesize topQueryInfo = _topQueryInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil ;
    _request.delegate = nil ;
    
    [_tableView release];
    [_request release];
    [_topQuery release];
    [_topQueryInfo release];
    
    [super dealloc];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.title = @"热门搜索";
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain]autorelease];  
    
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
	self.topQuery = [NSMutableArray arrayWithCapacity:10];
	self.topQueryInfo = [NSMutableArray arrayWithCapacity:10];
    
    [self.view addSubview:_tableView]; 
    
    NSString *url = @"http://wap.taobao.com/channel/rgn/mobile/decider/client.html";
	self.request = [[[EtaoHttpRequest alloc]init]autorelease];  
	_request.delegate = self;
    _request.secondsToCache = 60*60*24; 
	[_request load:url]; 
}

 

- (void) requestFailed:(EtaoHttpRequest*)sender {
    EtaoHttpRequest * request = (EtaoHttpRequest *)sender;  
 	NSString *ncontent = [request.jsonString stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
 	
	EtaoSystemInfo *etaoSystem = [EtaoSystemInfo sharedInstance];
	[etaoSystem setValue:ncontent forKey:@"TopQueryAtHomePage_Json"];
	[etaoSystem save]; 
    
    
}

- (void) requestFinished:(EtaoHttpRequest*)sender {
    
    EtaoHttpRequest * request = (EtaoHttpRequest *)sender;  
    NSString *ncontent = [request.jsonString stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
    
    NSDictionary *json = [ncontent JSONValue]; 
	NSLog(@"%@",request.jsonString);
	NSArray *queryArray = [json objectForKey:@"items"];
    
	for (NSDictionary *dict in queryArray) {  
		[_topQuery addObject:dict];
        NSArray *tmplines = [[dict objectForKey:@"txt"] componentsSeparatedByString:@";"]; 
        [_topQueryInfo addObject:tmplines];
	}  
    [_tableView reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_topQuery count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dict = [_topQuery objectAtIndex:section];
    NSArray *tmplines = [[dict objectForKey:@"txt"] componentsSeparatedByString:@";"]; 
	return [tmplines count]; 
}
/*
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 20;
	
}
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [_topQuery objectAtIndex:section];
	return [dict objectForKey:@"name"];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSArray *tmplines = [_topQueryInfo objectAtIndex:[indexPath section]]; 
	cell.textLabel.text = [tmplines objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
	// Configure the cell. 
    UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
    selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
    cell.selectedBackgroundView = selectedView;  
    cell.imageView.image = [UIImage imageNamed:@"search.png"];
    return cell;
    
}
 


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
     
 
    NSArray *tmplines = [_topQueryInfo objectAtIndex:[indexPath section]]; 
	NSString *text = [tmplines objectAtIndex:[indexPath row]];     
    
	if (![text isEqualToString:@""]) { 
        
        EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease]; 
        srp._keyword = text ;
        [srp search: srp._keyword];          
        [_parent.navigationController pushViewController:srp animated:YES]; 
    }
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

@end
