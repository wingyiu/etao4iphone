//
//  EtaoPriceMainViewController.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceMainViewController.h"
#import "EtaoPriceSRPTableViewController.h"

@implementation EtaoPriceMainViewController
static id staticEtaoPriceHomeViewNav;

@synthesize cells = _cells;

+ (ETaoUINavigationController*)getNavgationController
{
    return staticEtaoPriceHomeViewNav;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    //数据中心保存
    //[[ETDataCenter dataCenter] save];
    
    [_settingBySlide release];
    [_settingByTouch release];
    [_cells release];
    [_mainView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)load{
    
    /* controller初始化 */
    
    // 滑动的setting controller
    _settingBySlide = [[EtaoPriceSettingController alloc]init];
    [_settingBySlide watchWithKey:[EtaoPriceBuySettingDataSource keyName:nil]];
    _settingBySlide.title = @"选择分类"; 
    
    
    // 触摸的setting controller
    _settingByTouch = [[EtaoPriceSettingController alloc]init];
    [_settingByTouch watchWithKey:[EtaoPriceBuySettingDataSource keyName:nil]];
    _settingByTouch.title = @"选择分类";
    
    [_settingDataSource reload];
    self.cells = [_settingDataSource getSelectedItems];
    [_mainView reloadData];
     
}


- (void)loadView
{
    [super loadView];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    staticEtaoPriceHomeViewNav = self.navigationController;
    
    //导航区设置
    self.title = @"实时降价";
    [self.navigationController setNavigationBarHidden:NO animated:NO];     
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonHomeClick:)]autorelease];
    self.navigationItem.leftBarButtonItem = home;
    
    //按钮展示
    [self showImageButton];
    
    //page slider
    _mainView = [[ETPageSlideController alloc]init];
    [_mainView.view setFrame:CGRectMake(0, 0, 320, 480)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView.view];
    
    /* datsource 初始化 */
    //初始化 setting的datasource
    if (nil == _settingDataSource) {
        if(![[ETDataCenter dataCenter] isExist:[EtaoPriceBuySettingDataSource keyName:nil]]){
            _settingDataSource = [[EtaoPriceBuySettingDataSource alloc]init];
            [[ETDataCenter dataCenter]addDataSource:_settingDataSource 
                                            withKey:[EtaoPriceBuySettingDataSource keyName:nil]];
        }
        else{
            _settingDataSource = (EtaoPriceBuySettingDataSource*)[[ETDataCenter dataCenter]getDataSourceWithKey:[EtaoPriceBuySettingDataSource keyName:nil]];
        }
    }
    
    // add search
    _textField = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)]autorelease];  
    
    _tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain]autorelease];
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableview.autoresizesSubviews = YES; 
  //  _tableview.hidden = YES;
    self.navigationItem.titleView = _textField;  
    [self.view addSubview:_tableview];
    [self.view sendSubviewToBack:_tableview];
    [self.navigationController setNavigationBarHidden:NO animated:NO]; 
    
    _etaoUISearchDisplayController = [[EtaoUISearchDisplayController alloc]initWithTextField:_textField
                                                                                        tableView:_tableview  
                                                                                          NavItem:self.navigationItem
                                                                                 withSearchButton:YES];
    _textField.placeholder = @"全网降价商品";
    _etaoUISearchDisplayController.delegate = self;  

    
    
    [self performSelector:@selector(load) withObject:nil afterDelay:0.0];
}


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

#pragma mark -TouchView Delegate
/*********** touchView 代理 ************/
- (void)SingleTouch:(id)sender
{
    ETPageTouchView* touchView = sender;
    if(touchView.page == -1){
        [EtaoPriceCommonAnimations showShakeAnimation:_mainView.viewBody];
    }
    else if(touchView.page == _currentPage){
       // [self appearSetting];
    }
    else if(touchView.page == _currentPage+1){
        [_mainView reloadPage:[NSNumber numberWithInt:_currentPage+1]];
    }
    else if(touchView.page == _currentPage-1){
        [_mainView reloadPage:[NSNumber numberWithInt:_currentPage-1]];
    }
    else{
        
    }
}


#pragma mark -PageSlider Delegate
/*********** page slider 代理 **********/ 
- (UIViewController*)pageForColAtIndexPath:(NSNumber *)index
{
    if([index intValue]< _cells.count){
        EtaoPriceSettingItem* cell = [_cells objectAtIndex:[index integerValue]];
        
        NSString* datasource_key = [EtaoPriceBuyAuctionDataSource keyName:cell.tag];
        EtaoPriceBuyAuctionDataSource* datasource = nil;
        if(![[ETDataCenter dataCenter] isExist:datasource_key]){
            datasource = [[[EtaoPriceBuyAuctionDataSource alloc]initWithSettingItem:cell]autorelease];
            [[ETDataCenter dataCenter] addDataSource:datasource withKey:datasource_key];
        }

        if([_settingDataSource.mode isEqualToString:@"0"]){
//           EtaoPriceListController* ctrl = [[[EtaoPriceListController alloc]init]autorelease];
            EtaoPricePubuliuController* ctrl = [[[EtaoPricePubuliuController alloc]init]autorelease];
            [ctrl watchWithKey:datasource_key];
            //调整窗体大小
            CGRect frame = ctrl.view.frame;
            frame.size.height = 416-30;
            ctrl.view.frame = frame;
            return ctrl;
        }
        else{
//           EtaoPriceWaterfallController* ctrl = [[[EtaoPriceWaterfallController alloc]init]autorelease];
             EtaoPricePubuliuController* ctrl = [[[EtaoPricePubuliuController alloc]init]autorelease];
            [ctrl watchWithKey:datasource_key];
            //调整窗体大小
            CGRect frame = ctrl.view.frame;
            frame.size.height = 416-30;
            ctrl.view.frame = frame;
            return ctrl;
        }
    }
    else{
        CGRect frame = _settingBySlide.view.frame;
        frame.size.height = 416-30;
        _settingBySlide.view.frame = frame;
        return _settingBySlide;
    }
}

