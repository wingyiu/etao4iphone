//
//  EtaoSRP4SqureController.m
//  etao4iphone
//
//  Created by 稳 张 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRP4SqureController.h"
#import "EtaoSRP4SqureCell.h"
#import "EtaoLoadMoreCell.h"
#import "EtaoSRPHomeController.h"
#import "NSObject+SBJson.h"
#import "EtaoCategoryNavController.h"
#import "EtaoShowAlert.h"
#import "EtaoNoResultView.h"
#import "ActivityIndicatorMessageView.h"
#import "EtaoAuctionPriceCompareHistoryViewController.h"

#import "ETaoHistoryViewController.h"
#import "etao4iphoneAppDelegate.h"
#import "EtaoSystemInfo.h"
#import "EtaoUIBarButtonItem.h"


@interface EtaoSRP4SqureController() {
    
    int scrollViewAddItemCount;
}

- (void) add4SqureViewByIndex:(int) index;

@end

@implementation EtaoSRP4SqureController
@synthesize _srpdata; 
@synthesize _isLoading; 
//@synthesize _tableView; 
@synthesize _keyword;
@synthesize _head ;
@synthesize _ppath;
@synthesize _catid;
@synthesize _rankView ;
@synthesize _sort ;
@synthesize detailDirect = _detailDirect ;
@synthesize _rankbtnv ;
@synthesize _requestFailed ;
@synthesize _httpquery ;

@synthesize scrollView = _scrollView;

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
//[self sort:@"shopDistance"];



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];     
    
//	EtaoUIBarButtonItem* nav = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"筛选" bkColor:[UIColor lightGrayColor] target:self action:@selector(navButtonTapped:)]autorelease];
//        
//	self.navigationItem.rightBarButtonItem = nav; 
 	
    if (_scrollView == nil) {
        
        scrollViewAddItemCount = 0;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator=NO; //水平滚动条隐藏
        _scrollView.showsVerticalScrollIndicator=NO;//垂直滚动条隐藏
        
        [_scrollView setBackgroundColor:[UIColor whiteColor]];

        [self.view addSubview:_scrollView];
    }
    
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width*(_scrollView.subviews.count), _scrollView.bounds.size.height)]; 
        
	self._isLoading = NO; 
	self._requestFailed = NO;
	
	EtaoSRPDataSource * datas = [[EtaoSRPDataSource alloc]init];
	self._srpdata = datas;
	[datas release];
	
	EtaoLocalListHeadDistanceView *headview = [[EtaoLocalListHeadDistanceView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
 	self._head = headview;
	[self.view addSubview:headview];
    [headview release];
		
//	EtaoMenuView *pop = [[EtaoMenuView alloc] initWithFrame:CGRectMake(62.5f, 0.0f, 195.0f, 153.0f)];
//	self._rankView = pop ; 
//	[pop addTarget:self action: @selector(rankbtnselected:)];
//	[self.view addSubview:pop]; 
//	[pop release];
}


- (void)navButtonTapped:(id)sender { 
    //   if ([sender isKindOfClass:[UIBarButtonItem class]]) {	
    EtaoCategoryNavController * catNavController = [[[EtaoCategoryNavController alloc] initWithWord:_keyword cat:_catid pidvid:_ppath ]autorelease]; 
    
    [self.navigationController pushViewController:catNavController animated:YES]; 
    
    [self._rankView disappeared];
    self._rankbtnv._selected = YES;
    [self._rankbtnv doArrow]; 
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-CategoryFilter"];
}  


-(void) rankClick:(id)sender
{
	if (self._rankView._appeared) {
		UIButton *rankbtn = (UIButton *)sender;
		rankbtn.selected = YES;
		self._rankbtnv._selected = YES;
		[self._rankbtnv doArrow];
		[self._rankView disappeared];
	}
	else {
		self._rankbtnv._selected = NO;
		[self._rankbtnv doArrow];
		[self._rankView appeared];
	} 
}


//-(void) rankbtnselected:(id)sender
//{
//	if ([sender isKindOfClass:[UIButton class]]) {
//		UIButton *btn = (UIButton*) sender;
//		NSLog(@"%d",btn.tag);
//		NSString *text = @"排序";
//		if (btn.tag == 0) {
//			_sort = @"sale-desc";
//			text = @"销量降序";
//		}
//		else if(btn.tag == 1){
//			_sort = @"price-asc";
//			text = @"价格升序";
//		}
//		else if(btn.tag == 2){
//			_sort = @"price-desc";
//			text = @"价格降序";
//		}
//		else if(btn.tag == 3){
//			_sort = nil;
//			text = @"人气降序";
//		} 
//		[self._srpdata clear];
//		[self searchWord:self._keyword cat:self._catid ppath:self._ppath];
//		//[self._tableView reloadData];
//		[self._rankView disappeared];
//		self._rankbtnv._selected = YES;
//		[self._rankbtnv setText:text];
//		[self._rankbtnv doArrow];
//        
//        scrollViewAddItemCount = 0;
//        NSMutableArray* scrollArray = (NSMutableArray*)[_scrollView subviews]; 
//        
//        if (scrollArray != nil) {
//            [scrollArray removeAllObjects];
//        }
//        
//        [_scrollView reloadInputViews];
//	}
//    
//    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Sort"];
//}	 


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];  
//	EtaoCustomButtonView *btnView = [[EtaoCustomButtonView alloc] initWithFrame:CGRectMake(0,0,200,30)];
//	btnView.delegate = self;
//	btnView.buttonClick = @selector(rankClick:);
//	self.navigationItem.titleView = btnView;
//	self._rankbtnv = btnView;
//	[btnView release];
}


