    //
//  TBWebViewControll.m
//  taofunny
//
//  Created by iTeam on 11-7-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TBWebViewControll.h"


@implementation TBWebViewControll

@synthesize _url,_name;
@synthesize webView = _webView;
@synthesize activityIndicator,back,next,refresh,stop,safari,space;

@synthesize alertWhenInternetNotSupportWap = _alertWhenInternetNotSupportWap;

@synthesize supportWap;
@synthesize _toolbar ;
@synthesize userStopLoading ;
@synthesize netWorkError = _netWorkError;


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

- (id)initWithURL:(NSString *)url title:(NSString*)title{
    self = [super init];
    if (self) {
       	self._name = title;
		self._url = url;
    }
    return self; 
}


- (id)initWithURLAndType:(NSString *)url title:(NSString*)title type:(int)tp isSupportWap:(bool)support {
    self = [super init];
    if (self) {
       	self._name = title;
		self._url = url;
    }
    
    //taobao tmall etao
    if (tp==0 || tp==1) {
        
        NSRange foundObj=[url rangeOfString:@"?" options:NSCaseInsensitiveSearch];
        
        if(foundObj.length>0) { 
            self._url = [NSString stringWithFormat:@"%@&TTID=%@", url, __TTID__];
        }
        else {
            self._url = [NSString stringWithFormat:@"%@?TTID=%@", url, __TTID__];
        }
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Link＝Taobao"];
        
    }else {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Link＝Other"];
    }
    
    //set wap support
    self.supportWap = support;
    
    if (support) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL arg1:@"WapSupport＝YES"];
    }else {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL arg1:@"WapSupport＝NO"];
    }
    
    return self; 
}


-(void) goback {
	//    self.navigationController.navigationBarHidden=YES;
	self.navigationController.toolbarHidden = YES;
	[self.navigationController popViewControllerAnimated:YES];
}
	
 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView]; 
	CGRect frame = [UIScreen  mainScreen].applicationFrame ;
	// ?? by zhangsuntai 2011-09-23  
//	UIView *view = [[UIView alloc] initWithFrame:[UIScreen  mainScreen].applicationFrame];
//    self.view = view;
//    [view release];
	
	//self.navigationController.toolbarHidden = NO;  	
	
	//self.title = @"载入中..."; 
    
    UILabel *titleView = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 40)]autorelease];
    titleView.text = _name;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textAlignment = UITextAlignmentCenter;
    titleView.numberOfLines = 1 ;
    titleView.shadowColor = [UIColor grayColor];  
    titleView.textColor = [UIColor whiteColor];
    CGSize s = {-1.0,-1.0};
    titleView.shadowOffset = s; 
    titleView.shadowOffset = s;   
    self.navigationItem.titleView = titleView;
	
	UIWebView *aWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
	self.webView = aWebView ;
	[aWebView release];
	
	[self.webView  setUserInteractionEnabled:YES];
	[self.webView  setBackgroundColor:[UIColor clearColor]];
	[self.webView  setDelegate:self];
	[self.webView  setOpaque:NO];//使网页透明
	self.webView .scalesPageToFit = YES;
	self.webView .autoresizesSubviews = YES;
	self.webView .autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	self.webView .delegate = self ;       
    
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	
	self.space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]autorelease];
	self.back = [self backButton];
	self.next = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(goForward)]autorelease];

	self.refresh = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshWebView)]autorelease];
	self.stop = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(Stop)]autorelease];

	self.safari = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goSafari)]autorelease];

	UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, frame.size.height-88, 320, 44)]autorelease];
    toolbar.tintColor = [UIColor blackColor];
	self._toolbar = toolbar;
	[self._toolbar setItems:[NSArray arrayWithObjects:self.back,self.space,self.next,self.space,self.refresh,self.space,self.safari,nil] animated:YES];

	self.userStopLoading = NO ;
	 
	self.next.enabled = NO;
 	self.back.enabled = NO;
	
	self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]autorelease];
	UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
	self.navigationItem.rightBarButtonItem = activityItem;
	[activityItem release]; 
	
//	[self.view sendSubviewToBack: self.navigationController.toolbar];
	[self.view addSubview:self.webView]; 
	 
//	[self setToolbarItems:[NSArray arrayWithObjects:self.back,self.space,self.next,self.space,self.refresh,self.space,self.safari,nil] animated:YES];
	[self.view addSubview:toolbar];
    
    EtaoAlertWhenInternetNotSupportWap* allertView = [[EtaoAlertWhenInternetNotSupportWap alloc] initWithURL:self._url title:nil];
    [self.view addSubview: allertView.view];
    self.alertWhenInternetNotSupportWap = allertView;
    self.alertWhenInternetNotSupportWap.delegate = self;
    [allertView release];
    
    [self.view bringSubviewToFront:self.alertWhenInternetNotSupportWap.view];
    
    if (supportWap) {
        self.alertWhenInternetNotSupportWap.view.hidden = YES;
        self.webView.hidden = NO;
    }
    else {
        self.webView.hidden = YES;
        self.alertWhenInternetNotSupportWap.view.hidden = NO;
        self.title = @"跳转提示";
    }
    
    
    //
    UIImage* netErrorImg = [UIImage imageNamed:@"netnotwork.png"];
    UIImageView* netErrorimgView = [[[UIImageView alloc] initWithImage:netErrorImg]autorelease];
    netErrorimgView.center = self.view.center;
    [netErrorimgView setFrame:CGRectMake(netErrorimgView.frame.origin.x, 100, netErrorimgView.frame.size.width, netErrorimgView.frame.size.height)];
    netErrorimgView.hidden = YES;
    self.netWorkError = netErrorimgView;
    [self.view addSubview:netErrorimgView];
