    //
//  EtaoHomeController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoHomeController.h"
#import "NSObject+SBJson.h"
#import "EtaoSRPHomeController.h"


@implementation EtaoHomeController


@synthesize _tableView; 
@synthesize _loadingSuggest ;
@synthesize _suggestList; 
@synthesize _textField ;
@synthesize _searchCancelBtn; 
@synthesize _searchFieldButton;
@synthesize _topqueryView ;
@synthesize _tuanView ;

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

 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 7.0f, 250.0f, 30.0f)];
	self._textField = textField;
	[textField release];
	_textField.leftViewMode = UITextFieldViewModeAlways;  
	_textField.leftView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftsearch.png"]] autorelease]; 
	_textField.borderStyle = UITextBorderStyleRoundedRect;
	_textField.autocorrectionType = UITextAutocorrectionTypeNo;
	_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_textField.returnKeyType = UIReturnKeySearch;
	_textField.clearButtonMode = UITextFieldViewModeWhileEditing; 
	_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_textField.placeholder = @"搜索，比价，省钱"; 
	_textField.delegate = self;
	  	
	//定义搜索点击的时候，方便取消的效果
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	_searchCancelBtn = btn;
	_searchCancelBtn.frame = CGRectMake(0.0f, 44.0f, 320.0f, 440.0f); 
	_searchCancelBtn.backgroundColor = [UIColor blackColor]; 
	[_searchCancelBtn addTarget:self action:@selector(SearchMarkButtonClick) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:_searchCancelBtn]; 
	_searchCancelBtn.hidden = YES;   
	
	UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
	UIImageView *bk = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"etaoNavbar1.png"]];
 	UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(270.0f, 7.0f, 45, 30)];	
	[searchButton setTitle:@"比价" forState:UIControlStateNormal];
	searchButton.titleLabel.font = [UIFont systemFontOfSize: 14]; 
	[searchButton setBackgroundImage:[UIImage imageNamed:@"searchAthome.png"] forState:UIControlStateNormal];  
	[searchButton addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[searchBarView addSubview:bk]; 
	[searchBarView  addSubview:self._textField]; 	
	[searchBarView  addSubview:searchButton];  
	[bk release];
	[searchButton release]; 
	[self.view addSubview:searchBarView]; 
	[searchBarView release];
	
	
	self._loadingSuggest = NO;
	self._suggestList = [NSMutableArray arrayWithCapacity:20];
	
	UITableView * tablev = [[UITableView alloc] initWithFrame:CGRectMake(0, 44.0f, 320,400) style:UITableViewStylePlain];   
    self._tableView = tablev;
	[tablev release]; 
	
	[ self._tableView setDelegate:self];  
	[ self._tableView setDataSource:self];
	
    [self.view addSubview: self._tableView]; 
	self._tableView.hidden = YES;
	_searchCancelBtn.frame = CGRectMake(0, 44.0f, 320, 440); 
	
	UIImageView *etao = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"EtaoLogo.png"]];
	self.navigationItem.titleView = etao;	
	[etao release];
	
	UIImageView *aboutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"Etaoabout.png"]];
	UIBarButtonItem *about = [[UIBarButtonItem alloc] initWithCustomView:aboutView];
	self.navigationItem.rightBarButtonItem = about;
	[about release];
	[aboutView release]; 
	
 
	EtaoTopQueryView *topq = [[EtaoTopQueryView alloc] initWithFrame:CGRectMake(10, 50.0f, 300,200)];
	self._topqueryView = topq;
	[topq release];
	[self.view addSubview:self._topqueryView];

	EtaoHomeTuanView *tuanv = [[EtaoHomeTuanView alloc] initWithFrame:CGRectMake(10, 250.0f, 300,100)];
	self._tuanView = tuanv;
	[tuanv release];
	[self.view addSubview:self._tuanView];
	
	self.view.backgroundColor = [[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"EtaoHomeBackground.png"]]autorelease];

	
	[self.view bringSubviewToFront:self._searchCancelBtn]; 
	
}

- (void) mark { 	
	if (_searchCancelBtn.alpha == 0.6) {
		return ;
	}
	_searchCancelBtn.hidden = NO;
 	_searchCancelBtn.alpha = 0.0; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_searchCancelBtn.alpha = 0.6;
	[UIView commitAnimations];
}

- (void) unmark { 
	if (_searchCancelBtn.alpha == 0.0) {
		return ;
	}
 	_searchCancelBtn.alpha = 0.6; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_searchCancelBtn.alpha = 0.0;
	[UIView commitAnimations];
	_searchCancelBtn.hidden = NO;  
}

