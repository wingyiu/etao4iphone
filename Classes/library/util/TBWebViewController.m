    //
//  TBWebViewController.m
//  etao4iphone
//
//  Created by iTeam on 11-6-14.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import "TBWebViewController.h"


@implementation TBWebViewController

@synthesize url;
@synthesize webView;

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
	NSLog(@"loading");
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	//contentView.backgroundColor = [UIColor blueColor];
	
	// view orientation rotation
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
	self.view = contentView;
	
	//设置属性
	//自动调整视图大小 
	self.view.autoresizesSubviews = NO;
	
	//创建一个层用来放webview
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.origin.y -= 20.0;
	
	UIWebView *aWebView = [[UIWebView alloc] initWithFrame:webFrame];
	self.webView = aWebView;
	
	[aWebView setUserInteractionEnabled:YES];
	[aWebView setBackgroundColor:[UIColor clearColor]];
	[aWebView setDelegate:self];
	[aWebView setOpaque:NO];//使网页透明
	
	//缩放
	
	aWebView.scalesPageToFit = YES;
	
	//自动调整大小
	
	aWebView.autoresizesSubviews = YES;
	
	aWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	
	//[aWebView setDelegate:self];
	
	NSURL *aURL = [NSURL URLWithString:url];
	
	NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
	
	//发送请求
	
	UIView *t_view = [[[UIView alloc] initWithFrame:webFrame]autorelease];
	[t_view setTag:103];
	[t_view setBackgroundColor:[UIColor grayColor]];
	[t_view setAlpha:0.8];
	[self.view addSubview:t_view];
	
	activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
	[activityIndicator setCenter:t_view.center];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	[t_view addSubview:activityIndicator];
	
	[aWebView loadRequest:aRequest];
	
	//把webview添加到内容视图
	
	[contentView addSubview:webView];
	
	[aWebView release];
	
	[contentView release];
	
}
 

 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];  
}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {    
	[activityIndicator startAnimating];         
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[activityIndicator stopAnimating];    
	UIView *view = (UIView *)[self.view viewWithTag:103];
	[view removeFromSuperview];
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
    [super viewDidUnload];
	url = nil; 
	webView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[url release];
	[webView release];
    [super dealloc];
}


@end
