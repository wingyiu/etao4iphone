//
//  EtaoNewSearchHomeViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoNewSearchHomeViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoSRPController.h"
#import "ETaoUINavigationController.h"
#import "EtaoCategoryController.h"
#import "EtaoAuctionPriceCompareHistoryViewController.h"
#import "EtaoTuanDetailTest.h"
#import "ETaoSearchTopQueryController.h"
#import "ETaoHistoryViewController.h"
#import "etao4iphoneAppDelegate.h"
#import "ETaoHelpView.h"


@implementation EtaoNewSearchHomeViewController
@synthesize etaoUISearchDisplayController = _etaoUISearchDisplayController;
@synthesize etaoPageBaseViewController = _etaoPageBaseViewController ;
@synthesize textField = _textField;
@synthesize tableview = _tableview;  


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
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

- (void) UIBarButtonItemClick:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
} 


- (id)init{
    
    self = [super init];
    if (self) {           
        return self;  
    }
	return nil; 
}

- (void) dealloc{
    _tableview.delegate = nil ;
    _tableview.dataSource = nil;
    [_textField release]; 
    [_tableview release];
    [_etaoUISearchDisplayController release];
    [_etaoPageBaseViewController release];
    [super dealloc];
}

- (void) load{ 
    
    UIApplication *app = [UIApplication sharedApplication];
    etao4iphoneAppDelegate *dele = (etao4iphoneAppDelegate *)app.delegate;
    EtaoCategoryController *cate = [[[EtaoCategoryController alloc]init]autorelease]; 
    cate.parent = self;  
    
    ETaoHistoryViewController *his = [dele etaoHistoryViewController];
    his.parent = self; 
    
    // EtaoTuanDetailTest *test = [[[EtaoTuanDetailTest alloc]init]autorelease];
    ETaoSearchTopQueryController *topquery = [[[ETaoSearchTopQueryController alloc]init]autorelease];
    topquery.parent = self ; 
    
    self.etaoPageBaseViewController = [[[EtaoPageBaseViewController alloc]initWithViewController:[NSMutableArray arrayWithObjects:his,cate,topquery,nil]]autorelease];
    
    UIView *tmp = _etaoPageBaseViewController.view;
    tmp.frame = CGRectMake(0, 0, _etaoPageBaseViewController.view.frame.size.width, _etaoPageBaseViewController.view.frame.size.height);         
    _etaoPageBaseViewController.delegate = self;
    [_etaoPageBaseViewController scrollToPage:1];
    [self.view addSubview:tmp]; 
    _tableview.hidden = NO;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{  
    [super loadView];
    
    self.title = @"比价";
    
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)]autorelease];  
    
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain]autorelease];
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableview.autoresizesSubviews = YES; 
    _tableview.hidden = YES;
    
    self.navigationItem.titleView = _textField;  
    [self.view addSubview:_tableview];
    [self.view sendSubviewToBack:_tableview];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];   
    
    
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
    
    self.navigationItem.leftBarButtonItem = home; 
    
    
    
    self.etaoUISearchDisplayController = [[[EtaoUISearchDisplayController alloc]initWithTextField:_textField
                                                                                        tableView:_tableview  
                                                                                          NavItem:self.navigationItem
                                                                                 withSearchButton:YES]
                                          autorelease];
    
    _etaoUISearchDisplayController.delegate = self;  
    
    [self performSelector:@selector(load) withObject:nil afterDelay:0.0];
    

}
 
- (void)viewWillAppear:(BOOL)animated { 
    
    ETaoHelpView *help = [[[ETaoHelpView alloc] initWithImage:[UIImage imageNamed:@"etao_page_slidehelp.png"] withName:@"etao_srp"] autorelease];
    help.alpha = 0.7 ;
    help.backgroundColor = [UIColor blackColor];
    [help show];     
}

- (void)viewWillDisappear:(BOOL)animated { 
}

- (void)textFieldInputDidCancel:(NSString*)text {
    [_textField resignFirstResponder];
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
    self.navigationItem.leftBarButtonItem = home;
    
    [self.view sendSubviewToBack:_tableview];
     
}

- (void)textFieldWordSelected:(NSString*)text {
    [_textField resignFirstResponder];
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
    self.navigationItem.leftBarButtonItem = home;
    
    EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease]; 
	srp._keyword = text ;
	[srp search: srp._keyword];  
   // srp.navigationItem.leftBarButtonItem = nil;
    [self.navigationController pushViewController:srp  animated:YES]; 
    [self.view sendSubviewToBack:_tableview];
 
}

- (void)textFieldInputDidStart:(NSString*)text {  
//     self.navigationItem.leftBarButtonItem = nil;
    
    [self.view bringSubviewToFront:_tableview];
}

- (void)textFieldInputDidEnd:(NSString*)text {
    [_textField resignFirstResponder];
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
    self.navigationItem.leftBarButtonItem = home;
    
    EtaoSRPController * srp = [[[EtaoSRPController alloc] init]autorelease]; 
	srp._keyword = text ;
	[srp search: srp._keyword];
    srp.navigationItem.leftBarButtonItem = nil;
    [self.navigationController pushViewController:srp  animated:YES]; 
    [self.view sendSubviewToBack:_tableview];
}

- (void)searchButtonDidClick:(EtaoUIBarButtonItem*)button {
    NSLog(@"searchButtonDidClick");
    UIViewController * tmp = [_etaoPageBaseViewController.viewCtrls objectAtIndex:_etaoPageBaseViewController.pagectrl.currentPage ];
    if (![tmp isKindOfClass:[ETaoHistoryViewController class]]) {
        return ;
    }
    
    if ([button.title isEqualToString:@"编辑"] || [button.title isEqualToString:@"完成"]) { 
         ETaoHistoryViewController *his = (ETaoHistoryViewController*)[_etaoPageBaseViewController.viewCtrls objectAtIndex:_etaoPageBaseViewController.pagectrl.currentPage ];
        
        [his setEditing:YES];
        
        if ([button.title isEqualToString:@"编辑"]) { 
            [his.tableView setEditing:YES animated:YES];
            [_etaoUISearchDisplayController setButtonText:@"完成"];
        }
        else 
        {
            [_etaoUISearchDisplayController setButtonText:@"编辑"];
            [his.tableView setEditing:NO animated:YES];
        }
        
    }

}

- (void)pageSlideController:(UIViewController *)viewController {  
    NSLog(@"pageSlideController");
    if ([viewController isKindOfClass:[ETaoHistoryViewController class]]) {
        ETaoHistoryViewController *his = (ETaoHistoryViewController*)viewController; 
        [his.tableView reloadData];
        [_etaoUISearchDisplayController setButtonText:@"编辑"];
    }
    else
    {
       [_etaoUISearchDisplayController setButtonText:@"搜索"]; 
    }
    
    if ([viewController isKindOfClass:[ETaoHistoryViewController class]]) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_ENTER arg1:@"Page_CompareHistory"];
    }
    else if ([viewController isKindOfClass:[EtaoCategoryController class]]) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_ENTER arg1:@"Page_CategorySearch"];
    }
    else if ([viewController isKindOfClass:[ETaoSearchTopQueryController class]]) {
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_ENTER arg1:@"Page_Buzzword"];
    }
    else{
    
    }
}


 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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

@end
