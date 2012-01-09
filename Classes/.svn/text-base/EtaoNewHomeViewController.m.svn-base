//
//  EtaoNewHomeViewController.m
//  etaoetao
//
//  Created by GuanYuhong on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoNewHomeViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoPageBaseViewController.h"
#import "EtaoPageBaseCategoryController.h"
#import "ETaoUINavigationController.h"
#import "RootViewController.h"
#import "EtaoHomeViewController.h"
#import "EtaoLocalViewController.h"
#import "EtaoSRPHomeController.h"
#import "EtaoSRPController.h"
#import "EtaoNewSearchHomeViewController.h"
#import "EtaoPriceHomeViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "UpdateSession.h"
#import "EtaoMoreViewController.h" 
#import "ETaoHelpView.h"
#import "EtaoTuanHomeViewController.h"
#import "ETBannerController.h"
#import "ETFirstInAlertViewController.h"
#import "EtaoAuctionSRPTableViewController.h"


@interface EtaoNewHomeViewController()<UITableViewDelegate, UITableViewDataSource> {
    
    UITableView* _activeBannerTableView;
    UIScrollView* _shortcutScrollview;
    ETBannerController* _bannerController;
    float bannetOffset;
    bool arrowDown;
    UIView* _bannerTopMaskView;
}

-(BOOL) showFirstInAlert;
@end

@implementation EtaoNewHomeViewController

@synthesize etaoUISearchDisplayController = _etaoUISearchDisplayController;
@synthesize textField = _textField;
@synthesize tableview = _tableview;
@synthesize navBar = _navBar; 
@synthesize navItems = _navItems; 
@synthesize priceDownRequest = _priceDownRequest;
@synthesize updateSession = _updateSession;
@synthesize priceDownRequestArray = _priceDownRequestArray ;
@synthesize bubbleView = _bubbleView;
@synthesize CheckCnt,priceTotalCnt,NowCheckCnt;
@synthesize navPrice = _navPrice,navTuan = _navTuan, navB2C = _navB2C ;
@synthesize tuanHome = _tuanHome ,searchHome = _searchHome ,priceHome = _priceHome ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) hi {
    EtaoPageBaseCategoryController *cate =  [[[EtaoPageBaseCategoryController alloc]init]autorelease];
    
    EtaoPageBaseViewController *homeView = [[[EtaoPageBaseViewController alloc] initWithCategoryController:cate]autorelease];       
     
    ETaoUINavigationController *nav =[[[ETaoUINavigationController alloc]initWithRootViewController:homeView andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
    
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:nav animated:YES]; 
}


- (void) hi:(UIButton*)sender {
    if ( [sender.titleLabel.text isEqualToString:@"实时降价"]) {
        [_bubbleView setNumber:0];       
      //  if (_priceHome == nil) {
        EtaoPriceMainViewController* priceHome = [[[EtaoPriceMainViewController alloc] init]autorelease]; ;
      //  }
        ETaoUINavigationController* nav =[[[ETaoUINavigationController alloc]initWithRootViewController:priceHome andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
        nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

        [self presentModalViewController:nav animated:YES];  
       // [self.navigationController pushViewController:homeView animated:YES];
        
        EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:_priceHome action:@selector(UIBarButtonHomeClick:)]autorelease];      
        _priceHome.navigationItem.leftBarButtonItem = home;
        
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ReartimePrice"];
    }
    else if ( [sender.titleLabel.text isEqualToString:@"全网比价"]) {         
         
      //  if (_searchHome == nil) {
            self.searchHome = [[[EtaoNewSearchHomeViewController alloc]init]autorelease];
     //   } 
        ETaoUINavigationController *nav =[[[ETaoUINavigationController alloc]initWithRootViewController:_searchHome andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease];  
        nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:nav animated:YES];
      //  [self.navigationController pushViewController:home animated:YES];
        EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:_searchHome action:@selector(UIBarButtonItemHomeClick:)]autorelease];      
        _searchHome.navigationItem.leftBarButtonItem = home;
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ComparePrice"];
    }
    else if ( [sender.titleLabel.text isEqualToString:@"附近团购"]) {
      //  if (_tuanHome == nil) {
        EtaoTuanHomeViewController* tuanHome = [[[EtaoTuanHomeViewController alloc]init]autorelease];
      //  } 
        ETaoUINavigationController* nav =[[[ETaoUINavigationController alloc]initWithRootViewController:tuanHome andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease];  
        nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:nav animated:YES];
       // [self.navigationController pushViewController:tuan animated:YES];
        
        EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:_tuanHome action:@selector(UIBarButtonHomeClick:)]autorelease];      
        _tuanHome.navigationItem.leftBarButtonItem = home;
        
        [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-GroupBuy"];
    }
    else{
        
    }
}


