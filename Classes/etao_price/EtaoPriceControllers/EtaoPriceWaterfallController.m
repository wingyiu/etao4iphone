//
//  EtaoPriceWaterfallController.m
//  EtaoTableViewFramework
//
//  Created by 左 昱昊 on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceWaterfallController.h"
#import "EtaoPriceAuctionDetailController.h"
#import "EtaoPriceDetailSwipeController.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation WaterfallHTTPImageView
@synthesize item = _item;
@synthesize index = _index;
@synthesize delegate = _delegate;
@synthesize action = _action;


- (id)init
{
    self = [super init];
    if(self != nil){
//         _greyLayer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DISPLAY_IMAGE_WIDTH, DISPLAY_IMAGE_WIDTH)];
//        [_greyLayer setBackgroundColor:[UIColor colorWithRed:195/255.0f green:195/255.0f blue:195/255.0f alpha:0.5]];
        return  self;
        
    }
    return nil;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self addSubview:_greyLayer];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    [_greyLayer performSelector:@selector(removeFromSuperview) withObject:nil];
}
 
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(self.delegate && [self.delegate respondsToSelector:self.action]){
        [self.delegate performSelector:self.action withObject:_item];
    }

}

- (void)dealloc
{
    
    [_item release];
    [super dealloc];
}

@end


@implementation EtaoPriceWaterfallController
@synthesize datasourceKey = _datasourceKey;

#pragma mark - View lifecycle
- (id)init
{
    self = [super init];
    if (self) {
        
        //初始化上拉锁定状态为未锁定,内存优化模式初始化
        /*
        _scroll_lock=NO;
        _balance_mem_lock=YES;
        for(int i = 0;i<3;i++){
            _view_frams[i] = malloc(sizeof(SViewFrame));
            _view_frams[i]->views = [[NSMutableArray alloc]init];
        }
         */

        _update_lock = NO;
        _num_of_col = 3; //九宫格，每一行展示3个
        _pix_of_width = DISPLAY_IMAGE_WIDTH;
        _pix_of_height = DISPLAY_IMAGE_WIDTH;
        
        //初始化每一列更新头的起始坐标为10
        for(int rowPosCur = 0;rowPosCur < DISPLAY_IMAGE_COUNT_EACH_ROW;rowPosCur++)_rowPos[rowPosCur] = DISPLAY_IMAGE_GAP ;
    }
    return self;
}

- (void)dealloc
{
    
    EtaoPriceBuyAuctionDataSource* datasource1 = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:self.datasourceKey];
    [ datasource1 removeObserver:self forKeyPath:@"status"];
    [_mainView release];
    [_items release];
    [_display_items release];
    [_refreshHeaderView release];
    [_refreshTailerView release];
    
    [super dealloc];
}


- (void) loadView
{
    [super loadView];
    //初始化本地数组     
    _items = [[NSMutableArray alloc]init];
    _display_items = [[NSMutableSet alloc]init];
    
    
    _mainView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-75)];
    [_mainView setDelegate:self];
    [self.view addSubview:_mainView];
    
    //初始化头部的下拉刷新View，retainCount = 2
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f-self.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height)]; 
    _refreshHeaderView.delegate = self;
    [_mainView addSubview:_refreshHeaderView];
    
    //初始化底部的上拉更新View，retainCount = 2
    _refreshTailerView = [[EGORefreshTableTailerView alloc]initWithFrame:
                          CGRectMake(0.0f, 0.0f, self.view.frame.size.width, _pix_of_height)]; 
    _refreshTailerView.delegate = self;

    
}


- (void) viewDidLoad
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

