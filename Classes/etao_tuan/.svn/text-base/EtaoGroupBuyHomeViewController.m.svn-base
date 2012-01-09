//
//  EtaoTuanSettingController.m
//  etao4iphone
//
//  Created by  on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoGroupBuyHomeViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoTuanSettingItem.h"
#import "EtaoTuanListController.h"
#import "ETaoUINavigationController.h"
#import "EtaoTuanListForMapController.h"
#import "ETPageTouchView.h"

@interface EtaoTuanHomeViewController() {
    
    NSString *_type;
    BOOL _isMap;
 }
@end


@implementation EtaoTuanHomeViewController

@synthesize cityView = _cityView;

@synthesize cells = _cells;

@synthesize mapView = _mapView;

@synthesize slideView = _slideView;

static id staticEtaoTuanHomeViewNav;


-(void)dealloc{

   
    if(_cityView != nil){_cityView.delegate = nil;[_cityView release];_cityView = nil;}
    if (_cells != nil) {
        [_cells removeAllObjects];
        [_cells release];
        _cells = nil;
    }
    if (_datasourceCache != nil) {
        [_datasourceCache removeAllObjects];
        [_datasourceCache release];
        _datasourceCache = nil;
    }
    if (_settingDataSource != nil) {
        [_settingDataSource release];
        _settingDataSource = nil;
    }
    if (_settingBySlide != nil) {
        [_settingBySlide release];
        _settingBySlide = nil;
    }
    if (_settingByTouch != nil) {
        [_settingByTouch release];
        _settingByTouch = nil;
    }
    
    [_slideView release];
    [_mapView release];
    
    [super dealloc];
}


+ (ETaoUINavigationController*)getNavgationController {
    return staticEtaoTuanHomeViewNav;
}

- (id)init{
    self = [super init];
    if (self) {   
        _type = @"list";
        return self;  
    }
	return nil; 
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
   //时间队列 
    [EtaoTimerController sharedTimeLabelPointerArray]; 
    
    staticEtaoTuanHomeViewNav = self.navigationController;
    _datasourceCache = [[NSMutableDictionary alloc]initWithCapacity:10];
    _isMap = NO;
    
    //导航区设置
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonHomeClick:)]autorelease];      
    self.navigationItem.leftBarButtonItem = home;
    
    EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"etao_list_button.png"] target:self action:@selector(UIBarButtonSettingClick:)]autorelease];
    self.navigationItem.rightBarButtonItem = display;
    
    EtaoTuanCityController* tmp = [[[EtaoTuanCityController alloc]init]autorelease];
    self.cityView = tmp;
    _cityView.delegate = self;
    _cityView.btnClickDelegate = @selector(cityBtnClick:);    
    [_cityView loadView];
    
    self.navigationItem.titleView = _cityView.cityBtn;
    
    if (nil == _mapView) {
        _mapView = [[EtaoGroupBuyMapViewController alloc] init];
        [_mapView.view setFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];

        [self.view addSubview:_mapView.view];
      
        _mapView.view.hidden = YES;
    }
    
    if (nil == _slideView) {
        _slideView = [[ETPageSlideController alloc]init];
        _slideView.delegate = self;
        [self.view addSubview:_slideView.view];
    }
    
    if (nil == _settingDataSource) {
        _settingDataSource = [[EtaoTuanSettingDataSource alloc]init];
    }
    
    if (nil == _settingBySlide) {
        _settingBySlide = [[EtaoTuanSettingController alloc]init];
        _settingBySlide.datasource = _settingDataSource;
        _settingBySlide.title = @"选择分类"; 
    }

    if (nil == _settingByTouch) {
        _settingByTouch = [[EtaoTuanSettingController alloc]init];
        _settingByTouch.datasource = _settingDataSource;
        _settingByTouch.title = @"选择分类";
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [_settingDataSource load];
    self.cells = [_settingDataSource getSelectedItems];
    [_slideView reloadData];
    
}


