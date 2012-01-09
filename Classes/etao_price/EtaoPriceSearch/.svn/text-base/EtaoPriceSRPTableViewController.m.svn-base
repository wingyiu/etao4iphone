//
//  EtaoPriceSRPTableViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceSRPTableViewController.h"
#import "EtaoPriceSRPDataSource.h"
#import "EtaoPriceListCell.h"
#import "NSObject+SBJson.h"
#import "EtaoPriceAuctionItem.h"
#import "EtaoLoadMoreCell.h"
#import "ETPageSwipeController.h"
#import "EtaoPriceAuctionDetailController.h"


@implementation EtaoPriceSRPTableViewController

@synthesize requestUrl = _requestUrl;
@synthesize keyword = _keyword;
@synthesize ppath = _ppath;
@synthesize catid = _catid;
@synthesize sort = _sort;
@synthesize website = _website;
@synthesize start_price = _start_price;
@synthesize end_price = _end_price;
@synthesize head = _head;


- (void)dealloc {
    
    [_datasource release];
    [_requestUrl release];
    [_head release];
    [super dealloc];
}


- (id) init {
    
    self = [super init];
    
    _datasource = [[EtaoPriceSRPDataSource alloc]init];
    _datasource.delegate = self;
    _datasource.pageCount = SRP_PAGE_COUNT;
    _requestUrl = [[ETUrlObject alloc]init];
    
    _head= [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 0, 320,30)]; 
	
    
    return self;
    
}


- (void) loadView{
    [super loadView];
    self.title = [NSString stringWithFormat:@"实时降价-%@",self.keyword];
    [self.view addSubview:_head]; 
    _tableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,30)]autorelease]; 
}


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



#pragma mark ---------datasource------------
// 请求完成
- (void) ETSRPDataSourceRequestFinished:(ETSRPDataSource *)request {
    [_tableView reloadData];
    
    if ([_datasource.items count] > 0 ) {
		[_head setTextForSRP:_keyword Total:_datasource.totalCount Now:1];
 	} 
	else {
		[_head setText:@"很抱歉，没有找到符合条件的商品。"];
	}
    
    
    
}


// 请求失败
- (void) ETSRPDataSourceRequestFailed:(ETSRPDataSource *)request {
    [super ETSRPDataSourceRequestFailed:request];
}


