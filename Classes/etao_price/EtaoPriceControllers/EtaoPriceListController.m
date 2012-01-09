//
//  EtaoPriceListController.m
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceListController.h"
#import "EtaoPriceDetailSwipeController.h"
#import "EtaoPriceAuctionDetailController.h"
#import "TBMemoryCache.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation EtaoPriceListController
@synthesize datasourceKey = _datasourceKey;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _update_lock = NO;

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
    EtaoPriceBuyAuctionDataSource* datasource1 = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:self.datasourceKey];
    [ datasource1 removeObserver:self forKeyPath:@"status"];
 
    if(_refreshHeaderView!=nil)[_refreshHeaderView release];
    if(_refreshTailerView!=nil)[_refreshTailerView release];

    [super dealloc];
}
- (void) loadView{
    [super loadView];
    //初始化本地数组     
    _items = [[NSMutableArray alloc]init];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]];
    [self.tableView setContentSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height)];
    
    //初始化头部的下拉刷新View，retainCount = 2
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f-self.tableView.frame.size.height,self.tableView.frame.size.width,self.tableView.bounds.size.height)]; 
    _refreshHeaderView.delegate = self;
    [self.tableView addSubview:_refreshHeaderView];

    //初始化底部的上拉更新View，retainCount = 2
    _refreshTailerView = [[EGORefreshTableTailerView alloc]initWithFrame:
                          CGRectMake(0.0f, 0, self.tableView.frame.size.width,120)]; 
    _refreshTailerView.delegate = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    EtaoPriceBuyAuctionDataSource* datasource = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter]getDataSourceWithKey:_datasourceKey];
    if(datasource.status == ET_DS_PRICEBUY_AUCTION_LOCAL){
        [self performSelector:@selector(pullDownLikeManDoes) withObject:nil afterDelay:0.0];
    }
    else{
        [self items2items:datasource.items toItems:_items];
    }
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

#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{  
    return _items.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *CellIdentifier = [NSString stringWithFormat:@"%d",[indexPath row]];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
        selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
        cell.selectedBackgroundView = selectedView;
    }else {
        for (UIView *v in [cell subviews]) {
            if ([v isKindOfClass:[UILabel class]] |
                [v isKindOfClass:[HTTPImageView class]]|
                [v isKindOfClass:[EGORefreshTableTailerView class]]|
                [v isKindOfClass:[UIImageView class]]|
                [v isKindOfClass:[UIButton class]]) {
                [v removeFromSuperview];
            } 
        } 
    }
    
    if(indexPath.row < _items.count){
        EtaoPriceAuctionItem* item = [_items objectAtIndex:indexPath.row];
        [self item2cell:item toCell:cell];
    }
    else if(_items.count!=0 && indexPath.row == _items.count){
               [_refreshTailerView removeFromSuperview];
        [cell addSubview:_refreshTailerView];
        cell.accessoryView = nil;
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row < _items.count){
        ETPageSwipeController* detailSwipe = [[[ETPageSwipeController alloc]initWithItems:_items 
                                                                            withDelegate:self 
                                                                                 atIndex:indexPath.row 
                                                                           byDetailClass:[EtaoPriceAuctionDetailController class]]autorelease];
        
        [[EtaoPriceMainViewController getNavgationController] pushViewController:detailSwipe animated:YES];
        
    }
     [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndexInList"];
}

#pragma mark -v datasource delegate callback
/* Http代理回调 */

- (void) showUpdateInformation:(NSString *)updateNum
{
    if ([updateNum intValue] == 0) {
        return ;
    }
    //初始化下拉更新label
    UILabel* update_label = [[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, -27, self.view.frame.size.width, 25)]autorelease];
    [self.view.superview addSubview:update_label];
    update_label.textAlignment = UITextAlignmentCenter;
    update_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_update_label27.png"]];
    update_label.textColor = [UIColor colorWithRed:131/255.0 green:93/255.0 blue:53/255.0 alpha:1.0];
    update_label.font = [UIFont systemFontOfSize:13];
    update_label.text = [NSString stringWithFormat:@"最近更新了%@条数据",updateNum];

    [EtaoPriceCommonAnimations performSelector:@selector(updateAnimationDown:) withObject:update_label afterDelay:0];
    /*
    SystemSoundID soundID;
    NSURL *filePath   = [[NSBundle mainBundle] URLForResource:@"Ping" withExtension:@"aiff"];
    AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
    */
    [EtaoPriceCommonAnimations performSelector:@selector(updateAnimationUp:) withObject:update_label afterDelay:1.5];
    [update_label performSelector:@selector(removeFromSuperview) withObject:self afterDelay:2];
}