- (void) viewDidUnload
{
    [super viewDidUnload];
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
    /*
    SystemSoundID soundID;
    NSURL *filePath   = [[NSBundle mainBundle] URLForResource:@"Ping" withExtension:@"aiff"];
    AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
    */
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
    [self reloadTableViewDataSource]; //开始加载
    [self pullUp];
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
                //[self.tableView reloadData];
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

- (void)swipeWillExitAtIndex:(NSNumber *)index{
//    NSIndexPath *indexP = [NSIndexPath indexPathForRow:[index intValue] inSection:0];
//    [self.tableView selectRowAtIndexPath:indexP animated:YES scrollPosition:UITableViewScrollPositionTop];
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
#pragma mark -v did Select
- (void)didSelect:(EtaoPriceAuctionItem*)item{
    int index = [_items indexOfObject:item];
    if(index>=0){
        ETPageSwipeController* detailSwipe = [[[ETPageSwipeController alloc]initWithItems:_items 
                                                                            withDelegate:self 
                                                                                 atIndex:index 
                                                                           byDetailClass:[EtaoPriceAuctionDetailController class]]autorelease];
        
        [[EtaoPriceMainViewController getNavgationController] pushViewController:detailSwipe animated:YES];
    }
}


#pragma mark -v Display Fuctions

//把队列分组装进另一个队列里
- (void)items2items:(NSMutableArray *)items1 toItems:(NSMutableArray *)items2
{
    BOOL needRefresh = NO;
    
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
                [items2 addObject:item1];
            }
        }
    }
    else{
        needRefresh = YES;
    }
    
    if(needRefresh){
        [_display_items removeAllObjects];
        [items2 removeAllObjects];
        
        //初始化每一列更新头的起始坐标为10
        for(int rowPosCur = 0;rowPosCur < DISPLAY_IMAGE_COUNT_EACH_ROW;rowPosCur++)_rowPos[rowPosCur] = 10 ;
        for (UIView* subview in _mainView.subviews){
            if([subview isKindOfClass:[WaterfallHTTPImageView class]])
                [subview removeFromSuperview];
        }
    
        for (EtaoPriceAuctionItem* item in items1){
            [items2 addObject:item];
        }
    }

    [self autoDisplay];
}

/*
 Step:1 dataToImages    从返回的data解析处获得宝贝列表
 Step:2 imagesToViews   宝贝列表的图片信息生成view
 Step:3 displayViews    主view调整展现这些imageview
 Step:4 addTailEGO      添加底部的ego视图
 */

- (void)autoDisplay
{
    
    //Step1 
    NSMutableArray* imgUrls = [self dataToImages];
    
    //Step2
    NSMutableArray* imgViews = [self imagesToViews:imgUrls];
    
    //Step3
    [self displayViews:imgViews];
    
    //Step4
    [_refreshTailerView removeFromSuperview];
    [_refreshTailerView setFrame:
     CGRectMake(0.0f,_mainView.contentSize.height-_pix_of_height,self.view.frame.size.width,self.view.frame.size.height)];
    [_mainView addSubview:_refreshTailerView];
    
}

//Step.1 负责解析data数据成image url list数组
- (NSMutableArray*)dataToImages
{
    EtaoPriceAuctionItem* item;
    NSMutableArray* imgUrls = [[[NSMutableArray alloc]init]autorelease];
    for(item in _items){
        if([_display_items containsObject:item] == YES){
            continue;
        }
        [_display_items addObject:item];
        [imgUrls addObject:item];
    }
    return imgUrls;
}

//Step.2 
- (NSMutableArray*)imagesToViews:(NSMutableArray*)imgUrls
{
    NSMutableArray* imgViews = [[[NSMutableArray alloc]initWithCapacity:imgUrls.count]autorelease]; //#autorelease
    EtaoPriceAuctionItem* item;
    for(item in imgUrls){
        //新建view对象，retainCount = 2
        WaterfallHTTPImageView* imgView = [[WaterfallHTTPImageView alloc]init];
        //imgView.isSyc = YES; //开启同步模式
        TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
        imgView.memoryCache = memoryCache ;
        imgView.item = item;
        imgView.delegate = self;
        imgView.action = @selector(didSelect:);
        
        if(item.image == nil){
            imgView.image = [UIImage imageNamed:@"no_picture_80x80.png"];
        }
        else{
            NSString*realurl = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@_120x120.jpg",item.image];
            [imgView setUrl:realurl];
        }
        [imgViews addObject:imgView];
    }
    return imgViews;
}