//	[self.webView release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	/*
	UIButton* backButton = [UIButton buttonWithType: 101]; // left-pointing shape!
	[backButton addTarget: self action: @selector(goback) forControlEvents: UIControlEventTouchUpInside];
	[backButton setTitle: @"返回" forState:UIControlStateNormal];
	UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
	[self.navigationItem setHidesBackButton:YES]; 
	self.navigationItem.leftBarButtonItem = backItem;
	[backItem release];
 	*/
	
    //vm=adclient
   
    if (supportWap) {
        
        NSURL *aURL = [NSURL URLWithString:self._url];
        
        NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
        [self.webView loadRequest:aRequest];	
        
        NSLog(@"viewDidLoad:%d",[self.space retainCount]);
	}
}


-(void)goSafari{
	NSLog(@"%@",self.webView.request.URL);
	UIActionSheet *ActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"在Safari打开" otherButtonTitles:nil];
	ActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
 
	[ActionSheet showInView:[self.view window]];
	[ActionSheet release];
	
	
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (0 == buttonIndex) {
		//[[UIApplication sharedApplication] openURL:self.webView.request.URL];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self._url]];
	}
}


-(void)Stop{
	self.userStopLoading = YES ;
	[self.webView stopLoading];	
}


-(void)refreshWebView{
	[self.webView reload];
}


-(void)goBack{
	[self.webView goBack];
}


-(void)goForward{
	[self.webView goForward];
}
 

//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"%@",self.webView.request.URL);
	[self.activityIndicator startAnimating];
	[self._toolbar setItems:[NSArray arrayWithObjects:self.back,self.space,self.next,self.space,self.stop,self.space,self.safari,nil] animated:YES];
    self.netWorkError.hidden = YES;
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.activityIndicator stopAnimating];
	//self.title = self._name;
	self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	if (self.webView.canGoBack) {
		self.back.enabled = YES;
	}
	if (self.webView.canGoForward) {
		self.next.enabled = YES;
	}
	[self._toolbar setItems:[NSArray arrayWithObjects:self.back,self.space,self.next,self.space,self.refresh,self.space,self.safari,nil] animated:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	[self.activityIndicator stopAnimating];
	self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	if (self.webView.canGoBack) {
		self.back.enabled = YES;
	}
	if (self.webView.canGoForward) {
		self.next.enabled = YES;
	}
	[self._toolbar setItems:[NSArray arrayWithObjects:self.back,self.space,self.next,self.space,self.refresh,self.space,self.safari,nil] animated:YES];

    //[EtaoShowAlert showAlert];
    self.title = @"正在加载...";
	if (self.userStopLoading) {
		return ;
	}
    self.netWorkError.hidden = NO;
    [self.view bringSubviewToFront:self.netWorkError];
}


/* 
- (CGContextRef)createContext
{
	// create the bitmap context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(nil,27,27,8,0,
												 colorSpace,kCGImageAlphaPremultipliedLast);
	CFRelease(colorSpace);
	return context;
}

- (CGImageRef)createBackArrowImageRef
{
	CGContextRef context = [self createContext];
	// set the fill color
	CGColorRef fillColor = [[UIColor blackColor] CGColor];
	CGContextSetFillColor(context, CGColorGetComponents(fillColor));
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 8.0f, 13.0f);
	CGContextAddLineToPoint(context, 24.0f, 4.0f);
	CGContextAddLineToPoint(context, 24.0f, 22.0f);
	CGContextClosePath(context);
	CGContextFillPath(context);
	// convert the context into a CGImageRef
	CGImageRef image = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	return image;
}
*/
- (UIBarButtonItem *)backButton
{ 
	 
 	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(nil,27,27,8,0, colorSpace,kCGImageAlphaPremultipliedLast);
 
	CFRelease(colorSpace);
	
	// set the fill color
	CGColorRef fillColor = [[UIColor blackColor] CGColor];
	CGContextSetFillColor(context, CGColorGetComponents(fillColor));
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 8.0f, 13.0f);
	CGContextAddLineToPoint(context, 24.0f, 4.0f);
	CGContextAddLineToPoint(context, 24.0f, 22.0f);
	CGContextClosePath(context);
	CGContextFillPath(context);
	// convert the context into a CGImageRef
	CGImageRef theCGImage = CGBitmapContextCreateImage(context);
	
	
	CGContextRelease(context); 	
 
	UIImage *backImage = [[UIImage alloc] initWithCGImage:theCGImage];
	CGImageRelease(theCGImage);
	UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithImage:backImage
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(goBack)] autorelease];
	[backImage release], 
	backImage = nil;
 	return backButton ;
}
 

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void) JumpToInternet {
    self.alertWhenInternetNotSupportWap.view.hidden = YES;
    self.webView.hidden = NO;
    
    NSURL *aURL = [NSURL URLWithString:self._url];
    
	NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
	[self.webView loadRequest:aRequest];	
	
	NSLog(@"viewDidLoad:%d",[self.space retainCount]);
    self.title = @"正在加载...";
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload { 	 
    [super viewDidUnload];
	
	self.activityIndicator = nil ;
	self.webView = nil;
	self.next = nil;
	self.back = nil; 
	self.refresh = nil;
	self.space = nil;
	self.stop = nil;
	self.safari = nil;

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {  
	[_webView release]; 
	[activityIndicator release]; 
	[next release];
	[back release];
	[refresh release];
	[space release];
	[stop release];
	[safari release];  
    [_netWorkError release];
	
    [super dealloc];
}


@end