- (UIView*) getTypeButtonAt:(int)pos withImage:(UIImage*)image withTitle:(NSString*)title{ 
    
    UIButton *btn = [[[UIButton alloc] initWithFrame:CGRectMake(97*pos, 2, 100, 100)]autorelease]; 
    [btn setImage:image forState:UIControlStateNormal]; 
    [btn setTitle:title forState:UIControlStateNormal]; 
   // [btn setBackgroundImage:[EtaoUIBarButtonItem imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted]; 
    
    [btn setTitleColor:[UIColor colorWithRed:136/255.0f green:142/255.0f blue:160/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]]; 
    
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // get the size of the elements here for readability
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size; 
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    // raise the image and push it right to center it
    btn.imageEdgeInsets = UIEdgeInsetsMake( 15.0, 23.0, 40.0, 26.0);
    // lower the text and push it left to center it
    btn.titleEdgeInsets = UIEdgeInsetsMake( 0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0 );
    
    [btn addTarget:self action:@selector(hi:) forControlEvents:UIControlEventTouchUpInside];
    return btn;     
}


-(void)isVersionIsLatest {
    if(nil == _updateSession) {
        UpdateSession* upSession = [[UpdateSession alloc] init];
        self.updateSession = upSession;
        self.updateSession.sessionDelegate = self;
        [upSession release];
    }
    
    [self retain];
    [self.updateSession requestUpdateDate];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0f, 176.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    
    [super loadView];
    
    self.title = @"一淘";
    [self.navigationController setNavigationBarHidden:YES animated:NO]; 
    
    UIImage* imgTopBack = [self imageWithColor:[UIColor colorWithRed:245/255.0f green:247/255.0f blue:248/255.0f alpha:1.0]];
    UIImageView* imgTopBackView = [[UIImageView alloc] initWithImage:imgTopBack];
    [self.view addSubview:imgTopBackView];
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:247/255.0f blue:248/255.0f alpha:1.0]];
    
    self.navBar = [[[UINavigationBar alloc] initWithFrame: CGRectMake(0,132,self.view.frame.size.width,44)]autorelease];
    _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   
    if([_navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        UIImage *image = [EtaoUIBarButtonItem imageWithColor:[UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]];
        [_navBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    }  
    
    self.navItems = [[[UINavigationItem alloc]initWithTitle:@"etao"]autorelease];
    
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 30.0f)]autorelease]; 
    
    _navItems.titleView = _textField; 
    
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0, 176.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain]autorelease];
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableview.autoresizesSubviews = YES; 
    [self.view addSubview:_tableview];
    
    self.etaoUISearchDisplayController = [[[EtaoUISearchDisplayController alloc]initWithTextField:_textField
                                                                                        tableView:_tableview  
                                                                                          NavItem: _navItems
                                                                                 withSearchButton:NO]
                                          autorelease];
    
    _etaoUISearchDisplayController.delegate = self;
    [_navBar pushNavigationItem:_navItems animated:YES]  ;
    [self.view addSubview:_navBar]; 
    
    UIView *tmp = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 176.0f , 320.f, 284.0f)]autorelease];
    tmp.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homepageback.png"]];
    [self.view addSubview:tmp];
    
    
    //Path效果的Banner
    if (nil == _activeBannerTableView) {
        _activeBannerTableView = [[UITableView alloc]init];
        [_activeBannerTableView setDelegate:self];
        [_activeBannerTableView setDataSource:self];
        [_activeBannerTableView setBackgroundColor:[UIColor clearColor]];
        [_activeBannerTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_activeBannerTableView setFrame:CGRectMake(0, 176, 320, 480)];
        [_activeBannerTableView setContentSize:CGSizeMake(320, 300)];
        [self.view addSubview:_activeBannerTableView];
        
        bannetOffset = 0;
        
        _activeBannerTableView.contentInset = UIEdgeInsetsMake(2.0f, 0.0f, 0.0f, 0.0f);
    }
   
    if (nil == _bannerController) {
        _bannerController = [[ETBannerController alloc] init];
        [_bannerController.view setFrame:CGRectMake(0, 46, 320, 130)];
        _bannerController.superDelegate = self;
        [self.view addSubview:_bannerController.view];
    }
    
    if (nil == _bannerTopMaskView) {
        _bannerTopMaskView = [[UIImageView alloc] init];
        [_bannerTopMaskView setFrame:CGRectMake(0, 176, 320, 20)];
        [_bannerTopMaskView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homepageback.png"]]];
        [self.view addSubview:_bannerTopMaskView];
        
        self.bubbleView = [[[EtaoHomePriceUpdateBubbleView alloc]initWithFrame:CGRectMake(262-15.0f, 0 , 32.f, 23.0f)]autorelease];
        [_bannerTopMaskView addSubview:_bubbleView];
        
        _bannerTopMaskView.userInteractionEnabled = NO;
    }
    
    [self.view bringSubviewToFront:imgTopBackView];
    
    UIImageView *etaoIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_icon.png"]]autorelease];
    etaoIcon.frame = CGRectMake(110, 68.0f, 91.0f, 42.0f);
    [self.view addSubview:etaoIcon];
    
    [self.view bringSubviewToFront:_navBar];
    
    UIImageView *homeinfo = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeInfo.png"]]autorelease];
    [homeinfo setFrame:CGRectMake(288.0f, 2.0f , 30.f, 30.0f)];
    
    homeinfo.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToPageMore)];
    [homeinfo addGestureRecognizer:singleTap];
    [singleTap release];
    
    [self.view addSubview:homeinfo];
    
    if (nil == _shortcutScrollview) {
        _shortcutScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(15.0f, 0, 290.0, 115.0f)];
        //[_shortcutScrollview setBounds:CGRectMake(15.0f, 0, 290.0f, 115.0f)];
        [_shortcutScrollview addSubview:[self getTypeButtonAt:0 withImage:[UIImage imageNamed:@"decider_icon.png"] withTitle:@"全网比价"]];
        [_shortcutScrollview addSubview:[self getTypeButtonAt:1 withImage:[UIImage imageNamed:@"tuangou_icon.png"] withTitle:@"附近团购"]];
        [_shortcutScrollview addSubview:[self getTypeButtonAt:2 withImage:[UIImage imageNamed:@"jiangjia_icon.png"] withTitle:@"实时降价"]];
    }    
    _shortcutScrollview.showsHorizontalScrollIndicator = NO;//YES;
    _shortcutScrollview.showsVerticalScrollIndicator = NO; 
    _shortcutScrollview.scrollEnabled = NO;
    CGSize newSize = CGSizeMake(self.view.frame.size.width, _shortcutScrollview.frame.size.height);
    [_shortcutScrollview setContentSize:newSize];
    [_shortcutScrollview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homepageback.png"]]];

    
    //////////////test
//    [_bannerController.view setFrame:CGRectMake(0, -100, 320, 100)];
//    [_activeBannerTableView addSubview:_bannerController.view];
    //[self.view bringSubviewToFront:_navBar];
    
    [self showFirstInAlert];
}