//Step.3
- (void)displayViews:(NSMutableArray*)imgViews
{
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
    NSEnumerator* e = [imgViews objectEnumerator];
    WaterfallHTTPImageView* imgView;
    while( imgView = [e nextObject]){
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
    size.height = contentHeighIncrease+DISPLAY_IMAGE_GAP+_pix_of_height; //多扩展height的高度，为了放置tailer
    size.width = self.view.frame.size.width;
    [_mainView setContentSize:size];
    
    
    //进行第二次遍历，并且把所有的imgview加入当前mainview
    e = [imgViews objectEnumerator];
    while( imgView = [e nextObject]){
        if(imgView){
            [_mainView addSubview:imgView];
            //[self frameAdd:imgView];
        }
    }
}

/* util function about image */

//根据指定的宽度重新计算图片大小
- (void)scaleWithWidth:(UIImageView*)imgView withLength:(CGFloat)length
{
    //设置图片属性，图片边框，图片自适应大小
    imgView.layer.borderColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1.0].CGColor;
    imgView.layer.borderWidth = DISPLAY_IMAGE_BORDER;
    imgView.clipsToBounds = NO;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    //计算图片缩放比例
    //CGFloat width = imgView.image.size.width;
    //CGFloat heigth = imgView.image.size.height;
    //CGFloat scale = length/width;
    //CGFloat Heigth = scale*heigth;
    
    CGRect frame = imgView.frame;
    frame.size.width = length;
    frame.size.height = length;
    imgView.frame = frame;    
}  


/* 重新加载 */
- (void)reloadData
{
 //    [self items2items:_datasource.items toItems:_items];
}

#pragma mark -v memory optimization

