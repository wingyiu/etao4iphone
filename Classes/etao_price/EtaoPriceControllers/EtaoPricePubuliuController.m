//
//  EtaoPricePubuliuController.m
//  etao4iphone
//
//  Created by 左 昱昊 on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPricePubuliuController.h"

@implementation PubuliuImageView
@synthesize item = _item;
@synthesize origin = _origin;
@synthesize readyForDisplay = _readyForDisplay;


- (id)init
{
    self = [super init];
    if(self != nil){
        _readyForDisplay = NO;
        self.userInteractionEnabled = YES;//这个选项决定了该view是否可以响应点击事件
        return  self;
    }
    return nil;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(SingleTouch:)]){
        [self.delegate performSelector:@selector(SingleTouch:) withObject:_item];
    }
}

- (void)dealloc
{
    [_item release];
    [super dealloc];
}

@end


@implementation EtaoPricePubuliuController
@synthesize datasourceKey = _datasourceKey;

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

- (void)dealloc
{
    
    EtaoPriceBuyAuctionDataSource* datasource1 = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:self.datasourceKey];
    [ datasource1 removeObserver:self forKeyPath:@"status"];
    for(UIView* view in _mainView.subviews){
        if([view isKindOfClass:[PubuliuImageView class]]){
            PubuliuImageView* pubuliuImageView = (PubuliuImageView*)view;
            [pubuliuImageView cancel];
        }
    }
    [_mainView release];
    [_items release];
    [_refreshHeaderView release];
    [_refreshTailerView release];
    [networkQueue release];
    
    [[_loadingImageTable allValues]makeObjectsPerformSelector:@selector(cancel)];
    [_loadingImageTable removeAllObjects];
    [_loadingImageTable release];
    
    [super dealloc];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    //初始化每一列更新头的起始坐标为10
    for(int rowPosCur = 0;rowPosCur < DISPLAY_IMAGE_COUNT_EACH_ROW;rowPosCur++)_rowPos[rowPosCur] = DISPLAY_IMAGE_GAP ;
    
    //初始化本地数组     
    _items = [[NSMutableArray alloc]init];
    _loadingImageTable = [[NSMutableDictionary alloc]init];
    
    networkQueue = [[ASINetworkQueue alloc]init];   
    [networkQueue setMaxConcurrentOperationCount:15];
    [networkQueue setSuspended:NO];
    
    //初始化主view
    _mainView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 386)];
    [_mainView setContentSize:CGSizeMake(320, 387)];
    [_mainView setDelegate:self];
    [self.view addSubview:_mainView];
    
    //初始化头部的下拉刷新View，retainCount = 2
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f-self.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height)]; 
    _refreshHeaderView.delegate = self;
    [_mainView addSubview:_refreshHeaderView];
    
    //初始化底部的上拉更新View，retainCount = 2
    _refreshTailerView = [[EGORefreshTableTailerView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f, self.view.frame.size.width, DISPLAY_IMAGE_WIDTH)]; 
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -v datasource delegate callback

- (void) showUpdateInformation:(NSString *)updateNum
{
    if ([updateNum intValue] == 0) {
        return ;
    }
    //初始化下拉更新label
    UILabel* update_label = [[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, -27, self.view.frame.size.width, 20)]autorelease];
    [self.view.superview addSubview:update_label];
    update_label.textAlignment = UITextAlignmentCenter;
    update_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_update_label27.png"]];
    update_label.textColor = [UIColor colorWithRed:131/255.0 green:93/255.0 blue:53/255.0 alpha:1.0];
    update_label.font = [UIFont systemFontOfSize:13];
    update_label.text = [NSString stringWithFormat:@"最近更新了%@条数据", updateNum];
    [EtaoPriceCommonAnimations performSelector:@selector(updateAnimationDown:) withObject:update_label afterDelay:0];
    [EtaoPriceCommonAnimations performSelector:@selector(updateAnimationUp:) withObject:update_label afterDelay:1.5];
    [update_label performSelector:@selector(removeFromSuperview) withObject:self afterDelay:2];
}

