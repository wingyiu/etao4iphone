//
//  EtaoPriceImageController.m
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceImageController.h"
#import "TBMemoryCache.h"

@implementation HttpimageViewTouchController
@synthesize item = _item;
@synthesize imgView = _imgView;


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    EtaoPriceDetailController* etaopricedetailcontroller = [[[EtaoPriceDetailController alloc]init] autorelease];
    etaopricedetailcontroller.item = _item;

    CGRect frame = etaopricedetailcontroller.view.frame;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    frame.origin.x = window.frame.size.width/2;
    frame.origin.y = window.frame.size.height/2;
    frame.size.width = 0;
    frame.size.height = 0;
    etaopricedetailcontroller.view.frame = frame;
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.3];
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = window.frame.size.width;
    frame.size.height = window.frame.size.height;
    etaopricedetailcontroller.view.frame = frame;
    [UIView commitAnimations];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:etaopricedetailcontroller.view];

    
}

- (void)dealloc
{
    [_item release];
    [_imgView release];
    [super dealloc];
}

@end

@implementation EtaoPriceImageController
@synthesize request = _request;
@synthesize netQueue = _netQueue ;
@synthesize imagecache = _imagecache;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _num_of_col = 3; //九宫格，每一行展示3个
        _pix_of_width = DISPLAY_IMAGE_WIDTH;
        _pix_of_height = DISPLAY_IMAGE_WIDTH;
        //初始化request
        _request = [[EtaoPAHttpRequest alloc]init];
        _request.PA_delegate = self;
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

- (void)dealloc
{
    _request.delegate = nil ; 
    [_imagecache release];
    if(_request!=nil)[_request release];
    if(_PA_item_list!=nil)[_PA_item_list release];
    if(_refreshHeaderView!=nil)[_refreshHeaderView release];
    if(_refreshTailerView!=nil)[_refreshTailerView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.netQueue = [[[ASINetworkQueue alloc]init]autorelease];
    [_netQueue setMaxConcurrentOperationCount:50];
    [_netQueue go];
    
    self.imagecache = [NSMutableDictionary dictionaryWithCapacity:100];
    
    //初始化本地数组
    _PA_item_list = [[NSMutableArray alloc]init];
    
    [self.tableView setContentSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height)];

    //初始化头部的下拉刷新View，retainCount = 2
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f-self.tableView.frame.size.height,self.tableView.frame.size.width,self.tableView.bounds.size.height)]; 
    _refreshHeaderView.delegate = self;
    [self.tableView addSubview:_refreshHeaderView];
    
    //初始化底部的上拉更新View，retainCount = 2
    _refreshTailerView = [[EGORefreshTableTailerView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, _pix_of_height)]; 
    _refreshTailerView.delegate = self;
    //[self.tableView addSubview:_refreshTailerView];
    
    
    //初始化，下拉
    self.tableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
    [self refreshTableViewDataSource]; //开始更新
    [self performSelector:@selector(pullDown) withObject:self afterDelay:0.2];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _PA_item_list.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSString *CellIdentifier = [NSString stringWithFormat:@"%d",[indexPath row]];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        tableView.separatorColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
     if(indexPath.row < _PA_item_list.count){
        NSMutableArray* array = [_PA_item_list objectAtIndex:indexPath.row];
        [self item2cell:array toCell:cell];
    }
    else if(_PA_item_list.count!=0){
        for (UIView *v in [cell subviews]) {
            if ([ v isKindOfClass:[UILabel class]] ||
                [ v isKindOfClass:[HttpimageViewTouchController class]]||
                [v isKindOfClass:[EGORefreshTableTailerView class]]) {
                [v removeFromSuperview];
            } 
        } 
        [_refreshTailerView removeFromSuperview];
        [cell addSubview:_refreshTailerView];
    } 

    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _pix_of_height+DISPLAY_IMAGE_GAP;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/* Http代理回调 */