- (void) searchWord:(NSString*)word cat:(NSString*)cat ppath:(NSString*)ppath {
	
	ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
	[loadv startAnimating];
	[self.view addSubview:loadv]; 
	[self.view bringSubviewToFront:loadv]; 
	//self._tableView.hidden = YES;
	
	_keyword = word ; 
	_catid = cat;
	_ppath = ppath;	 
	
	[self._srpdata clear];
	[self retain];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:10],nil];
	[self loadMoreFrom:startEnds];
}


// first search 
- (void) search:(NSString*)keyword{ 
	
	ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
	[loadv startAnimating];
	[self.view addSubview:loadv]; 
	[self.view bringSubviewToFront:loadv]; 
	//self._tableView.hidden = YES;
	
	_keyword = keyword ;//;[NSString stringWithFormat:@"%@",keyword];
	[self._srpdata clear];
	//[self._tableView reloadData];
	[self retain];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:10],nil];
	[self loadMoreFrom:startEnds];
	//[self loadMoreFrom:0 TO:10];
}


- (void) requestFinished:(EtaoSRPRequest *)sender { 
	NSLog(@"%s", __FUNCTION__);  
	for (UIView *v in [self.view subviews]) {
		if ([v isKindOfClass:[ActivityIndicatorMessageView class]]) {
			ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)v;
			if (loadv!=nil) { 
				[loadv stopAnimating];
			}
		}
	}
    
    [self release]; 
    
	// self._tableView.hidden = NO;
	self._requestFailed = NO; 
	EtaoSRPRequest * request = (EtaoSRPRequest *)sender;
	[self._srpdata addItemsByJSON:request.jsonString];
    
    //返回数据为详情页时，显示详情页
    if ([self._srpdata._searchType isEqualToString:@"detail"] == YES) {
        if (_detailDirect == nil) {
            _detailDirect = [[SearchDetailController alloc] init];
            self.view = _detailDirect.view;
			_detailDirect.delegate = self;
        }
        
        [_detailDirect setJsonData:request.jsonString];
        
        self.navigationItem.titleView = nil;
        self._rankbtnv.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.title = @"产品详情";
        
        //add to history
//        UIApplication *app = [UIApplication sharedApplication];
//        etao4iphoneAppDelegate *delegate = (etao4iphoneAppDelegate *)app.delegate;
//        EtaoAuctionPriceCompareHistoryViewController *history = [delegate etaoAuctionPriceCompareHistoryViewController];
//        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:0];
//        if (cell!=nil && [cell isKindOfClass:[EtaoSRPCell class]]) {
//            [history insertNewObject:cell]; 
//        }         
        return;
    }
    
	NSLog(@"%@",self._srpdata.items);
	NSLog(@"request=%d",[request retainCount]);
	
	if ([self._srpdata emptyForCategory]) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
    
	if ([self._srpdata.items count] > 0 ) {
		[self._head setHidden:YES];//setTextForSRP:self._keyword Total:self._srpdata._totalCount Now:1];
 	} 
	else {
        [self._head setHidden:NO];
		[self._head setText:@"很抱歉，没有找到符合条件的商品。"];
	}
    
    
	//[self._tableView reloadData];
	self._isLoading = NO; 
	NSLog(@"reloadData end"); 
	
	self._httpquery = nil;

    int tempPage = self._srpdata.count/4;
    
    if (self._srpdata.count%4 != 0) {
        tempPage++;
    }
    
    int tempCount = tempPage*4;
    
    if (tempCount > self._srpdata._totalCount) {
        tempCount = self._srpdata._totalCount;
    }
        
    for (int i=scrollViewAddItemCount; i<tempCount; i++) {
        [self add4SqureViewByIndex:i];
    }
    
    scrollViewAddItemCount = self._srpdata.count;
    
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width*(_scrollView.subviews.count), _scrollView.bounds.size.height)]; 
    
}