#pragma mark -v EGO delegate callback
/* 下拉回调 EGO  */
//停止更新数据
- (void)stopRefresh{
    if(_header_reloading){
        _header_reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_mainView];
        NSLog(@"==停止更新数据");
    }
    else if(_tailer_reloading){
        _tailer_reloading=NO;
        [_refreshTailerView egoRefreshScrollViewDataSourceDidFinishedLoading:_mainView];
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
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_mainView];
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
    [_refreshTailerView egoRefreshScrollViewDataSourceDidFinishedLoading:_mainView];
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
    if([_refreshTailerView superview] !=nil){
        [self reloadTableViewDataSource]; //开始加载
        [self pullUp];
    }
}

//纪录最后更新时间
- (NSDate*)egoRefreshTableTailerDataSourceLastUpdated:(EGORefreshTableTailerView*)view{ 
    return [NSDate date];
}

/* EGO Common */

//点击状态栏回到顶部
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

- (void)pullDownLikeManDoes
{
    //初始化，下拉
    _mainView.contentOffset = CGPointMake(0, -60);
    _mainView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
    [self refreshTableViewDataSource]; //开始更新
    [self performSelector:@selector(pullDown) withObject:self afterDelay:1];
}

//下拉刷新
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
//上拉翻页
- (void)pullUp
{
    EtaoPriceBuyAuctionDataSource* datasource = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:_datasourceKey];
    [datasource loadmore];
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ReloadList"];
}

#pragma mark -v datasource event respond function
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoPriceBuyAuctionDataSource class]]){
        EtaoPriceBuyAuctionDataSource* datasource = object;
        ET_DS_PRICEBUY_AUCTION_STATUS status = [[change objectForKey:@"new"] intValue];
        NSLog(@"%f",_mainView.contentSize.height);
        switch (status) {
            case ET_DS_PRICEBUY_AUCTION_OK: //数据加载完成
                if(_header_reloading)
                    [self performSelector:@selector(doneRefreshTableViewData) withObject:nil afterDelay:0.0];
                else if(_tailer_reloading)
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
                    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
                [_refreshHeaderView setStatus:@"更新失败"];
                [_refreshTailerView setStatus:@"网络异常"];
                break;
            case ET_DS_PRICEBUY_AUCTION_LOADING: //加载数据中
                break;
            case ET_DS_PRICEBUY_AUCTION_NOMORE:
                break;
            default:
                break;
        }
    }
}

#pragma mark -v swipe delegate
- (void)swipeAtIndex:(NSNumber *)index withCtrls:(UIViewController *)controller{
    if([index intValue] > _items.count -5){
        [self reloadTableViewDataSource]; //开始加载
        [self pullUp];
    }
}