- (void) viewDidLoad {
    
    [_bubbleView  setNumber:0];
    //版本检测 50%几率检测提示
    int value = (arc4random()%2);
    if (value == 1) {
        [self isVersionIsLatest];
    }
    
    //for 气泡
    _settingDataSource = [[EtaoPriceSettingDataSource alloc]init];
    [_settingDataSource load];
    
    [super viewDidLoad];
}


- (void) jumpToPageMore {
 
    EtaoMoreViewController *more = [[[EtaoMoreViewController alloc] init]autorelease];    
    [self.navigationController pushViewController:more animated:YES];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-MoreInfo"];
}


- (void) checkPriceUpdate {
    
    NSString* datasource_key = [EtaoPriceBuyAuctionDataSource keyName:@"全部"];
    if(![[ETDataCenter dataCenter]isExist:datasource_key]){
        EtaoPriceBuyAuctionDataSource* datasource = (EtaoPriceBuyAuctionDataSource*)[[ETDataCenter dataCenter]getDataSourceWithKey:[EtaoPriceBuyAuctionDataSource keyName:@"全部"]];
        [datasource addObserver:self 
                     forKeyPath:@"status" 
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                        context:nil];
        [datasource loadUpdate];
    }
}

#pragma mark -v datasource event respond function
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([object isKindOfClass:[EtaoPriceBuyAuctionDataSource class]]){
        EtaoPriceBuyAuctionDataSource* datasource = object;
        ET_DS_PRICEBUY_AUCTION_STATUS status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case ET_DS_PRICEBUY_AUCTION_UPDATE:
                [_bubbleView setNumber:[datasource.updateNumber intValue]];
                [datasource removeObserver:self forKeyPath:@"status"];
                break;
            default:
                break;
        }
    }
}





