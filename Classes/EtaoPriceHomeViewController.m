//
//  EtaoJiangJiaHomeViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceHomeViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoPriceListController.h"
#import "EtaoPriceImageController.h"
#import "EtaoPriceWaterfallController.h"
#import "ETaoHelpView.h"
@implementation EtaoPriceHomeViewController



#pragma mark - View lifecycle
static id staticEtaoPriceHomeViewNav;

+ (ETaoUINavigationController*)getNavgationController
{
    return staticEtaoPriceHomeViewNav;
}

- (void) UIBarButtonHomeClick:(UIBarButtonItem*)sender
{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
} 

- (void) UIBarButtonBackClick:(UIBarButtonItem*)sender
{ 
    [[_setting parentViewController] dismissModalViewControllerAnimated:YES];
 
    // for iso5 only 
    if([_setting respondsToSelector:@selector(removeFromParentViewController)] ) {
        [_setting removeFromParentViewController];
    }   
    [_setting.view removeFromSuperview];
    [self loadScrollViewWithPage:_currentPage];
} 

- (void) UIBarButtonDoneClick:(UIBarButtonItem*)sender
{
    [[_setting parentViewController] dismissModalViewControllerAnimated:YES];
     // for iso5 only 
    if([_setting respondsToSelector:@selector(removeFromParentViewController)] ) {
        [_setting removeFromParentViewController];
    }   
    [_setting.view removeFromSuperview];
    
    EtaoPriceSettingController* setCtrls = _setting;
    [setCtrls save];//先保存
    NSArray* cells = [setCtrls getDataSource];//拿到数据源
    [setCtrls start]; //同步到云
    [_priceControllers removeAllObjects];
    for(EtaoPriceSettingModuleCell* cell in cells){
        if([cell.selected isEqualToString:@"0"])continue;
        if([cell.type isEqualToString:@"0"]){
            EtaoPriceListController* listCtrl = [[[EtaoPriceListController alloc]init]autorelease];
            listCtrl.title = cell.tag;
            [listCtrl setQuery:cell.catid forKey:@"catmap"];
            [listCtrl setQuery:cell.siteid forKey:@"site_id"];
            listCtrl.cell = cell;
            [_priceControllers addObject:listCtrl];
        }
        else{
            EtaoPriceWaterfallController* imgCtrl = [[[EtaoPriceWaterfallController alloc]init]autorelease];
            imgCtrl.title = cell.tag;
            [imgCtrl setQuery:cell.catid forKey:@"catmap"];
            [imgCtrl setQuery:cell.siteid forKey:@"site_id"];
            imgCtrl.cell = cell;
            [_priceControllers addObject:imgCtrl];
        }
    }
    [_priceControllers addObject:_setting];
    [self selectToPage:0]; 
}

- (void) UIBarButtonSettingClick:(UIBarButtonItem*)sender{
    //同步锁，保证模式切换的一致性
    if(_mode_lock == YES){
        return;
    }
    _mode_lock = YES;
    UIViewController* ctrls = [_priceControllers objectAtIndex:_currentPage];
    //切换到图片模式
    if([ctrls isKindOfClass:[EtaoPriceListController class]]){
        NSArray* cells = [_setting getDataSource];//拿到数据源
        EtaoPriceSettingModuleCell* cell = [cells objectAtIndex:_currentPage];
        cell.type = @"1";
        [_setting save];
        
        EtaoPriceListController* listCtrls = (EtaoPriceListController*)ctrls;
        EtaoPriceWaterfallController* imgCtrls = [[[EtaoPriceWaterfallController alloc]init]autorelease];
        imgCtrls.title = listCtrls.title;
        imgCtrls.cell = listCtrls.cell;
        [imgCtrls setQuery:imgCtrls.cell.catid forKey:@"catmap"];
        [imgCtrls setQuery:imgCtrls.cell.siteid forKey:@"site_id"];
        
        [_priceControllers replaceObjectAtIndex:_currentPage withObject:imgCtrls];
        [self reloadData];
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-WaterfallMode"];
        
    }
    //切换到列表模式
    else if([ctrls isKindOfClass:[EtaoPriceWaterfallController class]]){
        NSArray* cells = [_setting getDataSource];//拿到数据源
        EtaoPriceSettingModuleCell* cell = [cells objectAtIndex:_currentPage];
        cell.type = @"0";
        [_setting save];
        
        EtaoPriceWaterfallController* imgCtrls = (EtaoPriceWaterfallController*)ctrls;
        EtaoPriceListController* listCtrls = [[[EtaoPriceListController alloc]init]autorelease];
        listCtrls.title = imgCtrls.title;
        listCtrls.cell = imgCtrls.cell;
        [listCtrls setQuery:listCtrls.cell.catid forKey:@"catmap"];
        [listCtrls setQuery:listCtrls.cell.siteid forKey:@"site_id"];

        [_priceControllers replaceObjectAtIndex:_currentPage withObject:listCtrls];
        [self reloadData];
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ListMode"];
    }
    //设置页面
    else if([ctrls isKindOfClass:[EtaoPriceSettingController class]]){
        EtaoPriceSettingController* setCtrls = (EtaoPriceSettingController*)ctrls;
        [setCtrls save];//先保存
        NSArray* cells = [setCtrls getDataSource];//拿到数据源
        [setCtrls start]; //同步到云
        [_priceControllers removeAllObjects];
        for(EtaoPriceSettingModuleCell* cell in cells){
            if([cell.selected isEqualToString:@"0"])continue;
            if([cell.type isEqualToString:@"0"]){
                EtaoPriceListController* listCtrl = [[[EtaoPriceListController alloc]init]autorelease];
                listCtrl.title = cell.tag;
                [listCtrl setQuery:cell.catid forKey:@"catmap"];
                [listCtrl setQuery:cell.siteid forKey:@"site_id"];
                listCtrl.cell = cell;
                [_priceControllers addObject:listCtrl];
            }
            else{
                EtaoPriceWaterfallController* imgCtrl = [[[EtaoPriceWaterfallController alloc]init]autorelease];
                imgCtrl.title = cell.tag;
                [imgCtrl setQuery:cell.catid forKey:@"catmap"];
                [imgCtrl setQuery:cell.siteid forKey:@"site_id"];
                imgCtrl.cell = cell;
                [_priceControllers addObject:imgCtrl];
            }
        }
        [_priceControllers addObject:_setting];
        [self selectToPage:0];
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SettingDone"];
    }
    _mode_lock = NO;
}