- (void) requestFinishedSuccess
{
    NSLog(@"requestFinishedSuccess");
    [self items2items:_request.PA_item_list toItems:_PA_item_list];
    [self.tableView reloadData];
    /*
    [_refreshTailerView removeFromSuperview];
    [_refreshTailerView setFrame:
    CGRectMake(0.0f,self.tableView.contentSize.height-65.0f,self.tableView.frame.size.width,self.tableView.frame.size.height)];
    [self.tableView addSubview:_refreshTailerView];
    [self.tableView reloadData];
    */
    if(_header_reloading)
        [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
    else if(_tailer_reloading)
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];    
}

- (void) requestFinishedFailed
{
    NSLog(@"requestFinishedFailed");
    [self.tableView reloadData];
    if(_header_reloading)
        [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
    else if(_tailer_reloading)
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
}

- (void) requestFailed
{
    NSLog(@"requestFailed");
    [self.tableView reloadData];
    if(_header_reloading)
        [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
    else if(_tailer_reloading)
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
}

- (void) requestTimeout
{
    
}

/* 下拉回调 EGO  */

//开始更新数据
- (void)refreshTableViewDataSource{ 
    _header_reloading=YES;
    NSLog(@"==开始更新数据");  
}

//结束更新数据
- (void)doneRefreshTableViewData{ 
    _header_reloading=NO;
    NSLog(@"==结束更新数据"); 
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
} 

//开始加载数据
- (void)reloadTableViewDataSource{ 
    _tailer_reloading=YES;
    NSLog(@"==开始加载数据");  
}

//结束加载数据
- (void)doneLoadingTableViewData{ 
    _tailer_reloading=NO;
    NSLog(@"==结束加载数据"); 
    [_refreshTailerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
} 

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{ 
    return _header_reloading; 
} 

- (BOOL)egoRefreshTableTailerDataSourceIsLoading:(EGORefreshTableTailerView*)view{ 
    return _tailer_reloading; 
}

//下拉触发
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{ 
    [self refreshTableViewDataSource]; //开始更新
    [self pullDown];
}

//纪录最后更新时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{ 
    return [NSDate date];     
}

//上拉触发
- (void)egoRefreshTableTailerDidTriggerRefresh:(EGORefreshTableTailerView*)view{ 
    [self reloadTableViewDataSource]; //开始加载
    [self pullUp];
}

//纪录最后更新时间
- (NSDate*)egoRefreshTableTailerDataSourceLastUpdated:(EGORefreshTableTailerView*)view{ 
    return [NSDate date];
}

/* EGO Common */

//点击状态栏回到顶部
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"touch me!");
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshTailerView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView]; 
    [_refreshTailerView egoRefreshScrollViewDidEndDragging:scrollView]; 
}

/* 事件触发 */
- (void)pullUp
{ 
    [_request PA_next];
}

- (void)pullDown
{
    [_request PA_first];
}

/* 图片相关 */

//把队列分组装进另一个队列里
- (void)items2items:(NSMutableArray *)items1 toItems:(NSMutableArray *)items2
{
    [items2 removeAllObjects];
    for(int i =0 ;i <items1.count;i+=_num_of_col){
        NSMutableArray*  items = [[NSMutableArray alloc]init];
        for (int j =0; j< _num_of_col;j++){
            if(i+j >= items1.count) break;
            EtaoPriceAuctionItem* item = [items1 objectAtIndex:i+j];
            [items addObject:item];
        }
        [items2 addObject:items];
        [items release];
    }
}