- (void) textStop{ 

  //  navItems.rightBarButtonItem = self.searchbtn; 
    
}


- (void)textFieldInputDidCancel:(NSString*)text {
    if (_navBar.frame.origin.y > 0) {
        return ;
    }  
    _textField.frame = CGRectMake(0.0f, 0.0f, 320.0f, 30.0f);
    [self.view sendSubviewToBack:_tableview]; 
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];   
    for (UIView *view in self.view.subviews ) {
        view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y + 132,view.frame.size.width,view.frame.size.height);
    }  
	[UIView commitAnimations];
}


- (void)textFieldWordSelected:(NSString*)text {
    
    if (text == nil || [text isEqualToString:@""]) {
        return ;
    }
    
    EtaoAuctionSRPTableViewController * srp = [[[EtaoAuctionSRPTableViewController alloc] init]autorelease]; 
	srp.keyword = text ;
	[srp search: srp.keyword];     
      
    
    ETaoUINavigationController *srpnav =[[[ETaoUINavigationController alloc]initWithRootViewController:srp andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease];  
   
    // initWithRootViewController 貌似包含了一次push操作，因此需要在init之后，重新设置home返回按钮
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:srp action:@selector(UIBarButtonItemHomeClick:)]autorelease];
    home.title = @"gohome"; 
    srp.navigationItem.leftBarButtonItem = home; 
    
    srpnav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:srpnav animated:YES];
    

    
    NSLog(@"srpnav=%d",[srpnav retainCount]);
    if (_navBar.frame.origin.y > 0) {
        return ;
    } 
    
    _textField.frame = CGRectMake(0.0f, 0.0f, 320.0f, 30.0f);
    [self.view sendSubviewToBack:_tableview]; 
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];   
    for (UIView *view in self.view.subviews ) {
        view.frame = CGRectMake(0,view.frame.origin.y + 132,view.frame.size.width,view.frame.size.height);
    }  
	[UIView commitAnimations];
}


- (void)textFieldInputDidStart:(NSString*)text { 
    if (_navBar.frame.origin.y == 0) {
        return ;
    }     
    [self.view bringSubviewToFront:_tableview]; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; 
    [UIView setAnimationDidStopSelector:@selector(textStop)];
    [UIView setAnimationDelegate:self];
    for (UIView *view in self.view.subviews ) {
        view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y - 132,view.frame.size.width,view.frame.size.height);
    }  

    
	[UIView commitAnimations];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Search"];
}