- (id)init{
    self = [super init];
    if (self) {   
        return self;  
    }
	return nil; 
}

- (void) dealloc {
    [_priceControllers release];
    [_setting release]; 
    
    [super dealloc];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    //_pageSlideController = [[EtaoPageSlideController alloc]init];
    
    self.delegate = self;
    staticEtaoPriceHomeViewNav = self.navigationController;
    
    //导航区设置
    self.title = @"实时降价";
    [self.navigationController setNavigationBarHidden:NO animated:NO];     
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonHomeClick:)]autorelease];
        
    EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"etao_image_button.png"] target:self action:@selector(UIBarButtonSettingClick:)]autorelease];
    
    self.navigationItem.leftBarButtonItem = home;
    self.navigationItem.rightBarButtonItem = display;
    
    //初始化开始的controllers for test
    _priceControllers = [[NSMutableArray alloc]init];
    
    _setting = [[EtaoPriceSettingController alloc]init];
    _setting.title = @"选择分类"; 
    
 //   ETaoHelpView *help = [[[ETaoHelpView alloc] initWithImage:[UIImage imageNamed:@"etao_price_help.png"] withName:@"etao_price"] autorelease];
 //   [help show];
}

- (void)viewWillAppear:(BOOL)animated {
    ETaoHelpView *help = [[[ETaoHelpView alloc] initWithImage:[UIImage imageNamed:@"etao_price_help.png"] withName:@"etao_price"] autorelease];
    [help show];     
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_setting start];
    
    NSArray* cells = [_setting getDataSource];//拿到数据源
    if(cells.count==0){
        [NSThread sleepForTimeInterval:1];
    }
    for(EtaoPriceSettingModuleCell* cell in cells){
        if([cell.selected isEqualToString:@"0"])continue;
        if([cell.type isEqualToString:@"0"]){
            EtaoPriceListController* listCtrl = [[[EtaoPriceListController alloc]init]autorelease];
            listCtrl.title = cell.tag;
            [listCtrl setQuery:cell.catid forKey:@"catmap"];
            [listCtrl setQuery:cell.siteid forKey:@"site_id"];
            [_priceControllers addObject:listCtrl];
            listCtrl.cell = cell;
        }
        else{
            EtaoPriceWaterfallController* imgCtrl = [[[EtaoPriceWaterfallController alloc]init]autorelease];
            imgCtrl.title = cell.tag;
            [imgCtrl setQuery:cell.catid forKey:@"catmap"];
            [imgCtrl setQuery:cell.siteid forKey:@"site_id"];
            [_priceControllers addObject:imgCtrl];
            imgCtrl.cell = cell;
        }
    }
    
    [_priceControllers addObject:_setting];
    [self selectToPage:0];
    
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


/* 代理函数 */
- (void)pageSlideController:(EtaoPageSlideController *)tabBarController didSildeViewController:(UIViewController *)viewController
{
    /*
    if([viewController isKindOfClass:[EtaoPriceSettingController class]]){
        if(viewController && [viewController respondsToSelector:@selector(start)]){
            [viewController performSelector:@selector(start)];
        }
    }
     */
    
    if([[_viewCtrls objectAtIndex:_currentPage] isKindOfClass:[EtaoPriceWaterfallController class]]){
        EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"etao_list_button.png"] target:self action:@selector(UIBarButtonSettingClick:)]autorelease]; 
        self.navigationItem.rightBarButtonItem = display;
    }
    else if([[_viewCtrls objectAtIndex:_currentPage]isKindOfClass:[EtaoPriceListController class]]){
        EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"etao_image_button.png"] target:self action:@selector(UIBarButtonSettingClick:)]autorelease]; 
        self.navigationItem.rightBarButtonItem = display;
    }
    else if([[_viewCtrls objectAtIndex:_currentPage]isKindOfClass:[EtaoPriceSettingController class]]){
        EtaoUIBarButtonItem *display = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonSettingClick:)]autorelease];
        self.navigationItem.rightBarButtonItem = display;
    }

}

- (void)pageSlideController:(EtaoPageSlideController *)tabBarController reloadData:(NSMutableArray *)scrollCtrls
{
    [scrollCtrls removeAllObjects];
    for(UIViewController* ctrls in _priceControllers){
        [scrollCtrls addObject:ctrls];
    }
}

- (void)pageSlideController:(EtaoPageSlideController *)tabBarController didSildeHeaderLabel:(UILabel *)headerLabel
{

    
}

- (void)touchMe
{
 
  
    _setting.title = @"选择分类"; 
    ETaoUINavigationController *nav =[[[ETaoUINavigationController alloc]initWithRootViewController:_setting andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
    
    EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"返回" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonBackClick:)]autorelease];
    _setting.navigationItem.leftBarButtonItem = back;
    
    EtaoUIBarButtonItem *done = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"完成" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonDoneClick:)]autorelease];
    _setting.navigationItem.rightBarButtonItem = done;
    
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:nav animated:YES];  

}


@end
