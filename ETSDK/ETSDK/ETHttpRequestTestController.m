//
//  ETHttpRequestTestController.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETHttpRequestTestController.h"
#import "ETHttpImageView.h"
#import "ASINetworkQueue.h"
#import "ETHttpRequestTestController.h"
#import "ETDetailSwipeController.h"

@implementation ETHttpRequestTestController
@synthesize httpr = _httpr;
@synthesize progress = _progress;

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

-(void) dealloc{
    [_httpr cancel];
    [_httpr release];
    [super dealloc];
}
 

- (void) buttonClick:(UIButton*)btn{
    if ([btn.titleLabel.text isEqualToString:@"http"]) { 
        ETHttpRequestTestController *v = [[[ETHttpRequestTestController alloc]init]autorelease];
        [self.navigationController pushViewController:v animated:YES];
    }
    
    if ([btn.titleLabel.text isEqualToString:@"swipe"]) { 
        ETDetailSwipeController *v = [[[ETDetailSwipeController alloc]init]autorelease];
        v.cls = [ETHttpRequestTestController class];
        [self.navigationController pushViewController:v animated:YES];
    }
    
}

- (void) setDetailFromItem:(id) item {
    
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);
    [super loadView];
    
    self.view.backgroundColor = [UIColor purpleColor];
    self.httpr = [[[ETHttpRequest alloc]init]autorelease]; 
    //[_httpr load:@"http://labs.renren.com/apache-mirror//httpd/httpd-2.2.21.tar.gz"]; 
    //[_httpr load:@"http://img03.taobaocdn.com/imgextra/i3/33517821/T2tg42XlXXXXXXXXXX_!!33517821.jpg"];
    _httpr.delegate = self;
    _httpr.secondsToCache = 10 ; 
    


    
    self.progress = [[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)]autorelease];
    _progress.text = @"0";
    [self.view addSubview:_progress];
    

    [_httpr load:@"http://m.taobao.com/rest/api2.do?api=com.taobao.wap.rest2.etao.search&data=%7B%22q%22:%22%E6%89%8B%E5%A5%97%22,%22n%22:10,%22_app_from_%22:%2251710897-DA94-500A-B4D2-E0B22BB71163;srp;search;(null);(null)%22,%22s%22:0%7D&v=*"];
    
    
    UIButton *http = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    http.frame = CGRectMake(100, 0, 100, 30);
    [http setTitle:@"http" forState:UIControlStateNormal];
    [http addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:http];
    
    UIButton *swipe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    swipe.frame = CGRectMake(100, 40, 100, 30);
    [swipe setTitle:@"swipe" forState:UIControlStateNormal];
    [swipe addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:swipe];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *arr = [NSArray arrayWithObjects:@"http://img03.taobaocdn.com/imgextra/i3/33517821/T2tg42XlXXXXXXXXXX_!!33517821.jpg",
                    @"http://img01.taobaocdn.com/imgextra/i1/33517821/T2gMp2XhhbXXXXXXXX_!!33517821.jpg",
                    @"http://img03.taobaocdn.com/imgextra/i3/33517821/T2E3V2XahaXXXXXXXX_!!33517821.jpg",
                    @"http://img04.taobaocdn.com/imgextra/i4/33517821/T2T3B2XnXaXXXXXXXX_!!33517821.jpg",
                    @"http://img04.taobaocdn.com/imgextra/i4/33517821/T2S3t2XnBbXXXXXXXX_!!33517821.jpg",
                    @"http://img01.taobaocdn.com/imgextra/i1/775053161/T2bd8.XcNaXXXXXXXX_!!775053161.jpg",
                    @"http://img01.taobaocdn.com/imgextra/i1/775053161/T2.1X.XXXaXXXXXXXX_!!775053161.jpg",
                    @"http://img03.taobaocdn.com/imgextra/i3/775053161/T2rKl.XlRXXXXXXXXX_!!775053161.jpg",
                    @"http://img04.taobaocdn.com/imgextra/i4/775053161/T2oKt.XjXXXXXXXXXX_!!775053161.jpg",
                    @"http://img04.taobaocdn.com/imgextra/i4/775053161/T2heB.XgBXXXXXXXXX_!!775053161.jpg",
                    @"http://img01.taobaocdn.com/imgextra/i1/775053161/T2Y1F.XehXXXXXXXXX_!!775053161.jpg",
                    @"http://img02.taobaocdn.com/imgextra/i2/775053161/T2z1N.XbBXXXXXXXXX_!!775053161.jpg",
                    @"http://img02.taobaocdn.com/imgextra/i2/761275116/T2yZx3Xa4bXXXXXXXX_!!761275116.jpg",
                    @"http://img04.taobaocdn.com/imgextra/i4/761275116/T2Tcx3XX8bXXXXXXXX_!!761275116.jpg",
                    @"http://img01.taobaocdn.com/imgextra/i1/761275116/T2tsB3XotaXXXXXXXX_!!761275116.jpg",
                    @"http://img02.taobaocdn.com/bao/uploaded/i2/T1.LavXeJGXXaJm.U1_042624.jpg_b.jpg",
                    @"http://img01.taobaocdn.com/bao/uploaded/T1wuiFXgddXXb1upjX_b.jpg",
                    nil];
    
    int y = 0 ; 
    for (NSString* url in arr) {
        ETHttpImageView *image = [[[ETHttpImageView alloc]initWithFrame:CGRectMake(0, y, 50, 50)]autorelease];
        image.delegate = self;
        image.secondsToCache = 20 ;
        image.maxConcurrentOperationCount = 2 ;
        //[image load:url]; 
        y+=50;
        [self.view addSubview:image];  
        
    }
  
    
}
 
- (void) httpImageSizeRecive:(ETHttpImageView *)httpimage {
    NSLog(@"httpImageSizeRecive=%f,%f",httpimage.size.width,httpimage.size.height);
}

- (void) httpImageLoadFinished:(ETHttpImageView *)httpimage {
    NSLog(@"%s",__FUNCTION__);
}

- (void) requestFinished:(ETHttpRequest *)request {
    _progress.text = [NSString stringWithFormat:@"100%%"];
}
- (void) requestFailed:(ETHttpRequest *)request {
    
}
- (void)request:(ETHttpRequest *)request didReceiveData:(NSData *)data{
    //NSLog(@"%d",[data length]); 
}

- (void) requestProgress:(NSNumber *)progress {
    NSLog(@"progress=%@",progress);
    _progress.text = [NSString stringWithFormat:@"%@%%",progress];
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