#pragma mark -v ImageView Delegate
- (void)SingleTouch:(id)sender{
    EtaoPriceAuctionItem* item = (EtaoPriceAuctionItem*)sender;
    int index = [_items indexOfObject:item];
    if(index>=0){
        ETPageSwipeController* detailSwipe = [[[ETPageSwipeController alloc]initWithItems:_items 
                                                                             withDelegate:self 
                                                                                  atIndex:index 
                                                                            byDetailClass:[EtaoPriceAuctionDetailController class]]autorelease];
        
        [[EtaoPriceMainViewController getNavgationController] pushViewController:detailSwipe animated:YES];
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_120x120.jpg",item.image]);

}

- (void)httpImageSizeRecive:(ETHttpImageView *)httpimage{
    
    PubuliuImageView* imgView = (PubuliuImageView*) httpimage;
    imgView.readyForDisplay = YES;
//    [imgView.http setQueuePriority:NSOperationQueuePriorityVeryLow];//拿到大小后设置为低优先级
    
    [self autoDisplay];
    if([_loadingImageTable count]==0){
        [_refreshTailerView setFrame:
         CGRectMake(0.0f,_mainView.contentSize.height-DISPLAY_IMAGE_WIDTH,self.view.frame.size.width,self.view.frame.size.height)];
        [_mainView addSubview:_refreshTailerView];
        [self doneLoadingTableViewData];
    }
}

- (void)httpImageLoadFinished:(ETHttpImageView *)httpimage{
    PubuliuImageView* imgView = (PubuliuImageView*) httpimage;
    PubuliuImageView* imgView2 = [_loadingImageTable objectForKey:[imgView.item key]];
    if(imgView2 !=nil){
        imgView.readyForDisplay = YES;
        [self autoDisplay];
        if([_loadingImageTable count]==0){
            [_refreshTailerView setFrame:
             CGRectMake(0.0f,_mainView.contentSize.height-DISPLAY_IMAGE_WIDTH,self.view.frame.size.width,self.view.frame.size.height)];
            [_mainView addSubview:_refreshTailerView];
            [self doneLoadingTableViewData];
        }
    }
    
}

- (void)httpImageLoadFailed:(ETHttpImageView *)httpimage{
    PubuliuImageView* imgView = (PubuliuImageView*) httpimage;
    PubuliuImageView* imgView2 = [_loadingImageTable objectForKey:[imgView.item key]];
    if(imgView2 !=nil){
        imgView.readyForDisplay = YES;
    
        imgView.size = CGSizeMake(DISPLAY_IMAGE_WIDTH, DISPLAY_IMAGE_WIDTH);
        
        [self autoDisplay];
        if([_loadingImageTable count]==0){
            [_refreshTailerView setFrame:
             CGRectMake(0.0f,_mainView.contentSize.height-DISPLAY_IMAGE_WIDTH,self.view.frame.size.width,self.view.frame.size.height)];
            [_mainView addSubview:_refreshTailerView];
            [self doneLoadingTableViewData];
        }
    }
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

#pragma mark -V logic
- (void)items2items:(NSMutableArray *)items1 toItems:(NSMutableArray *)items2{
    BOOL needRefresh = NO;
    
    [_refreshTailerView removeFromSuperview];
    
    if(items1.count >= items2.count){
        for(int i = 0 ; i<items1.count ; i++){
            if(i < items2.count){
                EtaoPriceAuctionItem* item1 = [items1 objectAtIndex:i];
                EtaoPriceAuctionItem* item2 = [items2 objectAtIndex:i];
                if(![item1 isEqual:item2]){
                    needRefresh = YES;
                    break;
                }
            }
            else{
                EtaoPriceAuctionItem* item1 = [items1 objectAtIndex:i];
                [self beginLoad:item1];
                [items2 addObject:item1];
            }
        }
    }
    else{
        needRefresh = YES;
    }
    
    if(needRefresh){
        [items2 removeAllObjects];
        [_loadingImageTable removeAllObjects];
        
        //初始化每一列更新头的起始坐标为10
        for(int rowPosCur = 0;rowPosCur < DISPLAY_IMAGE_COUNT_EACH_ROW;rowPosCur++)_rowPos[rowPosCur] = 10 ;
        for (UIView* subview in _mainView.subviews){
            if([subview isKindOfClass:[PubuliuImageView class]])
                [subview removeFromSuperview];
        }
        
        for (EtaoPriceAuctionItem* item in items1){
            [self beginLoad:item];
            [items2 addObject:item];
        }

    }
}

- (void)autoDisplay{
    //遍历数组，找到需要渲染的数组
    
    NSMutableArray* displayArray = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoPriceAuctionItem* item in _items){
        PubuliuImageView* imageView = [_loadingImageTable objectForKey:[item key]];
        if(imageView !=nil){
            if(imageView.readyForDisplay == YES){
                [displayArray addObject:imageView];
                [_loadingImageTable removeObjectForKey:[item key]];
            }
//            else
//                break;
        }
    }
    
    if(displayArray.count >0){
        
        
        //纪录当前最后一次翻页的时候内部content的纵向偏移
        //初始化一个数组，纪录新的一页每一列起始偏移
        CGFloat rowPos[DISPLAY_IMAGE_COUNT_EACH_ROW];
        int rowPosCur=0;
        int rowPosCurLastMin = 0;
        int rowPosMin = _rowPos[0];
        for(rowPosCur =0;rowPosCur < DISPLAY_IMAGE_COUNT_EACH_ROW;rowPosCur++){
            rowPos[rowPosCur] = _rowPos[rowPosCur];
            if(rowPosCur!=0 && _rowPos[rowPosCur]< rowPosMin) {
                rowPosCurLastMin=rowPosCur;
                rowPosMin = _rowPos[rowPosCur];
            }
        }
        rowPosCur = rowPosCurLastMin;
        
        //进行第一次遍历，重新调整每张图片的大小,并计算最后的content偏移
        for(PubuliuImageView* imgView in displayArray){
            if(imgView){
                //调整图片大小
                [self scaleWithWidth:imgView withLength:DISPLAY_IMAGE_WIDTH];
                //调整图片位置
                int cur = rowPosCur%DISPLAY_IMAGE_COUNT_EACH_ROW;
                CGPoint point;
                point.x = cur*(DISPLAY_IMAGE_WIDTH+DISPLAY_IMAGE_GAP)+DISPLAY_IMAGE_GAP;
                point.y = rowPos[cur];
                CGRect frame = imgView.frame;
                frame.origin = point;    
                imgView.frame = frame;
                rowPos[cur]+=imgView.frame.size.height+DISPLAY_IMAGE_GAP;
                rowPosCur++;
            }
        }
        
        //找出content需要扩展多少
        CGFloat contentHeighIncrease = 0;
        for(rowPosCur=0;rowPosCur < DISPLAY_IMAGE_COUNT_EACH_ROW;rowPosCur++){
            _rowPos[rowPosCur] = rowPos[rowPosCur];
            if(contentHeighIncrease<rowPos[rowPosCur])
                contentHeighIncrease = rowPos[rowPosCur];
        }
        CGSize size = _mainView.contentSize;
        //如果扩展的长度不超过一页，自动加长，可以翻页
        if(self.view.frame.size.height > contentHeighIncrease) contentHeighIncrease = self.view.frame.size.height+100;
        size.height = contentHeighIncrease+DISPLAY_IMAGE_GAP+DISPLAY_IMAGE_WIDTH; //多扩展height的高度，为了放置tailer
        size.width = self.view.frame.size.width;
        [_mainView setContentSize:size];
        
        
        //进行第二次遍历，并且把所有的imgview加入当前mainview
        for(PubuliuImageView* imgView in displayArray){
                [_mainView addSubview:imgView];
        }
    }
}

- (void)beginLoad:(EtaoPriceAuctionItem *)item{
    PubuliuImageView* imageView = [[[PubuliuImageView alloc] init] autorelease];
    imageView.item = item;
    imageView.delegate = self;
    imageView.networkQueue = networkQueue;
    NSString* imgUrl = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_120x120.jpg",item.image];
    [imageView load:imgUrl];
    [_loadingImageTable setObject:imageView forKey:[item key]];
    
}

//根据指定的宽度重新计算图片大小
- (void)scaleWithWidth:(PubuliuImageView*)imgView withLength:(CGFloat)length
{
    
    //设置图片属性，图片边框，图片自适应大小
    imgView.layer.borderColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1.0].CGColor;
    imgView.layer.borderWidth = DISPLAY_IMAGE_BORDER;
    imgView.clipsToBounds = NO;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    //计算图片缩放比例
    CGFloat width = imgView.size.width;
    CGFloat heigth = imgView.size.height;
    CGFloat scale = length/width;
    CGFloat Heigth = scale*heigth;
    
    CGRect frame = imgView.frame;
    frame.size.width = length;
    frame.size.height = Heigth;
    imgView.frame = frame;    
}  


@end