#pragma mark -v datasource event respond function
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoPriceBuyAuctionDataSource class]]){
        EtaoPriceBuyAuctionDataSource* datasource = object;
        ET_DS_PRICEBUY_AUCTION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_DS_PRICEBUY_AUCTION_OK: //数据加载完成
                if(_header_reloading)
                    [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
                else if(_tailer_reloading)
                    _tailer_reloading = NO;
                [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
                [self items2items:datasource.items toItems:_items];
                break;
            case ET_DS_PRICEBUY_AUCTION_UPDATE:
                [self showUpdateInformation:datasource.updateNumber];
                break;
            case ET_DS_PRICEBUY_AUCTION_ERROR:
            case ET_DS_PRICEBUY_AUCTION_FAIL:
                if(_header_reloading)
                    [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
                else if(_tailer_reloading)
                    _tailer_reloading = NO;
                [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
                [_refreshHeaderView setStatus:@"更新失败"];
                break;
            case ET_DS_PRICEBUY_AUCTION_LOADING: //加载数据中
                break;
            case ET_DS_PRICEBUY_AUCTION_NOMORE:
                [self.tableView reloadData];
                break;
            default:
                break;
        }
    }
}

#pragma mark -v EGO delegate callback
/* 下拉回调 EGO  */
//停止更新数据
- (void)stopRefresh{
    if(_header_reloading){
        _header_reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        NSLog(@"==停止更新数据");
    }
    else if(_tailer_reloading){
        _tailer_reloading=NO;
        [_refreshTailerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        NSLog(@"==停止加载数据");
    }
}

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
    [self refreshTableViewDataSource]; //开始加载
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

#pragma mark -v event trigger

/* 事件触发 */
- (void)pullDownLikeManDoes
{
    //初始化，下拉
    self.tableView.contentOffset = CGPointMake(0, -60);
    self.tableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
    [self refreshTableViewDataSource]; //开始更新
    [self performSelector:@selector(pullDown) withObject:self afterDelay:0.5];
}

- (void)pullDown
{ 
    EtaoPriceBuySettingDataSource* setting = (EtaoPriceBuySettingDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoPriceBuySettingDataSource keyName:nil]];
    EtaoPriceBuyAuctionDataSource* datasource = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    
    
    //重设datasource
    if(setting.status == ET_DS_PRICEBUY_SETTING_OK){
        for(EtaoPriceSettingItem* cell in [setting getSelectedItems]){
            if([datasource.tag isEqualToString:cell.tag]){
                datasource.settingItem = cell;
            }
        }
    }
    
    [datasource reload];
    [datasource loadUpdate];
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-RefreshList"];
}

- (void)pullUp
{ 
    EtaoPriceBuyAuctionDataSource* datasource = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    [datasource loadmore];
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ReloadList"];
}

#pragma mark -v swipe delegate
- (void)swipeAtIndex:(NSNumber *)index withCtrls:(UIViewController *)controller{
    if([index intValue] > _items.count -5){
        [self reloadTableViewDataSource]; //开始加载
        [self pullUp];
    }
}

- (void)swipeWillExitAtIndex:(NSNumber *)index{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:[index intValue] inSection:0];
    [self.tableView selectRowAtIndexPath:indexP animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark -v Watch
/* 监视相关*/

- (void)watchWithKey:(NSString *)key{
    self.datasourceKey = key;
    EtaoPriceBuyAuctionDataSource* datasource = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
}

- (void)watchWithDatasource:(id)datasource{
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
}

#pragma mark -v Display Fuctions

/* 图片相关 */

//把队列分组装进另一个队列里
- (void)items2items:(NSMutableArray *)items1 toItems:(NSMutableArray *)items2
{
    [items2 removeAllObjects];
    EtaoPriceAuctionItem* item;
    for (item in items1){
        [items2 addObject:item];
    }
    [self.tableView reloadData];
}

- (void)item2cell:(EtaoPriceAuctionItem*)item toCell:(UITableViewCell *)cell
{
    
    for (UIView *v in [cell subviews]) {
		if ([v isKindOfClass:[UILabel class]] |
			[v isKindOfClass:[HTTPImageView class]] |
            [v isKindOfClass:[EGORefreshTableTailerView class]] |
            [v isKindOfClass:[UIImageView class]] |
            [v isKindOfClass:[UIButton class]]) {
			[v removeFromSuperview];
		} 
	} 
    
    UIFont *titleFont = [UIFont systemFontOfSize:15];
    UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];

    UIFont *priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:18]; //[UIFont systemFontOfSize:15]; 
	UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ; 

//    UIFont *priceFont = [UIFont systemFontOfSize:15]; 
//    UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ; 
    UIFont *detailFont = [UIFont systemFontOfSize:13];
    UIColor *detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 

    UIFont *uptimeFont = [UIFont systemFontOfSize:12];
    UIColor *uptimeColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
    
	//UIFont *ppriceFont = [UIFont systemFontOfSize:15]; 
    
    UIImageView *imagev = nil;
    if(item.wapLink!=nil)
        imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportWap.png"]];
    else
        imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportWww.png"]];
    cell.accessoryView = imagev;
    [imagev release];
    
    UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 10, 210, 34)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"%@",item.title];
    
    titleLabel.font = titleFont;
    titleLabel.textColor = titleColor;
    titleLabel.textAlignment = UITextAlignmentLeft ;
    titleLabel.numberOfLines = 2;
    //首行顶对齐
    CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
    [titleLabel setFrame:CGRectMake(100, 10, textRect.size.width, textRect.size.height)];
    
    
    
    NSString *price = [NSString stringWithFormat:@"%1.2f",[item.productPrice floatValue]];
    
    UIImageView *rmbView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
    [rmbView setFrame:CGRectMake(100, 57, rmbView.frame.size.width, rmbView.frame.size.height)];
    [cell addSubview:rmbView];

    UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(110,52, 200, 20)] autorelease];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.text = [NSString stringWithFormat:@"%@",price];
    priceLabel.font = priceFont;
    priceLabel.numberOfLines = 1 ;
    priceLabel.textColor = priceColor; 

    NSString *discount = [NSString stringWithFormat:@"%1.1f%折",[item.productPrice floatValue]*10/[item.lowestPrice floatValue]];
    
    UILabel* discountLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(240,54, 200, 14)] autorelease];
    discountLabel.backgroundColor = [UIColor clearColor];
    discountLabel.text = discount;
    discountLabel.font = uptimeFont;
    discountLabel.numberOfLines = 1 ;
    discountLabel.textColor = uptimeColor; 
    
    UILabel* distLabel = [[[UILabel alloc]initWithFrame:CGRectMake(225,53, 13, 13)]autorelease];
    UIImageView* distIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"etao_discount.png"]]autorelease];
    [distLabel addSubview:distIcon];
    
  
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *uptime =  [NSString stringWithFormat:@"降价时间:%@", [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([item.priceMtime floatValue] )]]];
    
    
    UILabel* uptimeLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100,78, 200, 14)] autorelease];
    uptimeLabel.backgroundColor = [UIColor clearColor];
    uptimeLabel.text = uptime;
    uptimeLabel.font = uptimeFont;
    uptimeLabel.numberOfLines = 1 ;
    uptimeLabel.textColor = uptimeColor;
    
    
    UILabel* DetailLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(10, 98, 300, 14)] autorelease];
    DetailLabel.backgroundColor = [UIColor clearColor];
    
    if ([item.sellerType isEqualToString:@"0"] ) {
        DetailLabel.text = [NSString stringWithFormat:@"淘宝网 %@",item.nickName];
    }
    else if ([item.sellerType isEqualToString:@"1"] ) {
        DetailLabel.text = [NSString stringWithFormat:@"淘宝商城 %@",item.nickName];
    }
    else {
        DetailLabel.text = item.nickName;
    }
    DetailLabel.font = detailFont;
    DetailLabel.numberOfLines = 1 ;
    DetailLabel.textColor = detailColor;
    
    HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(10, 10, 80, 80)]autorelease];
    TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
    httpImageView.memoryCache = memoryCache ;
    httpImageView.contentMode = UIViewContentModeScaleAspectFit;
    httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    if(item.image == nil){
        httpImageView.image = [UIImage imageNamed:@"no_picture_80x80.png"];
    }
    else{
        NSString *picturl = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_120x120.jpg",item.image];
        [httpImageView setUrl:picturl];
    }
    CALayer *layer = [httpImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:0.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0]  CGColor]];
    
    [cell addSubview:httpImageView];
    [cell addSubview:titleLabel];
    [cell addSubview:DetailLabel];
    [cell addSubview:priceLabel];
    [cell addSubview:uptimeLabel];
    [cell addSubview:distLabel];
    [cell addSubview:discountLabel];

}

/* 重新加载 */
- (void)reloadData
{
   // [self items2items:_datasource.items toItems:_items];
}

@end