- (void) requestFailed:(EtaoSRPRequest *)sender{  
	NSLog(@"%s", __FUNCTION__); 
	//self._tableView.hidden = NO;
	//[EtaoShowAlert showAlert];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
	self._isLoading = NO; 
	//httpquery.delegate = nil;
	for (UIView *v in [self.view subviews]) {
		if ([v isKindOfClass:[ActivityIndicatorMessageView class]]) {
			ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)v;
			if (loadv!=nil) { 
				[loadv stopAnimating];
			}
		}
        
	} 
	self._requestFailed = YES;
	//[self._tableView reloadData];
	[self release]; 
	self._httpquery = nil;
}


- (void) loadMoreFrom:(int)s TO:(int)e {
    
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
	if (_sort != nil) {
		[dict setValue:_sort forKey:@"sort"];
	}
    
	NSString *loginfo = [NSString stringWithFormat:@"%@;srp;search",[UIDevice currentDevice].uniqueIdentifier];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start];  
}


- (void) loadMoreFrom:(NSArray*)startEnds{
    
	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];
	self._httpquery = httpquery;
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:); 
	
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
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
	if (_sort != nil) {
		[dict setValue:_sort forKey:@"sort"];
	}
    
	EtaoSystemInfo *sys = [EtaoSystemInfo sharedInstance];
	NSString *loginfo = [NSString stringWithFormat:@"%@;srp;search;%@;%@",[UIDevice currentDevice].uniqueIdentifier,sys.userLocation,sys.userLocationDetail];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 	
	[httpquery start];  
}


- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",indexPath);
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	NSLog(@"%@",scrollView);
	[self._rankView disappeared];
	self._rankbtnv._selected = YES;
	[self._rankbtnv doArrow]; 
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
	NSLog(@"scrollViewDidScrollToTop");	
	
}


- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
	NSLog(@"%@",scrollPosition);
	
}


- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
	//The rest of your stuff you need to do
	return proposedDestinationIndexPath;
}


#pragma mark -
#pragma mark Table view data source


