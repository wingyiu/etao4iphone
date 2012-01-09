
//
//  EtaoTuanListController.m
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanListForMapController.h"
#import "TBMemoryCache.h"
#import <AudioToolbox/AudioToolbox.h>
#import "EtaoTuanDetailSwipeController.h"
#import "EtaoTimeLabel.h"
#import "EtaoLoadMoreCell.h"

@implementation EtaoTuanListForMapController
@synthesize datasourceKey = _datasourceKey;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _catPic = [[NSMutableDictionary alloc]initWithCapacity:1];
        [_catPic setObject:@"food.png" forKey:@"餐饮美食"];
        [_catPic setObject:@"yule.png" forKey:@"休闲娱乐"];
        [_catPic setObject:@"meirong.png" forKey:@"美容保健"];
        [_catPic setObject:@"shopping.png" forKey:@"网上购物"];
        [_catPic setObject:@"fly.png" forKey:@"旅游酒店"];
        [_catPic setObject:@"other.png" forKey:@"其它"];
        [_catPic setObject:@"hui.png" forKey:@"优惠券票"];
        
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
    
    EtaoGroupBuyAuctionDataSource* datasource1 = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:self.datasourceKey];
    [ datasource1 removeObserver:self forKeyPath:@"status"];
    EtaoGroupBuyLocationDataSource* datasource2 = (EtaoGroupBuyLocationDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    [datasource2 removeObserver:self forKeyPath:@"status"];
    
    if(_refreshHeaderView!=nil){
        _refreshHeaderView.delegate = nil;
        [_refreshHeaderView release];
        _refreshHeaderView = nil;
    }    
    if(_refreshTailerView!=nil)
    {
        _refreshTailerView.delegate = nil;
        [_refreshTailerView release];
        _refreshTailerView = nil;
    }
    if (_items != nil) {
        [_items removeAllObjects];
        [_items release];
        _items = nil;
    }
    if (_catPic != nil) {
        [_catPic removeAllObjects];
        [_catPic release];
    }
    
    
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
                          CGRectMake(0.0f, 0, self.tableView.frame.size.width,54)]; 
    _refreshTailerView.delegate = self;
    
    rowClick = -1;
    
    EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter]getDataSourceWithKey:_datasourceKey];
    if(datasource.status == ET_DS_GROUPBUY_LOCATION_LOCAL){
        [self performSelector:@selector(pullDownLikeManDoes) withObject:nil afterDelay:0.0];
    }
    else{
        [self items2items:datasource.items toItems:_items];
    }
    
    //添加消息回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMapSelected:)
                                                 name:ET_NF_GROUPBUY_MAP2LIST_SELECTITEM
                                               object:nil];
    
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
    static NSString *moreCellId = @"moreCell"; 
    
    NSUInteger row = [indexPath row];
	NSUInteger count = [_items count];
    
    if (row == count ) { 
		EtaoLoadMoreCell * cell = (EtaoLoadMoreCell*)[tableView dequeueReusableCellWithIdentifier:moreCellId];
		if (cell == nil) {
			cell = [[[EtaoLoadMoreCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
            UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
            [selectedView release];
		} 
        EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
        if(datasource.status == ET_DS_GROUPBUY_AUCTION_NOMORE){
            [cell setReload];
            cell.delegate = self;
            cell.action = @selector(pullUp);
        }
		return cell; 
	}
    else
    {
        EtaoGroupBuyListForMapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[EtaoGroupBuyListForMapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setImageFrame:CGRectMake(2, 10, 110, 80)];            
            UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
            selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
            cell.selectedBackgroundView = selectedView;   //设置选中后cell的背景颜色
        } 
        else
        {
//            [cell.httpImage.http setQueuePriority:NSOperationQueuePriorityVeryLow];
        }
        
        if ([_items count] == 0 ) {
            return cell;
        }
        
        EtaoTuanAuctionItem* item = [_items objectAtIndex:indexPath.row];
        NSString *picturl = [NSString stringWithFormat:@"http://img03.taobaocdn.com/bao/uploaded/i3/%@_120x120.jpg",item.image];
        [cell setItem:item url:picturl];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    
	NSUInteger row = [indexPath row];
	NSUInteger count = [_items count];
    
	// load more
	if (count == 0 || row > count || _tailer_reloading) {
		return;
	}
	
    EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    
	if (row > count - 10 && datasource.status != ET_DS_GROUPBUY_AUCTION_NOMORE) {
        [self reloadTableViewDataSource]; //开始加载
        [self pullUp];
        // [self performSelector:@selector(pullUp) withObject:nil afterDelay:0];
	}     
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [[ASIHTTPRequest sharedQueue] setMaxConcurrentOperationCount:1];
    NSArray *operation_array = [[ASIHTTPRequest sharedQueue]operations];
    for (int i = 0; i<[operation_array count]; i++) {
        [[operation_array objectAtIndex:i] setQueuePriority:NSOperationQueuePriorityVeryLow];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView]; 
    [_refreshTailerView egoRefreshScrollViewDidEndDragging:scrollView]; 
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"%s",__FUNCTION__);  
//    [[ASIHTTPRequest sharedQueue] setMaxConcurrentOperationCount:4];
//    NSArray *cell_array =  [self.tableView visibleCells];
//    for (int i=0; i<[cell_array count]; i++) {
//        [[[cell_array objectAtIndex:i]getASIHTTPRequest] setQueuePriority:NSOperationQueuePriorityNormal];
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
//    if(indexPath.row < _items.count){
//        EtaoTuanAuctionItem* item = [_items objectAtIndex:indexPath.row];
//        if(item.mode == nil || [item.mode isEqualToString:@"small"]){
//            return 54;
//        }
//        else{
//            return 106;
//        }
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row < _items.count){
        ETPageSwipeController* detailSwipe = [[[ETPageSwipeController alloc]initWithItems:_items 
                                                                            withDelegate:self 
                                                                                 atIndex:indexPath.row 
                                                                           byDetailClass:[EtaoTuanListDetailController class]]autorelease];
        
        [[EtaoTuanHomeViewController getNavgationController] pushViewController:detailSwipe animated:YES];
    }
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndexInList"];
}

