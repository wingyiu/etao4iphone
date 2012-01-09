    //
//  EtaoHomeViewController.m
//  etao4iphone
//
//  Created by iTeam on 11-9-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoHomeViewController.h"
#import "EtaoLocalViewController.h"
#import "EtaoMoreViewController.h"

#import "NSObject+SBJson.h"
#import "NSString+QueryString.h"
#import "EtaoSRPHomeController.h"
#import "EtaoShowAlert.h"
#import "EtaoSystemInfo.h"
#import "EtaoUIBarButtonItem.h"
#import "UpdateSession.h"

@interface EtaoHomeViewController() 
-(void)isVersionIsLatest;
-(void)showAlert:(NSString*) msg;
@end

@implementation EtaoHomeViewController

@synthesize _topqueryView ;
@synthesize _tuanView ; 
@synthesize _topQueryJson ;

@synthesize updateSession = _updateSession;

- (void) UIBarButtonItemHome:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
    
 	self._textField.frame = CGRectMake(5.0f, 7.0f, 250.0f, 30.0f);
	self._searchButton.hidden = NO;
	UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
	UIImageView *bk = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"EtaoSearchbg.png"]];  
	
	[searchBarView addSubview:bk]; 
	[searchBarView  addSubview:self._textField]; 	
	[searchBarView  addSubview:self._searchButton];  
	[bk release]; 
	
	[self.view addSubview:searchBarView]; 
	[searchBarView release];
	
	self._searchCancelBtn.frame = CGRectMake(0, 44.0f, 320, 440); 
	
	UIImageView *etao = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"EtaoLogo.png"]];
	self.navigationItem.titleView = etao;	
	[etao release]; 
	
	UIButton *aboutBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)]autorelease]; 
	[aboutBtn setImage:[UIImage imageNamed:@"Etaoabout.png"] forState:UIControlStateNormal]; 
	[aboutBtn addTarget:self action:@selector(aboutClick) forControlEvents:UIControlEventTouchUpInside];
  	UIBarButtonItem *about = [[UIBarButtonItem alloc] initWithCustomView:aboutBtn];
	self.navigationItem.rightBarButtonItem = about; 
	[about release];  
	
    // 当内存不足的时候，这个类有问题，by zhangsuntai 2011-09-23
	EtaoTopQueryView *topq = [[EtaoTopQueryView alloc] initWithFrame:CGRectMake(10, 55.0f, 300,200)];

	self._topqueryView = topq;
	self._topqueryView._queryView.delegate = self;
	self._topqueryView._queryView.action = @selector(queryButtonClickOn:);
	[topq release];
	[self.view addSubview:self._topqueryView]; 

    
	EtaoHomeTuanView *tuanv = [[EtaoHomeTuanView alloc] initWithFrame:CGRectMake(10, 260.0f, 300,100)];

	self._tuanView = tuanv;

	[tuanv release];
	self._tuanView.delegate = self;
	self._tuanView.typeButtonClickOnSelector = @selector(typeButtonClickOn:);
	
	[self.view addSubview:self._tuanView];
	
	self.view.backgroundColor = [[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"EtaoHomeBackground.png"]]autorelease];
	
	[self.view addSubview: self._tableView]; 
	self._tableView.hidden = YES;
	
    [self._tableView setFrame:CGRectMake(0, 44, 320, 416)];
    self._tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self._tableView.autoresizesSubviews = YES;
    
    if ([self._suggestList count] == 0) {
        [self.view bringSubviewToFront:self._searchCancelBtn];
	}
    else {
        //self._tableView.hidden = NO;
    }
    
    //版本检测 50%几率检测提示
    int value = (arc4random()%2);
    if (value == 1 || YES) {
        [self isVersionIsLatest];
    }
}


- (void)viewWillAppear:(BOOL)animated{

}