- (void)SearchMarkButtonClick{
	[self unmark];
	[_textField resignFirstResponder]; 
	_searchFieldButton.title = @"搜索"; 
}


- (void)searchButtonTapped:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
		UIBarButtonItem *btn = (UIBarButtonItem*)sender;
		if ([btn.title isEqualToString:@"取消"]) { 
			btn.title = @"搜索";
			[_textField resignFirstResponder];
			[self unmark];
		} 
	} 
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	self._tableView.hidden = YES;
	[self.navigationController setNavigationBarHidden:YES animated:YES]; 
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	self._tableView.hidden = YES;
	[self.navigationController setNavigationBarHidden:NO animated:YES]; 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	self._tableView.hidden = YES;
	[self.navigationController setNavigationBarHidden:NO animated:NO]; 
	
	UINavigationController *nav = (UINavigationController*)[[[self tabBarController] viewControllers] objectAtIndex: 1];
	[nav popToRootViewControllerAnimated:NO];
 	
	EtaoSRPHomeController *srphome = (EtaoSRPHomeController*)[[[[self tabBarController] viewControllers] objectAtIndex: 1]topViewController];

	// test view if init
	if ( srphome.view == nil) {
		srphome._textField.text =  _textField.text ;
	}
	srphome._textField.text = _textField.text ;
	[srphome textFieldShouldReturn:srphome._textField];
	[self.tabBarController setSelectedIndex:1];
	
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	[self.navigationController setNavigationBarHidden:NO animated:YES]; 
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if (_loadingSuggest == YES) {
		return YES;
	}  
	[self unmark]; 
	self._tableView.hidden = NO;
	// add
	if (range.length == 0) {
		[self loadSuggest:[NSString stringWithFormat:@"%@%@",textField.text,string]];
	}
	else { 
		NSRange r = {0,range.location};
		[self loadSuggest:[textField.text substringWithRange:r]]; 
	}
	
	NSLog(@"searchword=%@,%@,%d,%d",textField.text,string,range.length,range.location); 
	return YES;
}

- (void) loadSuggest:(NSString*)text {
	_loadingSuggest = YES;
	NSString *url = [NSString stringWithFormat:@"http://suggest.taobao.com/sug?code=utf-8&q=%@",text];
	HttpRequest *httpquery = [[[HttpRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	[httpquery load:url]; 
}

- (void) requestFinished:(HttpRequest*)sender {
	HttpRequest * request = (HttpRequest *)sender; 
    NSDictionary *json = [request.jsonString JSONValue];
	//	NSLog(@"json=%@",json);
    NSArray *result = [json objectForKey:@"result"];
	//	NSLog(@"result=%@",result);
 	[_suggestList removeAllObjects]; 
	for (NSArray *v in result) {
 		NSLog(@"%@",[v objectAtIndex:0]);
  		[_suggestList addObject:[v objectAtIndex:0]];
	}  
	[self._tableView reloadData];
    
    _loadingSuggest = NO;
	
}


- (void) requestFailed:(HttpRequest*)sender{   
	_loadingSuggest = NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%d",[_suggestList count]);
	return [_suggestList count] ;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell * cell = (UITableViewCell*)[self._tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
	} 
	NSLog(@"%@",[_suggestList objectAtIndex:[indexPath row]]);
	cell.textLabel.text = [_suggestList objectAtIndex:[indexPath row]];
	
	return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 	
	if ([_suggestList count] > indexPath.row) {
		NSString *text = [_suggestList objectAtIndex:indexPath.row];
		_textField.text = text; 
		
		UINavigationController *nav = (UINavigationController*)[[[self tabBarController] viewControllers] objectAtIndex: 1];
		[nav popToRootViewControllerAnimated:NO];
		
		EtaoSRPHomeController *srphome = (EtaoSRPHomeController*)[[[[self tabBarController] viewControllers] objectAtIndex: 1]topViewController];
 
		// test view if init
		if ( srphome.view == nil) {
			srphome._textField.text = text;
		}
		srphome._textField.text = text;
		[srphome textFieldShouldReturn:srphome._textField];
		[srphome loadSuggest:text];
		[self.tabBarController setSelectedIndex:1];
		[_suggestList removeAllObjects];
		[self._tableView reloadData];
		_textField.text = text;
		[self textFieldDidEndEditing:_textField];
		self._tableView.hidden = YES; 
	}
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
	_topqueryView = nil;
	_tuanView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_topqueryView release];
	[_tuanView release];
    [super dealloc];
}


@end