- (void) loadMoreFrom:(NSArray*)startEnds{ 
	
    if ( [_datasource isKindOfClass:[EtaoPriceSRPDataSource class]] ) {  
        
        [_requestUrl addParam:@"mtop.etao.search.cutprice" forKey:@"api"];
        [_requestUrl addParam:@"*" forKey:@"v"];
        
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
        if (_website != nil) {
            [dict setValue:_website forKey:@"fseller"];
        }
        if (_sort != nil) {
            [dict setValue:_sort forKey:@"sort"];
        }
        if (_start_price != nil) {
            [dict setValue:_start_price forKey:@"start_price"];
        }
        if (_end_price != nil) {
            [dict setValue:_end_price forKey:@"end_price"];
        }
        
        [_requestUrl addParam:[dict JSONRepresentation] forKey:@"data"]; 
        NSLog(@"%@",[_requestUrl getRequesrUrl]);
        [_datasource setUrl:[_requestUrl getRequesrUrl]];  
        [_datasource start];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",[_httpImageRequest count]);
    static NSString *CellIdentifier = @"Cell";
    static NSString *moreCellId = @"moreCell"; 
    
    NSUInteger row = [indexPath row];
	NSUInteger count = [_datasource count];
    
    if (row == count ) { 
		EtaoLoadMoreCell * cell = (EtaoLoadMoreCell*)[tableView dequeueReusableCellWithIdentifier:moreCellId];
		if (cell == nil) {
			cell = [[[EtaoLoadMoreCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
            UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            [selectedView release];
            
		} 
		cell._parent = self; 
		if ( _datasource.status == 0 ) {
			[cell setReload];
			cell.delegate =self;
			cell.action = @selector(reloadLastRequest:);
		}
        else
        {
            //          NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:20],nil];  
            //          [self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1];
        }
		return cell; 
	}
    
    else
    {
        EtaoPriceListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[EtaoPriceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.queue = _queue;
            cell.loadingImageDic = _loadingImageDic;
            cell.httpImageRequestArr = _httpImageArr;
            [cell setImageFrame:CGRectMake(5, 5, 90, 90)];
            
            UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } 
        else
        { 
        }
        if ([_datasource count] == 0 ) {
            return cell;
        }
        
        id item = [_datasource.items objectAtIndex:[indexPath row]]; 
        if ([item isKindOfClass:[EtaoPriceAuctionItem class]]) {
            NSString *picturl = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_120x120.jpg",((EtaoPriceAuctionItem*)item).image]; 
            [cell setItem:item url:picturl]; 
        }  
        
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    
	NSUInteger row = [indexPath row];
	NSUInteger count = [_datasource count];
	
    int maxidx = 0 ;
    for (id c in tableView.visibleCells) {
		if ([ c isKindOfClass:[EtaoPriceListCell class]]) {
			EtaoPriceListCell *vc = (EtaoPriceListCell*)c ;  
            int idx = [_datasource.items indexOfObject:vc.item];
            if ( idx > maxidx) maxidx = idx ; 
		}
	}
    
    [_head setTextForSRP:_keyword Total:_datasource.totalCount Now:maxidx]; 
    
	
	// load more
	if (count == 0 || count == _datasource.totalCount) {
		return;
	}
	
	if (row > count - 5 ) {
		
		if ( _datasource.loading ) {
			return;
		}  
		_datasource.loading = YES ;
		NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:20],nil];  
        [self loadMoreFrom:startEnds];
		//[self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0];
	}     
}


#pragma mark -v swipe delegate
- (void)swipeAtIndex:(NSNumber *)index withCtrls:(UIViewController *)controller{
    if([index intValue] > [_datasource.items count] -5){
        NSUInteger count = [_datasource count];
        if ( _datasource.loading ) {
			return;
		}  
		_datasource.loading = YES ;
		NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:20],nil];  
        [self loadMoreFrom:startEnds];

    }
}


- (void)swipeWillExitAtIndex:(NSNumber *)index{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:[index intValue] inSection:0];
    [self.tableView selectRowAtIndexPath:indexP animated:YES scrollPosition:UITableViewScrollPositionTop];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row < _datasource.count){
        ETPageSwipeController* detailSwipe = [[[ETPageSwipeController alloc]initWithItems:_datasource.items 
                                                                             withDelegate:self 
                                                                                  atIndex:indexPath.row 
                                                                            byDetailClass:[EtaoPriceAuctionDetailController class]]autorelease];
        
        [self.navigationController pushViewController:detailSwipe animated:YES];
        
    } 
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [EtaoPriceListCell height];
	
}


- (void) search:(NSString*)keyword{     
    
    self.keyword = keyword ; 
    [_datasource clear];
    [self.tableView reloadData]; 
    NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:SRP_PAGE_COUNT],nil];
    [self loadMoreFrom:startEnds]; 
}


- (void) searchWord:(NSString*)keyword cat:(NSString*)cat ppath:(NSString*)ppath website:(NSString*) website start_price:(NSString *)start_price end_price:(NSString *)end_price sort:(NSString*) sort{
    self.keyword = keyword ; 
    self.catid = cat;
    self.ppath = ppath ;
    self.website = website;
    self.start_price = start_price;
    self.end_price = end_price;
    self.sort = sort;
    [_datasource clear];
    [self.tableView reloadData]; 
    NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:SRP_PAGE_COUNT],nil];
    [self loadMoreFrom:startEnds];   
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

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