/* 内存管理
- (void)autoMemoryBalance
{
    CGFloat head_y = _mainView.contentOffset.y;
    CGFloat tail_y = _mainView.contentOffset.y+_mainView.frame.size.height;
    CGFloat Height = _mainView.contentSize.height;
    NSLog(@"%f,%f/%f",head_y,tail_y,Height);
    
}

- (void)memBalanceStatus
{
    NSLog(@"====Start====");
    NSLog(@"head_stack=%d",_head_stack_frames.frame_count);
    NSLog(@"tail_stack=%d",_tail_stack_frames.frame_count);
    NSLog(@"view_frames=[%d],[%d],[%d]",_view_frams[0]->views.count,_view_frams[1]->views.count,_view_frams[2]->views.count);
    NSLog(@"active_views=%d",_mainView.subviews.count);
    NSLog(@"=====End=====");
}

//frame 压栈
- (void)framePush:(SViewFrame*)frame withStack:(SStackFrames*)stack
{
    if(stack->frame_count == STACK_SIZE)return;
    int count = frame->views.count;
    stack->stack_frame[stack->frame_count].count = count;
    for(int i = 0;i<count;i++){
        HTTPImageView* view = [frame->views objectAtIndex:i];
        CGPoint point = view.frame.origin;
        NSString* url = view.url;
        stack->stack_frame[stack->frame_count].url[i] = [url copy];
        stack->stack_frame[stack->frame_count].point[i] = point;
    }
    stack->frame_count++;
}

//frame 出栈
- (void)framePop:(SViewFrame*)frame withStack:(SStackFrames*)stack
{
    if(stack->frame_count == 0)return;
    int count = stack->stack_frame[stack->frame_count-1].count;
    for( int i =0;i<count;i++){
        if(i==0)frame->top = stack->stack_frame[stack->frame_count-1].point[i].y;
        if(i==count-1)frame->bottom = stack->stack_frame[stack->frame_count-1].point[i].y;
        HTTPImageView* view = [[[HTTPImageView alloc]init]autorelease]; //生成view
        [view setUrl:stack->stack_frame[stack->frame_count-1].url[i]];    //设置url
        [stack->stack_frame[stack->frame_count-1].url[i] release];
        [self scaleWithWidth:view withLength:DISPLAY_IMAGE_WIDTH];      //调整大小
        CGRect f = view.frame;
        f.origin = stack->stack_frame[stack->frame_count-1].point[i];     //设置起始坐标
        view.frame = f;                                   
        [frame->views addObject:view];
        [_mainView addSubview:view];
    }
    stack->frame_count--;
}


- (void)frameClean:(SViewFrame*)frame
{
    [frame->views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [frame->views removeAllObjects];
    frame->top = -1;
    frame->bottom = -1;
}

- (void)framesClean
{
    //栈清空
    _head_stack_frames.frame_count = 0;
    _tail_stack_frames.frame_count = 0;
    //frames清空
    for(int i =0;i<3;i++){
        [self frameClean:_view_frams[i]];
    }
}

//frame调整
- (void)framesAdjust
{
    //锁定状态，直接返回
    if(_balance_mem_lock)return;
    
    CGFloat head_y = _mainView.contentOffset.y;
    CGFloat tail_y = _mainView.contentOffset.y+_mainView.frame.size.height;
    if(head_y > _view_frams[1]->bottom){
        SViewFrame* viewFrame = _view_frams[0];
        _view_frams[0] = _view_frams[1];
        _view_frams[1] = _view_frams[2];
        [self framePush:viewFrame withStack:&_head_stack_frames];
        [self memBalanceStatus];
        NSLog(@"正向自适应,释放个数->%d",viewFrame->views.count);
        [self frameClean:viewFrame];
        [self framePop:viewFrame withStack:&_tail_stack_frames];
        _view_frams[2] = viewFrame;
    }
    else if(tail_y < _view_frams[1]->top){
        SViewFrame* viewFrame = _view_frams[2];
        _view_frams[2] = _view_frams[1];
        _view_frams[1] = _view_frams[0];
        [self framePush:viewFrame withStack:&_tail_stack_frames];
        NSLog(@"逆向自适应,释放个数->%d",viewFrame->views.count);
        [self frameClean:viewFrame];
        [self framePop:viewFrame withStack:&_head_stack_frames];
        _view_frams[0] = viewFrame;
    }
}

- (void)frameAdd:(UIView*)view
{
    CGPoint point = view.frame.origin;
    for(int i =0 ;i<3;i++){
        if(_view_frams[i]->views.count==ACTIVE_VIEW_COUNT)continue;
        //如果当前frame的个数为0,则是一个新的frame，需要给出top的坐标
        if(_view_frams[i]->views.count==0){
            _view_frams[i]->top = point.y;
        }
        //如果当前要加入的是最后一个frame，需要给出bottom的坐标
        _view_frams[i]->bottom = point.y;
        [_view_frams[i]->views addObject:view];
        return;
    }
    NSLog(@"内存优化解锁，开启内存优化模式！");
    _balance_mem_lock = NO;//解锁
    [self framesAdjust]; //调整frame位置，重新加载
    for(int i =0 ;i<3;i++){
        if(_view_frams[i]->views.count==ACTIVE_VIEW_COUNT)continue;
        //如果当前frame的个数为0,则是一个新的frame，需要给出top的坐标
        if(_view_frams[i]->views.count==0){
            _view_frams[i]->top = point.y;
        }
        //如果当前要加入的是最后一个frame，需要给出bottom的坐标
        _view_frams[i]->bottom = point.y;
        [_view_frams[i]->views addObject:view];
        return;
    }
}

//当前view接受到了touch 事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    
    HttpWaterfallViewTouchController* imgView = [[HttpWaterfallViewTouchController alloc]init];
    HTTPImageView* view = [[[HTTPImageView alloc]init]autorelease]; //#autorelease
    imgView.imgView = view;
    [imgView setFrame:CGRectMake(0, 0, 100, 100)];
    [imgView setBackgroundColor:[UIColor blackColor]];
    [imgView.imgView setUrl:@"http://img02.taobaocdn.com/tps/T1UBSmXi4BXXb1upjX_120x120.jpg"];
    [imgView.imgView setFrame:CGRectMake(0, 0, 100, 100)];
    [imgView addSubview:imgView.imgView];
    [[UIApplication sharedApplication].keyWindow addSubview:imgView];
     
     
    NSLog(@"%@",[self nextResponder]);
   // NSLog(@"%@",[self.view findFirstResponder]);
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
*/


@end

