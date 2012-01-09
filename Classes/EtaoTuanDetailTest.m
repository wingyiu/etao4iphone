//
//  EtaoTuanDetailTest.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanDetailTest.h"
#import "HttpRequest.h"

@implementation EtaoTuanDetailTest
@synthesize  webview = _webview;
@synthesize tableView = _tableView;
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

 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
     
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain]autorelease];   
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
	
	
    [self.view addSubview:_tableView];
    [_tableView reloadData];

    
	self.webview = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)]autorelease]; 	
	[_webview  setUserInteractionEnabled:YES];
	[_webview  setBackgroundColor:[UIColor clearColor]];
	_webview.delegate = self; 
	_webview.scalesPageToFit = YES;
	_webview.autoresizesSubviews = YES;
	_webview.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth); 
    
    NSString *url = @"http://img04.taobaocdn.com/tps/i4/T1Q3iuXiFnXXXXXXXX";
   // NSString *url = @"http://stackoverflow.com/questions/2979854/uiwebview-get-total-height-of-contents-using-javascript";
	HttpRequest *httpquery = [[[HttpRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	[httpquery load:url]; 
    
    
    
}
 
- (void) requestFinished:(HttpRequest*)sender {
        
    HttpRequest * request = (HttpRequest *)sender; 
    NSData *data = request.data  ;	
     	
	if (data) 
	{
		//[NSThread sleepForTimeInterval:10];
		NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
		NSString *jsonString = [[[NSString alloc] initWithData:data encoding:enc]autorelease];         
        //NSString *njsonString = [jsonString stringByReplacingOccurrencesOfString:@"<img" withString:@"<p"];
        
        [_webview loadHTMLString:jsonString baseURL:[NSURL URLWithString:@""]];
        
        CGRect frame = _webview.frame;
        frame.size.height = 1;
        _webview.frame = frame;
        CGSize fittingSize = [_webview sizeThatFits:CGSizeZero];
        frame.size = fittingSize;
        _webview.frame = frame;
       //UIWebView.scalesPageToFit = YES;    
        
      // UIScrollView *vv = _webview.scrollView ;
        // get the height of your content
//        NSString *dd = [_webview stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight;"];
//        NSLog(@"stringByEvaluatingJavaScriptFromString%@",dd);
         
        // ISO5.0
        if([_webview respondsToSelector:@selector(scrollView)] ) { 
   //         _webview.scrollView.scrollEnabled=NO;
        } 
        [_webview setUserInteractionEnabled:NO];
         
        
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
    int val = [[_webview stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight;"] intValue];
    int width = [[_webview stringByEvaluatingJavaScriptFromString: @"document.body.offsetWidth;"] intValue];
    CGRect frame = _webview.frame;
    frame.size.height = val * 320/width;
    NSLog(@"height: %f", frame.size.height); //return 2166
    _webview.frame = frame;
    _tableView.tableFooterView = _webview;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 ;	
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
	
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"";
}
 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%s", __FUNCTION__); 
	NSLog(@"%d", [indexPath row]); 
    UITableViewCell *cell1 = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]autorelease]; 
    cell1.textLabel.text = @"dd";
    if (indexPath.row == 1 ) {
        
     //   [cell1 addSubview:_webview];
    }
    return cell1;
 
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 

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
//	[self._tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