- (void) reloadLastRequest:(id)sender{ 
	int count = [self._srpdata count];
	NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:10],nil];
	//[self loadMoreFrom:startEnds];
	[self retain];
	[self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1];
	
    return ;
    
	if ( self._httpquery != nil) {
		[self retain];
		[self._httpquery start];
	} 
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	//_tableView = nil;
	_srpdata = nil ;
	_head = nil ;
	//_detailDirect=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void) add4SqureViewByIndex:(int) index {
    
    UIView* pageView = nil;
    
    int i = index/4;
    
    if ([_scrollView.subviews count] > i) {
        pageView = [_scrollView.subviews objectAtIndex:i];
    }
    else {
        pageView = [[[UIView alloc] init] autorelease];
        [_scrollView addSubview:pageView];
    }   
    
    [pageView setFrame:CGRectMake(self.view.bounds.size.width*i, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    i = index % 4;
    
  //  for (int i=0; i<4; i++) {
    EtaoSRP4SqureCell* etao4SqureCell = nil;
    
    for (int j=0; j<[[pageView subviews] count]; j++) {
        UIView* tempView = [[pageView subviews] objectAtIndex:j];
        if ([tempView isKindOfClass:[EtaoSRP4SqureCell class]]) {
            if ([(EtaoSRP4SqureCell*)tempView tag] == i) {
                etao4SqureCell = (EtaoSRP4SqureCell*)tempView;   
            }
        }
    }
    
    if (etao4SqureCell == nil) {
        etao4SqureCell = [[EtaoSRP4SqureCell alloc] initWithFrame:CGRectMake(((i+2)%2)*160, (i/2)*180+10, 160, 180)]; 
        etao4SqureCell.tag = index;
        [pageView addSubview:etao4SqureCell];
        etao4SqureCell.parent = self;
    }
    
    id tempitem = nil;
    if (index < self._srpdata.count) {
        tempitem = [self._srpdata objectAtIndex:index];
    }
    
    if (tempitem == nil) {
        
        if (nil == etao4SqureCell.loadv) {
            etao4SqureCell.loadv = [[[ActivityIndicatorMessageView alloc] initWithFrame:[etao4SqureCell bounds] Message:@"正在加载"] autorelease];
            [etao4SqureCell.loadv startAnimating];
            [etao4SqureCell addSubview:etao4SqureCell.loadv]; 
         }
        [etao4SqureCell bringSubviewToFront:etao4SqureCell.loadv];
        [etao4SqureCell.loadv startAnimating];
        return;
    } else {
        [etao4SqureCell.loadv stopAnimating];
        [etao4SqureCell sendSubviewToBack:etao4SqureCell.loadv];
    }
    
    etao4SqureCell.httpImg.contentMode = UIViewContentModeScaleAspectFit;
    etao4SqureCell.httpImg.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    
    if ( [tempitem isKindOfClass:[EtaoProductItem class]] ) {
        EtaoProductItem *item = (EtaoProductItem*) tempitem;
        
        NSString *picturl = [NSString stringWithFormat:@"%@_120x120.jpg",item.pictUrl];
        [etao4SqureCell.httpImg setUrl:picturl];
        etao4SqureCell.item = item;
        
        etao4SqureCell.label.text = item.title;
    }
    else {
        EtaoAuctionItem *item = (EtaoAuctionItem*) tempitem;
        
        NSString *picturl = [NSString stringWithFormat:@"%@_120x120.jpg",item.pic];
        [etao4SqureCell.httpImg setUrl:picturl];
        etao4SqureCell.item = item;
        
        etao4SqureCell.label.text = item.title;
        
    }
        
//    CALayer *layer = [httpImageView layer];
//    [layer setMasksToBounds:YES];
//    [layer setCornerRadius:0.0];
//    [layer setBorderWidth:0.0];
//    [layer setBorderColor:[[UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0]  CGColor]];	
//    
//    [httpImageView setFrame:imageButton.frame];
//    
//    [imageButton setImage:httpImageView.image forState:UIControlStateNormal]; 

    //[imageButton bringSubviewToFront:imageButton.titleLabel];

    [etao4SqureCell.button addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.bounds.size.width;
    
    
    if ((index+1)*4 >= [_srpdata count] ) {
        
        NSUInteger row = (index+1)*4;
        NSUInteger count = [self._srpdata count];

        
        if (count == 0 || count == self._srpdata._totalCount) {
            return;
        }
        
        if (row >= count ) {
            
            if (self._isLoading == YES || self._requestFailed == YES) {
                return;
            } 
            self._isLoading = YES;  
            
            NSArray *startEnds = [NSArray arrayWithObjects:[NSNumber numberWithInt:count],[NSNumber numberWithInt:10],nil]; 
            [self retain];
            [self performSelector:@selector(loadMoreFrom:) withObject:startEnds  afterDelay:0.1];
        } 
    }
    
//    currentPageIndex = index;
//    //index为当前页码
//    
//    if (currentPageIndex == [_itemsPageArray count]-1) {
//        
//        int offset = ((int)scrollView.contentOffset.x)%((int)scrollView.frame.size.width);
//        NSString* tempStr = [NSString stringWithFormat:@"__%d__", offset];
//        
//        NSLog(tempStr,nil);
//        
//        if (((int)scrollView.contentOffset.x)%((int)scrollView.frame.size.width) > 100) {
//            [self showFinished];
//        }
//    }
}


-(IBAction)ButtonClicked:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
//    int index = [btn.superview tag];
    
    UIApplication *app = [UIApplication sharedApplication];
    etao4iphoneAppDelegate *delegate = (etao4iphoneAppDelegate *)app.delegate;
    
    ETaoHistoryViewController *his = [delegate etaoHistoryViewController];

    id cell = btn.superview;
    
	if ([cell isKindOfClass:[EtaoSRP4SqureCell class]]) {
        EtaoSRP4SqureCell *etaoinfo = (EtaoSRP4SqureCell*) cell; 
        
        if ( [etaoinfo.item isKindOfClass:[EtaoProductItem class]] ){
            EtaoProductItem *item =  etaoinfo.item;  
            NSString *json = [[item toDictionary] JSONRepresentation];
            
            [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.pid hash]] Name:@"product" JSON:json];
        }
        else {
            EtaoAuctionItem *item =  etaoinfo.item;   
            NSString *json = [[item toDictionary] JSONRepresentation];
            [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.nid hash]] Name:@"auction" JSON:json];
        }
        
        [etaoinfo setSelected:YES animated:NO];
	} 
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndex"];

}


- (void)dealloc {  
    
	if (self._httpquery != nil) {
		self._httpquery.delegate = nil ;
        [_httpquery release];
	}
    
	[_scrollView release]; 
	[_srpdata release]; 
	[_head release]; 
    [_detailDirect release];
    [_rankbtnv release];

    //    [_rankView release];      
    
	[super dealloc];
}


@end