- (void)slidePageForColAtIndexPath:(NSNumber *)index withCtrls:(UIViewController *)controller
{
    
    _currentPage = [index intValue];
    
    //图标切换
    if([index intValue]< _cells.count){
        if([_settingDataSource.mode isEqualToString:@"0"]){
            [self showImageButton];
            
        }
        else{
            [self showListButton];
        }
    }
    else{
        [self showDoneButton];
    }
}

- (NSMutableArray*)getAllHeaders
{
    NSMutableArray* headers = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoPriceSettingItem* cell in _cells){
        [headers addObject:cell.tag];
    }
    [headers addObject:@"选择分类"];
    return headers;
}

- (NSMutableArray*)getAllKeys
{
    NSMutableArray* keys = [[[NSMutableArray alloc]init]autorelease];
    for(EtaoPriceSettingItem* cell in _cells){
        [keys addObject:[NSString stringWithFormat:@"%@_%@",cell.tag,_settingDataSource.mode]];//类似 全部_1 的key格式
    }
    [keys addObject:@"选择分类"];
    return keys;
}

#pragma mark -Buttons
/**************** 按钮相关 ****************/

//主nav 左侧返回主菜单按钮
- (void) UIBarButtonHomeClick:(UIBarButtonItem*)sender
{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
} 

//上提setting 右侧完成按钮
- (void) UIBarButtonDoneClick:(UIBarButtonItem*)sender
{
    [[_settingByTouch parentViewController] dismissModalViewControllerAnimated:YES];

    self.cells = [_settingDataSource getSelectedItems];
    [_settingBySlide.tableView reloadData];
    [_mainView reloadData];
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SettingDone"];
}

//上提的setting 左侧返回按钮
- (void) UIBarButtonBackClick:(UIBarButtonItem*)sender
{ 
    [[_settingByTouch parentViewController] dismissModalViewControllerAnimated:YES];
} 

//主nav 右侧模式切换按钮
- (void) UIBarButtonSettingClick:(UIBarButtonItem*)sender{
    if(_currentPage <_cells.count){
        if([_settingDataSource.mode isEqualToString:@"1"]){
            _settingDataSource.mode = @"0";
            [_mainView reloadPage:[NSNumber numberWithInt:_currentPage]];
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-WaterfallMode"];
        }
        else{
            _settingDataSource.mode = @"1";
            [_mainView reloadPage:[NSNumber numberWithInt:_currentPage]];
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ListMode"];
        }
    }
}

#pragma mark -V others
//展现setting view
- (void)appearSetting{
    [_settingByTouch.tableView reloadData];
    ETaoUINavigationController *nav =[[[ETaoUINavigationController alloc]initWithRootViewController:_settingByTouch andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
    
    EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"返回" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonBackClick:)]autorelease];
    _settingByTouch.navigationItem.leftBarButtonItem = back;
    
    EtaoUIBarButtonItem *done = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonDoneClick:)]autorelease];
    _settingByTouch.navigationItem.rightBarButtonItem = done;
    
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:nav animated:YES]; 
}

- (void)disappearSetting{
}

- (void)showListButton{
    [_etaoUISearchDisplayController setButtonText:@"搜索"]; 
//    EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"etao_list_button.png"] target:self action:@selector(UIBarButtonSettingClick:)]autorelease]; 
//    self.navigationItem.rightBarButtonItem = display;
}

- (void)showImageButton{
    [_etaoUISearchDisplayController setButtonText:@"搜索"]; 
//    EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"etao_image_button.png"] target:self action:@selector(UIBarButtonSettingClick:)]autorelease]; 
//    self.navigationItem.rightBarButtonItem = display;
}

- (void)showDoneButton{
    EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonDoneClick:)]autorelease];
    self.navigationItem.rightBarButtonItem = display;
}



- (void)textFieldInputDidCancel:(NSString*)text {
    [_textField resignFirstResponder];
    
    [self.view sendSubviewToBack:_tableview];
    
}

- (void)textFieldWordSelected:(NSString*)text {
    [_textField resignFirstResponder];
    
    EtaoPriceSRPTableViewController * srp = [[[EtaoPriceSRPTableViewController alloc] init]autorelease];  
	[srp search:text];   
    [self.navigationController pushViewController:srp  animated:YES]; 
    [self.view sendSubviewToBack:_tableview];
    
}

- (void)textFieldInputDidStart:(NSString*)text {  
    //     self.navigationItem.leftBarButtonItem = nil;
    
    [self.view bringSubviewToFront:_tableview];
}

- (void)textFieldInputDidEnd:(NSString*)text {
    [_textField resignFirstResponder];
    
    EtaoPriceSRPTableViewController * srp = [[[EtaoPriceSRPTableViewController alloc] init]autorelease];  
	[srp search:text];  
    srp.navigationItem.leftBarButtonItem = nil;
    [self.navigationController pushViewController:srp  animated:YES]; 
    [self.view sendSubviewToBack:_tableview];
}


@end