#pragma mark -v datasource event respond function
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoGroupBuyAuctionDataSource class]]){
        EtaoGroupBuyAuctionDataSource* datasource = object;
        ET_DS_GROUPBUY_AUCTION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_DS_GROUPBUY_AUCTION_OK: //数据加载完成
                if(_header_reloading)
                    [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
                else if(_tailer_reloading)
                    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
                [self items2items:datasource.items toItems:_items];
                break;
            case ET_DS_GROUPBUY_AUCTION_ERROR:
            case ET_DS_GROUPBUY_AUCTION_FAIL:
                if(_header_reloading)
                    [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
                else if(_tailer_reloading)
                    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
                [_refreshHeaderView setStatus:@"更新失败"];
                break;
            case ET_DS_GROUPBUY_AUCTION_LOADING: //加载数据中
                break;
            case ET_DS_GROUPBUY_AUCTION_NOMORE:
                [self.tableView reloadData];
                break;
            default:
                break;
        }
    }
    else if([object isKindOfClass:[EtaoGroupBuyLocationDataSource class]]){
        ET_DS_GROUPBUY_LOCATION_STATUS new_status = [[change objectForKey:@"new"] intValue];
        EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
        EtaoGroupBuyLocationDataSource* location = object;
        switch (new_status) {
            case ET_DS_GROUPBUY_LOCATION_CHANGE: //数据有改变，要重新请求
            {
                NSString* latitude = [NSString stringWithFormat:@"%f",location.currentLocation.coordinate.latitude];
                NSString* longitude = [NSString stringWithFormat:@"%f",location.currentLocation.coordinate.longitude];
                if(latitude !=nil && location!=nil){
                    [datasource.query setObject:latitude forKey:@"dist_y"];
                    [datasource.query setObject:longitude forKey:@"dist_x"];
                    [datasource.query setObject:@"y" forKey:@"lbs"];
                }
                if(location.currentCity!=nil){
                    if([location.currentCity isEqualToString:location.realityCity]){
                        [datasource.query setObject:@"y" forKey:@"lbs"];
                    }
                    else{
                        [datasource.query setObject:@"n" forKey:@"lbs"];
                    }
                    [datasource.query setObject:location.currentCity forKey:@"city"];
                }
                [datasource performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone:NO];
            }
                break;
            case ET_DS_GROUPBUY_LOCATION_GPSOK:
            case ET_DS_GROUPBUY_LOCATION_OK:
                [_refreshHeaderView setStatus: @"定位成功，更新中..."];
                break;
            case ET_DS_GROUPBUY_LOCATION_GPSFAIL:
                [_refreshHeaderView setStatus:@"定位失败，更新中..."];
                [datasource performSelectorOnMainThread:@selector(reload) withObject:nil waitUntilDone:NO];
                break;
            case ET_DS_GROUPBUY_LOCATION_LOCAL: //定位中
                [_refreshHeaderView setStatus:@"定位中..."];
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
    int topLineCell = scrollView.contentOffset.y/106;
    int bottomLineCell = (scrollView.contentOffset.y+460-MAP_HEIGHT-44-30)/106;
    if(bottomLineCell -topLineCell == 2){
        int currentCell = scrollView.contentOffset.y/106+1;
        if (currentCell != _cellAtTop && currentCell < _items.count){
            _cellAtTop = currentCell;
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_cellAtTop inSection:0] 
                                        animated:YES 
                                  scrollPosition:UITableViewScrollPositionNone];
            //发送消息
            NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:_cellAtTop]
                                                          forKey:@"index"];
            [[NSNotificationCenter defaultCenter] postNotificationName:ET_NF_GROUPBUY_LIST2MAP_SELECTITEM object:nil userInfo:dict];
        }
    }
    else if(bottomLineCell -topLineCell == 1 && scrollView.contentOffset.y <=0){
        _cellAtTop = 0;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_cellAtTop inSection:0] 
                                    animated:YES 
                              scrollPosition:UITableViewScrollPositionNone];
        //发送消息
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:_cellAtTop]
                                                         forKey:@"index"];
        [[NSNotificationCenter defaultCenter] postNotificationName:ET_NF_GROUPBUY_LIST2MAP_SELECTITEM object:nil userInfo:dict];
    }
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshTailerView egoRefreshScrollViewDidScroll:scrollView];
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
    EtaoGroupBuyLocationDataSource* location = (EtaoGroupBuyLocationDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoGroupBuyLocationDataSource keyName:nil]];
    EtaoGroupBuySettingDataSource* setting = (EtaoGroupBuySettingDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:[EtaoGroupBuySettingDataSource keyName:nil]];
    
    EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    
    
    //重设datasource
    if(setting.status == ET_DS_GROUPBUY_SETTING_OK){
        for(EtaoTuanSettingItem* cell in [setting getSelectedItems]){
            if([datasource.tag isEqualToString:cell.tag]){
                datasource.settingItem = cell;
            }
        }
    }
    
    //判断当前gps状态
    if(location.status == ET_DS_GROUPBUY_LOCATION_CHANGE){
        [_refreshHeaderView setStatus:@"定位成功，更新中..."];
        NSString* latitude = [NSString stringWithFormat:@"%f",location.currentLocation.coordinate.latitude];
        NSString* longitude = [NSString stringWithFormat:@"%f",location.currentLocation.coordinate.longitude];
        [datasource.query setObject:latitude forKey:@"dist_y"];
        [datasource.query setObject:longitude forKey:@"dist_x"];
        [datasource.query setObject:@"y" forKey:@"lbs"];
        if(location.currentCity!=nil){
            if(location.currentCity!=nil){
                if([location.currentCity isEqualToString:location.realityCity]){
                    [datasource.query setObject:@"y" forKey:@"lbs"];
                }
                else{
                    [datasource.query setObject:@"n" forKey:@"lbs"];
                }
                [datasource.query setObject:location.currentCity forKey:@"city"];
            }
            [datasource.query setObject:location.currentCity forKey:@"city"];
        }
        [datasource reload];
    }
    else if(location.status == ET_DS_GROUPBUY_LOCATION_GPSFAIL){
        [_refreshHeaderView setStatus:@"定位失败，更新中..."];
        [datasource reload];
    }
    else{
        [_refreshHeaderView setStatus:@"定位中..."];
    }
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-RefreshList"];
}