#pragma mark -TouchView Delegate
/*********** touchView 代理 ************/
- (void)SingleTouch:(id)sender
{
    ETPageTouchView *touchView = sender;
    
//    if(_isMap){
//        _isMap = NO;
//        
//        _type = @"list";
//        [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];
//        
//        EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"地图" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
//        self.navigationItem.rightBarButtonItem = switchbtn;
//        
//        [UIView beginAnimations:nil context:nil];
//        
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDuration:0.4]; 
//        
//        [_slideView.view setFrame:CGRectMake(0, 0, 320, 480-44)];
//        [UIView setAnimationDidStopSelector:@selector(finishedMapShadow)];
//        [UIView commitAnimations]; 
//    }
//    else{
    if (touchView.page ==-1){
        [EtaoTuanCommonAnimations showShakeAnimation:_slideView.viewBody];
    }
    else if(touchView.page == _currentPage){
        [_settingByTouch.tableView reloadData];
        
        ETaoUINavigationController *nav =[[[ETaoUINavigationController alloc]initWithRootViewController:_settingByTouch andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
        
        EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"返回" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonBackClick:)]autorelease];
        _settingByTouch.navigationItem.leftBarButtonItem = back;
        
        EtaoUIBarButtonItem *done = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonDoneClick:)]autorelease];
        _settingByTouch.navigationItem.rightBarButtonItem = done;
        
        nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:nav animated:YES];  
    }
    else if(touchView.page == _currentPage+1){
        [_slideView reloadPage:[NSNumber numberWithInt:_currentPage+1]];
    }
    else if(touchView.page == _currentPage-1){
        [_slideView reloadPage:[NSNumber numberWithInt:_currentPage-1]];
    }
    else{
        
        }
//    }
}

- (void)upSlideTouch:(id)sender{
    if (_isMap) {              
        _isMap = NO;
        
        _type = @"list";
        [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];
        
        EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"地图" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
        self.navigationItem.rightBarButtonItem = switchbtn;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.4]; 
        [_slideView.view setFrame:CGRectMake(0, 0, 320, 460-44)];
        [UIView setAnimationDidStopSelector:@selector(finishedMapShadow)];
        [UIView commitAnimations]; 
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChangeListMode"];
    }

}

- (void)downSlideTouch:(id)sender{
    if(!_isMap){ 
        _isMap = YES;
        
        _type = @"map";
        [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];
        
        EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"列表" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
        switchbtn.title = @"map";
        self.navigationItem.rightBarButtonItem = switchbtn;
        
        [_mapView setHidden:NO];
        [UIView beginAnimations:nil context:nil]; 
        [UIView setAnimationDuration:0.4];
        [_mapView.view setFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];
        [_slideView.view setFrame:CGRectMake(0, MAP_HEIGHT, 320, 460-MAP_HEIGHT-44)];
        [UIView commitAnimations]; 
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChangeMapMode"];
    } 
}

#pragma mark -PageSlider Delegate
/*********** page slider 代理 **********/ 
- (UIViewController*)pageForColAtIndexPath:(NSNumber *)index
{
    if([index intValue]< _cells.count){
        EtaoTuanSettingItem* cell = [_cells objectAtIndex:[index integerValue]];
        EtaoTuanAuctionDataSource* datasource = [_datasourceCache objectForKey:cell.tag];
        if(datasource == nil){
            NSString *str = ([_cityView.cityBtn.btn.titleLabel.text isEqualToString:@"选择城市"])?@"":_cityView.cityBtn.btn.titleLabel.text;
            datasource = [[[EtaoTuanAuctionDataSource alloc]initWithSettingItem:cell withCity:str] autorelease];
            [_datasourceCache setObject:datasource forKey:cell.tag];
        }
        if ([_type isEqualToString:@"list"]) {
            EtaoTuanListController* ctrl = [[[EtaoTuanListController alloc]init]autorelease];
            [datasource setDelegate:ctrl andMap:_mapView andCity:_cityView];
            CGRect frame = ctrl.view.frame;
            frame.size.height = 416-30;
            ctrl.view.frame = frame;
            return ctrl;
        }
        else{
            EtaoTuanListForMapController* ctrl = [[[EtaoTuanListForMapController alloc]init]autorelease];
            [datasource setDelegate:ctrl andMap:_mapView andCity:_cityView];
            CGRect frame = ctrl.view.frame;
            frame.size.height = 416-MAP_HEIGHT-30;
            ctrl.view.frame = frame;
            
            return ctrl;
        }
    }
    else{
        if ([_type isEqualToString:@"list"]) {
            CGRect frame = _settingBySlide.view.frame;
            frame.size.height = 416-30;
            _settingBySlide.view.frame = frame;
        }
        else{
            CGRect frame = _settingBySlide.view.frame;
            frame.size.height = 416-MAP_HEIGHT-30;
            _settingBySlide.view.frame = frame;
        }
        return _settingBySlide;
    }
}


