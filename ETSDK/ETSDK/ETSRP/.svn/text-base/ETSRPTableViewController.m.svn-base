//
//  ETSRPTableViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETSRPTableViewController.h"
#import "ETTableViewCell.h" 


@implementation ETSRPTableViewController

@synthesize datasource =_datasource ;
@synthesize tableView = _tableView ;


- (id)init
{
    self = [super init];
     
    if (self) {
        // Custom initialization
        _queue = [[ASINetworkQueue alloc]init];   
        [_queue setMaxConcurrentOperationCount:4];
        [_queue setSuspended:NO];
        _loadingImageDic = [[NSMutableDictionary alloc]initWithCapacity:100];
        _imageCache = [[NSMutableDictionary dictionaryWithCapacity:20] retain];
        _httpImageArr = [[NSMutableArray alloc]initWithCapacity:10];
        
        
    }
    return self;
}


- (void) dealloc {
    
    [_queue cancelAllOperations];
    [_queue release];
    [_imageCache release ];
    if (_httpImageArr != nil) {
        for (ETHttpImageView *v in _httpImageArr) {
            [v cancel];
        }
        [_httpImageArr removeAllObjects];
        [_httpImageArr release]; 
    } 
    
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView {
    [super loadView]; 
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain]autorelease];  
    [self.view addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
}
/*
// 请求完成
- (void) ETSRPDataSourceRequestFinished:(ETSRPDataSource *)request {
    [_tableView reloadData];
}
// 请求失败
- (void) ETSRPDataSourceRequestFailed:(ETSRPDataSource *)request {
    
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; 
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    // Return the number of rows in the section.
    return [_datasource count] ; 
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [ETTableViewCell height];
	
}
 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	NSLog(@"%s",__FUNCTION__);
//    [_queue setMaxConcurrentOperationCount:2];
//    [_queue setSuspended:NO];
    [[ASIHTTPRequest sharedQueue] setMaxConcurrentOperationCount:2];
    NSArray *operation_array = [[ASIHTTPRequest sharedQueue] operations];
    for (int i = 0; i<[operation_array count]; i++) {
        [[operation_array objectAtIndex:i] setQueuePriority:NSOperationQueuePriorityVeryLow];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
      NSLog(@"%s",__FUNCTION__);  
//    [_queue setMaxConcurrentOperationCount:4];
//    [_queue setSuspended:NO];  
    [[ASIHTTPRequest sharedQueue] setMaxConcurrentOperationCount:4];
    for (id c in [self.tableView visibleCells]) {
////        if ([c  isMemberOfClass:[ETTableViewCell class]]) {   
//        ETTableViewCell *cell = (ETTableViewCell*)c;
////            for (ETHttpImageView *httpImg in _httpImageRequest) { 
////                if ([cell.pictUrl isEqualToString:httpImg.url]) {
////                    [httpImg.http setQueuePriority:NSOperationQueuePriorityNormal];
////                }
////            }
//        if([cell respondsToSelector:@selector(setHttpImageView:)]){
//            if(cell.httpImageView !=nil){
//                [cell.httpImageView.http setQueuePriority:NSOperationQueuePriorityHigh];
//            }
////        }
//        }
    } 
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{ 
    NSLog(@"%s",__FUNCTION__);
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{ 
/*    
    if ([cell isKindOfClass:[ETTableViewCell class]]) {
        ETTableViewCell *cell1 = (ETTableViewCell *)cell;
        [cell1.httpImage.http setQueuePriority:NSOperationQueuePriorityNormal];
    } */    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