- (void)pullUp
{ 
    EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    [datasource loadmore];
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ReloadList"];
}



#pragma mark -v Watch
/* 监视相关*/

- (void)watchWithKey:(NSString *)key{
    self.datasourceKey = key;
    EtaoGroupBuyAuctionDataSource* datasource = (EtaoGroupBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
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

#pragma mark -v Display Fuctions

/* 图片相关 */

//把队列分组装进另一个队列里
- (void)items2items:(NSMutableArray *)items1 toItems:(NSMutableArray *)items2
{
    [items2 removeAllObjects];
    EtaoTuanAuctionItem* item;
    for (item in items1){
        [items2 addObject:item];
    }
    [self.tableView reloadData];
}

- (void)handleMapSelected:(NSNotification*)notification {
    
    NSNumber* index = [[notification userInfo] objectForKey:@"index"];
    NSString* datasourceKey = [[notification userInfo] objectForKey:@"datasourceKey"];
    if([datasourceKey isEqualToString:_datasourceKey]){
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:[index intValue] inSection:0];
        [self.tableView selectRowAtIndexPath:indexP animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}

- (void)SingleTouch:(id)sender{
     ETPageTouchView* touchView = sender;
    //回调到map
    if (rowClick != -1 && touchView.page == rowClick) {
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:touchView.page inSection:0]];
    }
    else{
        rowClick = touchView.page;
//        if (_datasource.delegateForMap && [_datasource.delegateForMap respondsToSelector:@selector(autoMoveWhenSelect:)]) {
//            [_datasource.delegateForMap autoMoveWhenSelect:touchView.page];
//        }
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:touchView.page inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
     

//    //扫描需要改变的row
//    NSMutableArray* array = [[NSMutableArray alloc]init];
//    for(int i =0 ; i<_items.count ; i++){
//        EtaoTuanAuctionItem* item = [_items objectAtIndex:i];
//        if([item.mode isEqualToString:@"large"]){
//            item.mode = @"small";
//            [array addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//        }
//    }
//    
//    //修改状态值
//    EtaoTuanAuctionItem* item = [_items objectAtIndex:touchView.page];
//    if(item.mode ==nil ||[item.mode isEqualToString:@"small"]){
//        item.mode = @"large";
//    }
//    else{
//        item.mode = @"small";
//    }
//    [array addObject:[NSIndexPath indexPathForRow:touchView.page inSection:0]];
//    
//    [self.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)item2cell_small:(EtaoTuanAuctionItem*)item toCell:(UITableViewCell *)cell inRow:(NSInteger )row;
{
    for (UIView *v in [cell subviews]) {
		if ([ v isKindOfClass:[UILabel class]] ||
			[ v isKindOfClass:[HTTPImageView class]]||
            [v isKindOfClass:[EGORefreshTableTailerView class]] ||
            [v isKindOfClass:[UIImageView class]] ||
            [v isKindOfClass:[ETPageTouchView class]]) {
			[v removeFromSuperview];
		} 
	} 
    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
	UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    UIColor *webTitleColor = [UIColor colorWithRed:10/255.0f green:10/255.0f blue:10/255.0f alpha:1.0];

    ETPageTouchView* parentLable = [[[ETPageTouchView alloc]initWithFrame:CGRectMake(0, 0, 280, 54)]autorelease];
    parentLable.delegate = self;
    parentLable.page = row;
    
    CGSize sizeWebTitle = [[NSString stringWithFormat:@"[%@]",item.webName] sizeWithFont:titleFont];
    UILabel *webTitleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(60, 8, sizeWebTitle.width, 20)] autorelease];
    webTitleLabel.font = titleFont;
    webTitleLabel.backgroundColor = [UIColor clearColor];
    webTitleLabel.textColor = webTitleColor;
    webTitleLabel.numberOfLines = 1;
    webTitleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    webTitleLabel.text = [NSString stringWithFormat:@"[%@]",item.webName]; 
    
    UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(60, 11, 210, 34)] autorelease];
    NSMutableString *tmpStr = [[[NSMutableString alloc]initWithCapacity:1]autorelease];
    CGSize sizeBlank = [[NSString stringWithFormat:@"%@",@" "] sizeWithFont:titleFont];
    for (int i=0; i<sizeWebTitle.width/sizeBlank.width; i++) {
        [tmpStr appendString:@" "];
    }
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"%@%@",tmpStr,[item titleStr]];    
    titleLabel.font = titleFont;
    titleLabel.textColor = titleColor;
    titleLabel.textAlignment = UITextAlignmentLeft ;
    titleLabel.numberOfLines = 2;
    titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    //首行顶对齐
    CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
    [titleLabel setFrame:CGRectMake(60, 11, textRect.size.width, textRect.size.height)];
    
    UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[_catPic objectForKey:item.type]]] autorelease];
    [rmbImgView setFrame:CGRectMake(10, 8, 30, 30)];
    
    UILabel *distance = [[[UILabel alloc]initWithFrame:CGRectMake(8, 38, 40, 15)]autorelease];
    distance.font = [UIFont systemFontOfSize:12];
    distance.text = item.extInfo;