- (void)item2cell:(NSMutableArray *)items toCell:(UITableViewCell *)cell {
    EtaoPriceAuctionItem* item;
    for(int i =0;i<items.count;i++){        
        item = [items objectAtIndex:i];
/*      HttpimageViewTouchController* imgView = [[HttpimageViewTouchController alloc]init];
        HTTPImageView* httpimgview = [[[HTTPImageView alloc]init]autorelease];
        imgView.imgView = httpimgview;
        [imgView addSubview:httpimgview];
        httpimgview.networkQueue = _netQueue;
        TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
        imgView.imgView.memoryCache = memoryCache ;
        imgView.imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.layer.borderColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1.0].CGColor;
        imgView.layer.borderWidth = DISPLAY_IMAGE_BORDER;
        
        //缩放
        CGRect frame = imgView.frame;
        frame.size.width = _pix_of_width;
        frame.size.height = _pix_of_height;
        httpimgview.frame = frame;
        //坐标
        CGPoint point;
        point.x = i*(_pix_of_width+DISPLAY_IMAGE_GAP)+DISPLAY_IMAGE_GAP;
        point.y = DISPLAY_IMAGE_GAP;
        frame.origin = point;    
        imgView.frame = frame; 
        
        
        //透明label
        UILabel* label = [[[UILabel alloc]initWithFrame:CGRectMake(0, 74, 94, 20)]autorelease];
        label.backgroundColor = [UIColor colorWithRed:79/255.0f green:86/255.0f blue:105/255.0f alpha:0.63];
    
        //人民币符号
        UIImageView *price = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rmb_price.png"]]autorelease];
        [price setFrame:CGRectMake(4,4,8,12)];
        [label addSubview:price];
        
        //价格label
        UILabel* priceLabel = [[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 45, 20)]autorelease];
        priceLabel.text = [[item.productPrice componentsSeparatedByString:@"."] objectAtIndex:0];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor whiteColor];
        priceLabel.font = [UIFont boldSystemFontOfSize:15];
        [label addSubview:priceLabel];
        
        //折扣label
        float dist = [item.productPrice floatValue]*10/[item.lowestPrice floatValue];
        UILabel* distLabel = [[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 34, 20)]autorelease];
        distLabel.text = [NSString stringWithFormat:@"%.1f折",dist];
        distLabel.backgroundColor = [UIColor clearColor];
        distLabel.textColor = [UIColor whiteColor];
        distLabel.font = [UIFont boldSystemFontOfSize:13];
        [label addSubview:distLabel];
        
        [imgView addSubview:label];
 */
   /*    
        NSString* url = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_80x80.jpg",item.image];
        [imgView.imgView setUrl:url];
        imgView.item = item;
        [cell addSubview:imgView];
        [imgView release]; */
    
        
        NSString* url = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_80x80.jpg",item.image];
        
        HTTPImageView* httpimgview  = [_imagecache valueForKey:url];
        if (httpimgview!=nil) {
            
        }
        else
        {
            httpimgview = [[[HTTPImageView alloc]init]autorelease];  
            httpimgview.networkQueue = _netQueue;
            httpimgview.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
            TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
            httpimgview.memoryCache = memoryCache ;
            httpimgview.contentMode = UIViewContentModeScaleAspectFit;
            httpimgview.layer.borderColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1.0].CGColor;
            httpimgview.layer.borderWidth = DISPLAY_IMAGE_BORDER;
        
            [httpimgview setUrl:url]; 
            [_imagecache setValue:httpimgview forKey:url];
        
            
        }
        UIImageView *image = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no_picture_80x80.png"]]autorelease];
        CGRect frame = image.frame;
        frame.size.width = _pix_of_width;
        frame.size.height = _pix_of_height; 
        //坐标
        CGPoint point;
        point.x = i*(_pix_of_width+DISPLAY_IMAGE_GAP)+DISPLAY_IMAGE_GAP;
        point.y = DISPLAY_IMAGE_GAP;
        frame.origin = point;    
        httpimgview.frame = frame; 
        [cell addSubview:httpimgview];
         
        
         
    }
}

/* Query相关 */
- (void)setQuery:(NSString*)value forKey:(NSString*)key
{
    [_request.query setObject:value forKey:key];
}

/* 重新加载 */
- (void)reloadData
{
    [self items2items:_request.PA_item_list toItems:_PA_item_list];
    [self.tableView reloadData];
    /*
    [_refreshTailerView removeFromSuperview];
    [_refreshTailerView setFrame:
     CGRectMake(0.0f,self.tableView.contentSize.height,self.tableView.frame.size.width,self.tableView.frame.size.height)];
    [self.tableView addSubview:_refreshTailerView];
    [self.tableView reloadData];    
     */
}

/* DEBUG */
- (void)status
{
    NSMutableArray* array;
    for (array in _PA_item_list){
        NSLog(@"%d",array.count);
    }
}

@end