- (void) doSearch:(NSString*)word{
	NSLog(@"+++word=%@",word);
	UINavigationController *nav = (UINavigationController*)[[[self tabBarController] viewControllers] objectAtIndex: 1];
	[nav popToRootViewControllerAnimated:NO];
	
	EtaoSRPHomeController *srphome = (EtaoSRPHomeController*)[[[[self tabBarController] viewControllers] objectAtIndex: 1]topViewController];
	self._textField.text = word ;

	[self._textField resignFirstResponder];
	if ( srphome.view == nil) {
		srphome._textField.text =  word ;
	}
	srphome._textField.text = word ;
	[srphome forceSearch:word]; 
	[self.tabBarController setSelectedIndex:1]; 
}


- (void) searchButtonPressed:(id)sender {
	if ([sender isKindOfClass:[UIButton class]] ) {
		UIButton *btn = (UIButton*)sender; 
		if ([ btn.titleLabel.text isEqualToString:@"取消"]) {
			[self textFieldShouldEndEditing:self._textField];
			[self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
			self._tableView.hidden = YES;
            [self._textField resignFirstResponder];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            //[super textFieldDidEndEditing:textField];

		}
		else {
			if ([self._textField.text isEqualToString:@""] || self._textField.text == nil) {
				return ;
			}
			[self doSearch:self._textField.text];
		} 
	} 
}

- (void) aboutClick{
	EtaoMoreViewController *more = [[[EtaoMoreViewController alloc] init]autorelease]; 
	[self.navigationController pushViewController:more animated:YES];
}


- (void) typeButtonClickOn:(NSString*)type { 
	UINavigationController *nav = (UINavigationController*)[[[self tabBarController] viewControllers] objectAtIndex: 2];
	[nav popToRootViewControllerAnimated:NO];
 	
	EtaoLocalViewController *tuanHome = (EtaoLocalViewController*)[[[[self tabBarController] viewControllers] objectAtIndex: 2]topViewController];

	if ( tuanHome.view != nil) { 
		tuanHome._selectedType = type ;
		[tuanHome typeButtonClickOn:type];
		[self.tabBarController setSelectedIndex:2];
	} 
}

- (void) queryButtonClickOn:(id)sender {  
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton *btn = (UIButton*)sender;
		[self doSearch:btn.titleLabel.text];
	}
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self._searchButton setTitle:@"取消" forState:UIControlStateNormal];
	self._tableView.hidden = YES;
	[self.navigationController setNavigationBarHidden:YES animated:YES]; 	
	[super textFieldDidBeginEditing:textField];
	
	if (self._textField.text.length > 0) {
		self._tableView.hidden = NO;
		[self loadSuggest:[NSString stringWithFormat:@"%@",textField.text]];
		[super unmark];
	}
    
    self._tableView.hidden = NO;
	  
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//	self._tableView.hidden = YES;
//	[self.navigationController setNavigationBarHidden:NO animated:YES];
//    
//	[super textFieldDidEndEditing:textField];
    if( self._tableView.hidden == YES ) {
        [self._searchButton setTitle:@"比价" forState:UIControlStateNormal];
    }
    else{    
        [self._searchButton setTitle:@"取消" forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if ([self._textField.text isEqualToString:@""]) {
		return YES;
	}
	self._tableView.hidden = YES;
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	[super textFieldShouldReturn:textField];
	[self doSearch:self._textField.text]; 
	return YES;
}


- (void) TopQueryrequestFinished:(HttpRequest*)sender { 
	NSLog(@"%@",[self.view subviews]);
	NSLog(@"self.view=%@",self.view);
	for (UIView *v in [self.view subviews] ) {
		if ([v isKindOfClass:[UIActivityIndicatorView class]]) {
			UIActivityIndicatorView * activityIndicator = (UIActivityIndicatorView*)v;
			[activityIndicator stopAnimating];
			[activityIndicator removeFromSuperview];
			
		}
	}
	
 	HttpRequest * request = (HttpRequest *)sender;  
 	NSString *ncontent = [request.jsonString stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
 	self._topQueryJson = ncontent ;
	EtaoSystemInfo *etaoSystem = [EtaoSystemInfo sharedInstance];
	[etaoSystem setValue:ncontent forKey:@"TopQueryAtHomePage_Json"];
	[etaoSystem save]; 
 	[_topqueryView setInfo:ncontent];
}

- (void) loadTopQueryRequest{   
	
	NSString *url = [NSString stringWithFormat:@"http://wap.taobao.com/channel/rgn/mobile/decider/client.html"];
	HttpRequest *httpquery = [[[HttpRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(TopQueryrequestFinished:);
	httpquery.requestDidFailedSelector = @selector(TopQueryrequestFailed:); 
	[httpquery load:url];  
	
	UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	activityIndicator.frame = CGRectMake(self.view.frame.size.width /2 -15 , self.view.frame.size.height * 0.33, 30.0f, 30.0f);
	activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin; 
	[self.view addSubview:activityIndicator];
	[activityIndicator startAnimating];
	NSLog(@"self.view=%@",self.view);
	
}

- (void) TopQueryrequestFailed:(HttpRequest*)sender{ 
	for (UIView *v in [self.view subviews] ) {
		if ([v isKindOfClass:[UIActivityIndicatorView class]]) {
			UIActivityIndicatorView * activityIndicator = (UIActivityIndicatorView*)v;
			[activityIndicator stopAnimating];
			[activityIndicator removeFromSuperview];
			
		}
	}
	
	//[EtaoShowAlert showAlert];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
	EtaoSystemInfo *etaoSystem = [EtaoSystemInfo sharedInstance];
	
	NSString *jsonContent = [etaoSystem.sysdict objectForKey:@"TopQueryAtHomePage_Json"];
	if (jsonContent != nil) {
		self._topQueryJson = jsonContent ;
		[_topqueryView setInfo:jsonContent];
	}
	else {
		
		[self performSelector:@selector(loadTopQueryRequest) withObject:nil  afterDelay:10.0];
	}

}

 
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 	 [super viewDidLoad];
	 
	 if (self._topQueryJson == nil) {
		 [self loadTopQueryRequest];
	 }
	 else {
		 [_topqueryView setInfo:_topQueryJson];
	 } 
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
	//UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘"   message:@"内存不足了哦"   delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil] autorelease];
 	//[alert show]; 
    [super didReceiveMemoryWarning]; 
	
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	
	[super viewDidUnload];
	 
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)isVersionIsLatest {
    if(nil == _updateSession) {
        _updateSession = [[UpdateSession alloc] init];
        _updateSession.sessionDelegate = self;
    }
    
    [self retain];
    [_updateSession requestUpdateDate];
}


- (void) UpdateRequestDidFailed:(NSObject *)obg {
    [self release];
//    
//    [EtaoShowAlert showAlert];
//    
//    [self showAlert:@"FAILED"];
}


-(void) showAlert:(NSString*) msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:msg
                                                   delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
    alert.delegate = self;
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView buttonTitleAtIndex:buttonIndex] == @"立即更新") {
        
        NSString* updateUrl;
        if(nil == _updateSession.UpdateProtocal.updateUrl) {
            updateUrl = _updateSession.UpdateProtocal.updateUrl;
        }
        else {
            updateUrl = @"http://itunes.apple.com/app/id451400917?mt=8";
        }
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateSession.UpdateProtocal.updateUrl]];
    }
}


- (void) UpdateRequestDidFinish:(NSObject *)obj {
    [self release];
    
    if (_updateSession.UpdateProtocal.isHaveNewVersion == YES) {
        [self showAlert:_updateSession.UpdateProtocal.versionDesc];
    }
//    else {
//        [self showAlert:@"您已经是最新的版本了，亲！"];
//    }
}


- (void)alertViewCancel:(UIAlertView *)alertView {
    NSLog(@"url == ...alertViewCancel..alertViewCancel..alertViewCancel..");
}


- (void)dealloc {
	[_topqueryView release];
	[_tuanView release]; 
    [_updateSession release];
    [super dealloc];
}

@end