//    distance.text = [NSString stringWithFormat:@"%@km", @"200"];
    distance.lineBreakMode = UILineBreakModeCharacterWrap;
    distance.textAlignment = UITextAlignmentCenter;
    
    [parentLable addSubview: titleLabel];
    [parentLable addSubview: webTitleLabel];
    [parentLable addSubview:rmbImgView]; 
    [parentLable addSubview:distance];
    
    ETPageTouchView *split = [[[ETPageTouchView alloc]initWithFrame:CGRectMake(285, 0, 1, 54)]autorelease];
    [split setBackgroundColor:[UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0]];

    [cell addSubview:parentLable];
    [cell addSubview:split];
}

- (void)item2cell_large:(EtaoTuanAuctionItem *)item toCell:(UITableViewCell *)cell inRow:(NSInteger)row{
    for (UIView *v in [cell subviews]) {
		if ([v isKindOfClass:[EtaoTimeLabel class]] ||
            [ v isKindOfClass:[UILabel class]] ||
			[ v isKindOfClass:[HTTPImageView class]]||
            [v isKindOfClass:[EGORefreshTableTailerView class]] ||
            [v isKindOfClass:[UIImageView class]] ||
            [v isKindOfClass:[ETPageTouchView class]]) {
            [[EtaoTimerController sharedTimeLabelPointerArray]removeObject:v];
			[v removeFromSuperview];
		} 
	} 
    // remove touch event
    //ETPageTouchView* parentLable = [[[ETPageTouchView alloc]initWithFrame:CGRectMake(0, 0, 280, 106)]autorelease];
    //parentLable.delegate = self;
    //parentLable.page = row;
    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
	UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
	UIFont *priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:21]; 
	UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ;  
    UIFont *salesFont = [UIFont systemFontOfSize:15];
    UIColor *salesColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    
    UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 10, 180, 34)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithFormat:@"[%@]%@",item.webName,[item titleStr]];
    
    titleLabel.font = titleFont;
    titleLabel.textColor = titleColor;
    titleLabel.textAlignment = UITextAlignmentLeft ;
    titleLabel.numberOfLines = 2;
    //首行顶对齐
    CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
    [titleLabel setFrame:CGRectMake(120, 10, textRect.size.width, textRect.size.height)];
    
    UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
    [rmbImgView setFrame:CGRectMake(120, 53, 9, 11)];
	CGSize sizeTuan = [[NSString stringWithFormat:@"%@",item.price] sizeWithFont:priceFont];
	UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(133, 47, sizeTuan.width, 20)] autorelease];
	priceLabel.backgroundColor = [UIColor clearColor];
	priceLabel.text = item.price;
	priceLabel.font = priceFont; 
	priceLabel.numberOfLines = 1 ;
	priceLabel.textColor = priceColor;
    
    UIImageView* salesImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_people.png"]] autorelease];
    [salesImgView setFrame:CGRectMake(120,75, 13, 13)];    
    UILabel *salesLabel = [[[UILabel alloc] initWithFrame:CGRectMake(138, 77, 120, 14)]autorelease];
    salesLabel.numberOfLines = 1;
    salesLabel.textColor = salesColor;
    salesLabel.font = salesFont;
    salesLabel.backgroundColor = [UIColor clearColor];
    [salesLabel setText:[NSString stringWithFormat:@"%d", [item.sales intValue]]]; 
    
    UIImageView* distanceImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"groupBuyDistance.png"]] autorelease];
    [distanceImgView setFrame:CGRectMake(200,75, 13, 13)];    
    UILabel *distanceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(218, 77, 120, 14)]autorelease];
    distanceLabel.numberOfLines = 1;
    distanceLabel.textColor = salesColor;
    distanceLabel.font = salesFont;
    distanceLabel.backgroundColor = [UIColor clearColor];
    if(nil == item.extInfo || [item.extInfo isEqualToString:@""] || [item.hasLbs isEqualToString:@"0"]) { 
        [distanceLabel setText:@"未知"];  
    }
    else {
        NSString *distanceStr;
        if ([item.extInfo doubleValue] > 1) {
            distanceStr = [NSString stringWithFormat:@"%1.2fkm",[item.extInfo floatValue] ];
            
        }else { 
            distanceStr = [NSString stringWithFormat:@"%gm",[item.extInfo floatValue]*1000];
        }
        
        [distanceLabel setText:distanceStr];  
    }
    
    HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(2, 10, 110, 80)]autorelease];
    TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
    httpImageView.memoryCache = memoryCache ;
    httpImageView.contentMode = UIViewContentModeScaleAspectFill;
    httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    
    NSString *picturl = [NSString stringWithFormat:@"http://img03.taobaocdn.com/bao/uploaded/i3/%@_120x120.jpg",item.image];
    [httpImageView setUrl:picturl];
    CALayer *layer = [httpImageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:0.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0]  CGColor]];
    