//主nav 右侧模式切换按钮
- (void) UIBarButtonSwitchDisplyMode:(UIBarButtonItem*)sender{
    if(_currentPage <_cells.count){
        if ([sender isKindOfClass:[EtaoUIBarButtonItem class]]) { 
            if (_isMap) {              
                _isMap = NO;
                
                _type = @"list";
                [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];
                
                EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"地图" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
                self.navigationItem.rightBarButtonItem = switchbtn;
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.4]; 
                [_slideView.view setFrame:CGRectMake(0, 0, 320, 460-44)];
                [UIView setAnimationDidStopSelector:@selector(finishedMapShadow)];
                [UIView commitAnimations]; 
                
                [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChangeListMode"];
            }
            else 
            { 
                _isMap = YES;
                
                _type = @"map";
                [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];

                EtaoUIBarButtonItem *switchbtn = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"列表" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
                switchbtn.title = @"map";
                self.navigationItem.rightBarButtonItem = switchbtn;
                
                [_mapView setHidden:NO];
                [UIView beginAnimations:nil context:nil]; 
                [UIView setAnimationDuration:0.4];
                [_mapView.view setFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];
                [_slideView.view setFrame:CGRectMake(0, MAP_HEIGHT, 320, 480-MAP_HEIGHT-44)];
                [UIView commitAnimations]; 
                
                [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ChangeMapMode"];
            } 
        } 	
        
    }
    else{
    }
}

//地图覆盖动画结束，完全被列表覆盖后，隐藏地图，提高List刷新速度
- (void)finishedMapShadow {
    if (_isMap == NO ) { 
        [_mapView setHidden:YES];
    }
}




- (void)slidePageForColAtIndexPath:(NSNumber *)index withCtrls:(UIViewController *)controller {
    
    _currentPage = [index intValue];
    
    //图标切换
    if([index intValue]< _cells.count){

        EtaoTuanSettingItem* cell = [_cells objectAtIndex:[index integerValue]];
        EtaoTuanAuctionDataSource* datasource = [_datasourceCache objectForKey:cell.tag];
        EtaoTuanListController* listCtrls = (EtaoTuanListController*)controller;
        [datasource setDelegate:listCtrls andMap:_mapView andCity:_cityView];
        
        NSString* cityName = [_cityView getUserCity] ;
        if ([cityName compare:@"选择城市"] != NSOrderedSame) {
            NSString* oriCityName = [datasource.query objectForKey:@"city"];
            if(oriCityName ==nil || ![oriCityName isEqualToString:cityName]){
                [datasource.query setObject:_cityView.cityBtn.btn.titleLabel.text forKey:@"city"];
                [listCtrls pullDownLikeManDoes];    
            }
        }
        
        if (datasource.delegateForMap) {
            if ([datasource.delegateForMap respondsToSelector:@selector(showFirstMapAuctions)]) {
                [datasource.delegateForMap showFirstMapAuctions];
            }
        }
        
        if (_isMap) {
            EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"列表" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
            self.navigationItem.rightBarButtonItem = display;
        }else {
            EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"地图" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonSwitchDisplyMode:)]autorelease];
            self.navigationItem.rightBarButtonItem = display;
        }
    }
    else{
        EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonDoneClick:)]autorelease];
        self.navigationItem.rightBarButtonItem = display;
    }
}

- (NSMutableArray*)getAllHeaders
{
    NSMutableArray* headers = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoTuanSettingItem* cell in _cells){
        [headers addObject:cell.tag];
    }
    [headers addObject:@"选择分类"];
    return headers;
}

- (NSMutableArray*)getAllKeys
{
    NSMutableArray* keys = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoTuanSettingItem* cell in _cells){
        [keys addObject:[NSString stringWithFormat:@"%@_%@",cell.tag,_type]];//类似 KTV 的key格式
    }
    [keys addObject:@"选择分类"];
    return keys;
}

//主nav返回
- (void) UIBarButtonHomeClick:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
    [_cityView.cityBtn performSelector:@selector(doArrow) withObject:nil afterDelay:0]; 
} 

-(void)cityBtnClick:(UIButton *)btn{
    
    [self UIBarButtonHomeClick:(UIBarButtonItem*)btn];
    [_cityView.cityBtn setText:btn.titleLabel.text];
    [[NSUserDefaults standardUserDefaults] setObject:btn.titleLabel.text forKey:@"USERCITYNAME"]; 
    [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];
    [_mapView setMapCenter:[_cityView getLatitudeAndLongitude:_cityView.cityBtn.btn.titleLabel.text]];
}


//上提的setting nav 有侧完成按钮
- (void) UIBarButtonDoneClick:(UIBarButtonItem*)sender
{
    [[_settingByTouch parentViewController] dismissModalViewControllerAnimated:YES];
    
    [_settingDataSource save]; //保存
    self.cells = [_settingDataSource getSelectedItems];
    [_settingBySlide.tableView reloadData];
    [_settingByTouch.tableView reloadData];
    [_slideView reloadData];
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SettingDone"];
}

//上提的setting nav 左侧返回按钮
- (void) UIBarButtonBackClick:(UIBarButtonItem*)sender
{ 
    [[_settingByTouch parentViewController] dismissModalViewControllerAnimated:YES];
} 

- (void)reloadPage{
    [_slideView reloadPage:[NSNumber numberWithInt:_currentPage]];
}

@end