- (void)textFieldInputDidEnd:(NSString*)text {
    [_textField resignFirstResponder];
    
    if (text == nil || [text isEqualToString:@""]) {
        return ;
    }
    
    
    EtaoAuctionSRPTableViewController * srp = [[[EtaoAuctionSRPTableViewController alloc] init]autorelease]; 
	srp.keyword = text ;
	[srp search: srp.keyword];      
    
    
    ETaoUINavigationController *srpnav =[[[ETaoUINavigationController alloc]initWithRootViewController:srp andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease];  
    
    // initWithRootViewController 貌似包含了一次push操作，因此需要在init之后，重新设置home返回按钮
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:srp action:@selector(UIBarButtonItemHomeClick:)]autorelease];
    home.title = @"gohome"; 
    srp.navigationItem.leftBarButtonItem = home; 
    
    srpnav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    NSLog(@"srpnav=%d",[srpnav retainCount]);
    [self presentModalViewController:srpnav animated:YES];
    NSLog(@"srpnav=%d",[srpnav retainCount]);
    //设置navigationController 阴影
    CALayer *navLayer = srpnav.navigationBar.layer;  
    [navLayer setMasksToBounds:YES];
    [navLayer setCornerRadius:4.0];
    navLayer.masksToBounds = NO;    
    navLayer.shadowColor = [UIColor blackColor].CGColor;    
    navLayer.shadowOffset = CGSizeMake(0.0, 2.0);    
    navLayer.shadowOpacity = 0.16f;    
    navLayer.shouldRasterize = YES;    
    CALayer *la = srpnav.view.layer;
    la.masksToBounds = NO;    
    la.shadowColor = [UIColor blackColor].CGColor;    
    la.shadowOffset = CGSizeMake(10.0, 0.0);    
    la.shadowOpacity = 0.16f;    
    la.shouldRasterize = YES;
    [la setBorderColor:[UIColor grayColor].CGColor];
    [la setBorderWidth:1.6];

    if (_navBar.frame.origin.y > 0) {
        return ;
    } 
    
    _textField.frame = CGRectMake(0.0f, 0.0f, 320.0f, 30.0f);
    [self.view sendSubviewToBack:_tableview]; 
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];   
    
    for (UIView *view in self.view.subviews ) {
        view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y + 132,view.frame.size.width,view.frame.size.height);
    }  
	[UIView commitAnimations];
      
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload {

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) UpdateRequestDidFailed:(NSObject *)obg {
    [self release];
    //    
    //    [EtaoShowAlert showAlert];
    //    
    //    [self showAlert:@"FAILED"];
}


-(void) showAlert:(NSString*) msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:msg
                                                   delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
    alert.delegate = self;
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView buttonTitleAtIndex:buttonIndex] == @"立即更新") {
        
        NSString* updateUrl;
        if(nil == _updateSession.UpdateProtocal.updateUrl) {
            updateUrl = _updateSession.UpdateProtocal.updateUrl;
        }
        else {
            updateUrl = @"http://itunes.apple.com/app/id451400917?mt=8";
        }
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateSession.UpdateProtocal.updateUrl]];
    }
}


- (void) UpdateRequestDidFinish:(NSObject *)obj {
    [self release];
    
    if (_updateSession.UpdateProtocal.isHaveNewVersion == YES) {
        [self showAlert:_updateSession.UpdateProtocal.versionDesc];
    }
    //    else {
    //        [self showAlert:@"您已经是最新的版本了，亲！"];
    //    }
}


- (void)alertViewCancel:(UIAlertView *)alertView {
    NSLog(@"url == ...alertViewCancel..alertViewCancel..alertViewCancel..");
}


- (void)finishedDispaly {
    
}


//关于新版本的提示
-(BOOL) showFirstInAlert{
    
    if ([ETFirstInAlertViewController isFirstShow] == NO) {
        return NO;
    }
    
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<4; i++) {
        ETFirstInAlertItem* tempItem = [ETFirstInAlertItem alloc];
        NSString* tempStr = [NSString stringWithFormat:@"FirstInAlertImg_%d.png",i];
        tempItem.imgName = tempStr;
        [tempArray addObject:tempItem];
        [tempItem release];
    }
    
    ETFirstInAlertViewController* firstInController = [[[ETFirstInAlertViewController alloc]initWithArray:tempArray]autorelease];
    firstInController.delegate = self;
    [self.navigationController pushViewController:firstInController animated:YES];
   
    return YES;

}


- (void) dealloc {
    _tableview.delegate = nil ;
    _tableview.dataSource = nil;
    
    [_bannerTopMaskView release];
    [_bannerController release];
    [_searchHome release];
    [_priceHome release];
    [_tuanHome release];

    [_activeBannerTableView release];
    [_shortcutScrollview release];
    
    [_textField release]; 
    [_tableview release];
    [_etaoUISearchDisplayController release];
    
    [super dealloc];
}

























- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    if( tableView == _activeBannerTableView ) {
        return 1;//2;
    }
    
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
//        return _bannerController.view.bounds.size.height-bannetOffset;
//    }
//    else if (indexPath.section == 1) {
        return _shortcutScrollview.bounds.size.height;
	}
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 	return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    //NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d%d",indexPath.section, indexPath.row];	
    
    if (indexPath.section == 0) {
        
//        UITableViewCell * cell = [_activeBannerTableView dequeueReusableCellWithIdentifier:@"BANNERVIEW"];
//        if (cell == nil) {
//            cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BANNERVIEW"] autorelease];
//            [cell addSubview:_bannerController.view];
//        
//            //close button
//            UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            [closeButton setFrame:CGRectMake(280, 0, 40, 40)];
//            [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [closeButton setImage:[UIImage imageNamed:@"star01"] forState:UIControlStateNormal];
//            [cell addSubview:closeButton];
//            
//            [cell setBackgroundColor:[UIColor redColor]]; 
//        }
//        return cell;
//    }
//    else if (indexPath.section == 1) {
        UITableViewCell * cell = [_activeBannerTableView dequeueReusableCellWithIdentifier:@"SHORTCUTSCROLLVIEW"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SHORTCUTSCROLLVIEW"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell addSubview:_shortcutScrollview];
            
            UIView *backTopShadow = [[[UIView alloc] initWithFrame:CGRectMake(0, 0 , 320.f, 1.0f)]autorelease];
            [cell addSubview:backTopShadow];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homepageback.png"]];
            
            [self.view bringSubviewToFront:cell];
        }
        return cell;
    }
    
    return nil;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentInset.top <= 10) {
        if ([scrollView contentOffset].y < -40) {
            //[_activeBannerTableView setFrame:CGRectMake(0, 182, _activeBannerTableView.bounds.size.width, _activeBannerTableView.bounds.size.height)];
            //scrollView.contentInset = UIEdgeInsetsMake(100.0f, 0.0f, 0.0f, 0.0f);
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            
//            [UIView setAnimationDelegate:self];
//            [UIView setAnimationDidStopSelector:@selector(showButtonAnim)];
            scrollView.contentInset = UIEdgeInsetsMake(100.0f, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
        }
    } else if (scrollView.contentInset.top == 100) {
        if ([scrollView contentOffset].y > -60) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
        }
    } 
    
    NSLog(@"scrollViewDidEndDragging");
}


//- (void)showButtonAnim {
//     arrowDown = YES;
//}


// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating


- (void)scrollViewDidScroll:(UIScrollView *)scrollView { 
    
//    if (arrowDown) {
//        return;
//    }
//    arrowDown = NO;
//    if (_activeBannerTableView.contentInset.top < 100) {
//        arrowDown = YES;
//    }
    
//    if (arrowDown && _activeBannerTableView.contentInset.top == 100 ) {
//        [_activeBannerTableView setFrame:CGRectMake(0, 276, 320, 480)];
//        [_activeBannerTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
//        arrowDown = NO;
//    }
   
    bannetOffset = [scrollView contentOffset].y;// + _bannerController.view.frame.origin.y-176;
    
    if (bannetOffset >= -100) {

        [_bannerController setBannerBoundRect:CGRectMake(_bannerController.view.bounds.origin.x, 46-bannetOffset, _bannerController.view.bounds.size.width, 
                                                         _bannerController.view.bounds.size.height)];
    }
    else if(bannetOffset >= -150) {
        
        float temp = 146-(100+bannetOffset)/2;
        if (temp > 176) {
            temp = 176;
        }
        
        [_bannerController setBannerBoundRect:CGRectMake(_bannerController.view.bounds.origin.x, temp, 
                                                         _bannerController.view.bounds.size.width, 
                                                         _bannerController.view.bounds.size.height)];//100-(bannetOffset+100))];
    }else {
        [_bannerController setBannerBoundRect:CGRectMake(_bannerController.view.bounds.origin.x, 76-bannetOffset-50, _bannerController.view.bounds.size.width, 
                                                         _bannerController.view.bounds.size.height)];//100+50)];
    }
    
    [_bannerTopMaskView setFrame:CGRectMake(0, 176-bannetOffset, 320, 20)];
    
    
//        [_bannerController setBannerBoundRect:CGRectMake(_bannerController.view.bounds.origin.x, (tempfloat-100)-(bannetOffset+100)/2, _bannerController.view.bounds.size.width, tempfloat-(bannetOffset+100)/2)];
    
    
//        NSString* tempstr = 
//        [NSString stringWithFormat:@"..%f,%f,%f,%f",
//         scrollView.contentInset.top,
//         bannetOffset,
//         76-bannetOffset,
//         _bannerController.view.bounds.size.height];
//        NSLog(tempstr, nil);
    
    //}
    
}   



@end