//    UIImageView *timeImage = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timelist.png"]]autorelease]; 
//    timeImage.frame = CGRectMake(0, 0, 100, 26);
//    
//    UIImageView *clock = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock.png"]]autorelease];
//    clock.frame = CGRectMake(2, 6, 14, 14);
//    [timeImage addSubview:clock];
//    
//    EtaoTimeLabel *timerLabel = [[EtaoTimeLabel alloc]initWithFrame:CGRectMake(18, 16, 80, 14)];
//    [[EtaoTimerController sharedTimeLabelPointerArray]addObject:timerLabel];
//    timerLabel.textColor = [UIColor whiteColor];
//    [timerLabel setBackgroundColor:[UIColor clearColor]];
//    timerLabel.font = [UIFont systemFontOfSize:10];
//    timerLabel.textAlignment = UITextAlignmentLeft;
//    timerLabel.lineBreakMode = UILineBreakModeCharacterWrap;
//    timerLabel.item = item;
//    [timerLabel showLabelText];
//
//    [httpImageView addSubview:timeImage];    
    [cell addSubview: httpImageView];
//    [cell addSubview: timerLabel]; 
//    [timerLabel release];
    [cell addSubview:titleLabel];
    [cell addSubview:rmbImgView]; 
    [cell addSubview:priceLabel];
    [cell addSubview:salesImgView];
    [cell addSubview:salesLabel];
    [cell addSubview: distanceImgView];
    [cell addSubview: distanceLabel];
    
    //[cell addSubview:parentLable];
    

}

/* 重新加载 */
- (void)reloadData
{
}

@end
