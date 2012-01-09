//
//  etao4iphoneAppDelegate.m
//  etao4iphone
//
//  Created by zhangsuntai on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "etao4iphoneAppDelegate.h"
#import "EtaoSRPHomeController.h"
#import "NSDateCategories.h"
#import "EtaoSystemInfo.h"
#import "EtaoLocalViewController.h"
#import "HTTPImageView.h"
#import <AudioToolbox/AudioToolbox.h>
// TOP 用的 App Key 和 App Secret
// App Key：       12087020
// App Secret：    5bc157b61fc73636a7ff856d79bbb8a5
///*
#define TOP_APP_KEY         @"12087020"
#define TOP_APP_SECRET1     [NSData dataWithBytes:(uint8_t[]){0x7b, 0x7a, 0x1c, 0x41, 0x93, 0xbe, 0xf5, 0x29, 0x12, 0x4e, 0xec, 0xdb, 0xe8, 0x47, 0xef, 0x96, 0xab, 0x59, 0xe7, 0x78, 0x69, 0x27, 0xeb, 0xaa, 0xea, 0xd9, 0xcf, 0x41, 0x27, 0x1c, 0xff, 0xfb} length:32]
#define TOP_APP_SECRET2     [NSData dataWithBytes:(uint8_t[]){0x50, 0xb3, 0x05, 0x87, 0xe3, 0x36, 0xe0, 0x51, 0x53, 0x10, 0xb0, 0xf3, 0x18, 0x76, 0xbd, 0x01, 0x0d, 0x9c, 0x58, 0xf7, 0x77, 0xbd, 0xba, 0x94, 0x14, 0x30, 0xd2, 0xf0, 0x36, 0xd2, 0xc7, 0x08} length:32]
#define ALIPAY_CLIENT_SIGNATURE     @"tclient=iphone"



@implementation etao4iphoneAppDelegate

 
@synthesize window = _window;
@synthesize navigationController = _navigationController;
//@synthesize tabBarController;
@synthesize home = _home;
@synthesize etaoAuctionPriceCompareHistoryViewController = _etaoAuctionPriceCompareHistoryViewController;
@synthesize etaoHistoryViewController = _etaoHistoryViewController ;


#pragma mark -
#pragma mark Application lifecycle


- (void)setupUserTrack {
    // 设置自动跟踪页面访问，所有 UINavigationController 中的页面跳转都会被自动统计
    
    [TOP setWapTTID:__TTID__];
    [TBUserTrack setGlobalNavigationTrackEnabled:YES];
    
    //数据中心加载
    [[ETDataCenter dataCenter]load];
    
    CLLocation* location = [ETLocationDataSource getLocation];
    NSLog(@"status,%d",[ETLocation location].status);
    NSLog(@"opening! %f,%f",location.coordinate.latitude,location.coordinate.longitude);
    
    // 设置类名称到页面名称的映射，方便运营统计数据
    /*
     Page_Home,              //主界面
     Page_VersionInfo,       //设置说明界面（目前合在一起）
     Page_UserFeedBack,      //用户反馈
     
     //搜索输入法不占用界面。
     Page_ComparePrice,      //全网比价
     Page_GroupBuy,          //团购
     Page_ReartimePrice,     //实时降价
     Page_CompareHistory,    //比价历史列表
     Page_CategorySearch,    //类目搜索
     Page_SRP,               //搜索商品列表
     Page_CategoryFilter,    //类目筛选
     Page_Buzzword,          //热门词汇
     Page_ItemDetail,        //详情页
     Page_ItemMoreInfo,      //详细参数
     Page_ItemComment,       //用户评论
     Page_WapView,           //内嵌Wap页面
     Page_GroupBuyListMode,  //团购列表
     Page_GroupBuyMapMode,   //团购地图
     Page_GroupBuyDetail,    //团购详情
     Page_UpdateNotify       //升级提示
     */
    
    [TBUserTrack registerClassName:@"EtaoNewHomeViewController" toPage:@"Page_Home"];
    [TBUserTrack registerClassName:@"EtaoMoreViewController" toPage:@"Page_VersionInfo"];
    [TBUserTrack registerClassName:@"UserFeedBackByEmail" toPage:@"Page_UserFeedBack"];
    [TBUserTrack registerClassName:@"EtaoNewSearchHomeViewController" toPage:@"Page_ComparePrice"];
    [TBUserTrack registerClassName:@"EtaoLocalViewController" toPage:@"Page_GroupBuy"];
    [TBUserTrack registerClassName:@"EtaoPriceHomeViewController" toPage:@"Page_ReartimePrice"];
    [TBUserTrack registerClassName:@"ETaoHistoryViewController" toPage:@"Page_CompareHistory"];
    [TBUserTrack registerClassName:@"EtaoCategoryController" toPage:@"Page_CategorySearch"];
    [TBUserTrack registerClassName:@"EtaoSRPController" toPage:@"Page_SRP"];
    [TBUserTrack registerClassName:@"EtaoCategoryNavController" toPage:@"Page_CategoryFilter"];
    [TBUserTrack registerClassName:@"ETaoSearchTopQueryController" toPage:@"Page_Buzzword"];
    
    [TBUserTrack registerClassName:@"SearchDetailController" toPage:@"Page_ItemDetail"];
    [TBUserTrack registerClassName:@"SearchDetailParametersController" toPage:@"Page_ItemMoreInfo"];
    [TBUserTrack registerClassName:@"SearchEvaluateController" toPage:@"Page_ItemComment"];
    [TBUserTrack registerClassName:@"TBWebViewControll" toPage:@"Page_WapView"];
//  [TBUserTrack registerClassName:@"" toPage:@"Page_GroupBuyListMode"];
    [TBUserTrack registerClassName:@"EtaoLocalMapController" toPage:@"Page_GroupBuyMapMode"];
    [TBUserTrack registerClassName:@"EtaoLocalDiscountDetailController" toPage:@"Page_GroupBuyDetail"];
//  [TBUserTrack registerClassName:@"" toPage:@"Page_UpdateNotify"];
    
    [TBUserTrack registerClassName:@"EtaoPriceWaterfallController" toPage:@"Page_ReartimePriceWaterfallMode"];
    [TBUserTrack registerClassName:@"EtaoPriceSettingController" toPage:@"Page_ReartimeSetting"];
    [TBUserTrack registerClassName:@"EtaoPriceImageController" toPage:@"Page_ReartimePricePrice9squareMode"];//暂不使用
    [TBUserTrack registerClassName:@"EtaoPriceListController" toPage:@"Page_ReartimePriceListMode"];
    [TBUserTrack registerClassName:@"EtaoPriceDetailController" toPage:@"Page_ReartimePriceDetail"];
   
    [TBUserTrack registerClassName:@"EtaoUISearchDisplayController" toPage:@"Page_SearchInputPage"];
    
    //EtaoLocalClassifyView 团购页面的Button点击封装，属于Page_GroupBuy页面。
    [TBUserTrack registerClassName:@"EtaoLocalClassifyView" toPage:@"Page_GroupBuy"];
    //shopViewTouchController 属于实时降价页面，是下面的Bar。
    [TBUserTrack registerClassName:@"shopViewTouchController" toPage:@"Page_ReartimePriceDetail"];
   
    [TBUserTrack registerClassName:@"MFMailComposeRootViewController" toPage:@"Page_UserFeedBack"];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
   // AudioServicesPlaySystemSound(1301);
          
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    /*EtaoPageBaseCategoryController *cate =  [[[EtaoPageBaseCategoryController alloc]init]autorelease];
     
     EtaoPageBaseViewController *homeView = [[[EtaoPageBaseViewController alloc] initWithCategoryController:cate]autorelease];       
     
     NSMutableArray *rootArray = [NSMutableArray arrayWithCapacity:10];
     for (int i = 0 ; i < 10; i++) {
     [rootArray addObject:[[[RootViewController alloc]init]autorelease]];
     }
     
     EtaoPageBaseViewController *homeView1 = [[[EtaoPageBaseViewController alloc] initWithViewController:rootArray]autorelease];
     */
     
    self.etaoAuctionPriceCompareHistoryViewController = [[[EtaoAuctionPriceCompareHistoryViewController alloc]init]autorelease];
    
	_etaoAuctionPriceCompareHistoryViewController.managedObjectContext = self.managedObjectContext; 
    
    self.etaoHistoryViewController = [[[ETaoHistoryViewController alloc]init]autorelease];
    _etaoHistoryViewController.managedObjectContext = self.managedObjectContext;
    
    self.home = [[[EtaoNewHomeViewController alloc]init]autorelease];
    
    self.navigationController=[[[ETaoUINavigationController alloc]initWithRootViewController:_home andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease];       
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    [self setupUserTrack];
   
//    [self performSelector:@selector(test)];
//    [self performSelector:@selector(test) withObject:nil afterDelay:10.0];

    return YES;
    /*
    // Override point for customization after application launch.

	self.enterDataViewController.managedObjectContext = self.managedObjectContext;
	self.etaoAuctionPriceCompareHistoryViewController.managedObjectContext = self.managedObjectContext;

	self.tabBarController.delegate=self;
	// Set the tab bar controller as the window's root view controller and display.
    //self.window.rootViewController = self.tabBarController;
	// only for IOS4
	//self.window.rootViewController = self.tabBarController;
	// change like this
	[self.window addSubview:self.tabBarController.view]; 
	
    [self.window makeKeyAndVisible];
    
    
    //登陆用
    //[TOP setWapTTID:@"201200@taobao_iphone_1.7.0"];
    //[TOP setAlipayClientSignature:ALIPAY_CLIENT_SIGNATURE];
    //TBSetTOPAppKeyAndSecret(TOP_APP_KEY, TOP_APP_SECRET1, TOP_APP_SECRET2);

    return YES;
     */
}
 

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [NSURL fileURLWithPath:documentsDirectory];
    //return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
 
- (void)saveContext
{
	
    NSError *error = nil;
    NSManagedObjectContext *objectContext = self.managedObjectContext;
    if (objectContext != nil)
    {
        if ([objectContext hasChanges] && ![objectContext save:&error])
        {
            // add error handling here
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
	
    if (managedObjectContext_ != nil)
    {
        return managedObjectContext_;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel_ != nil)
    {
        return managedObjectModel_;
    }
    managedObjectModel_ = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	
    return managedObjectModel_;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	
    if (persistentStoreCoordinator_ != nil)
    {
        return persistentStoreCoordinator_;
    }
	
 	NSString *s = [[[self applicationDocumentsDirectory] absoluteString]stringByAppendingString:@"etao4iphone_history1.sqlite" ]; 
	NSURL *storeURL = [NSURL URLWithString:s]; 
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }  
	
    return persistentStoreCoordinator_;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	/*
	// 设置地图模式，为普通模式
	UIViewController *controll = (UIViewController*)[[[[self tabBarController] viewControllers] objectAtIndex: 2]topViewController]; 
	if ([ controll isKindOfClass:[EtaoLocalViewController class]] ) { 
		EtaoLocalViewController *local = (EtaoLocalViewController*)controll;
		if ( local.view != nil) {  
			if (local._hidden) {
				[local setHidden:YES];
			} 
		}  
	}
     */
    
    [[ETDataCenter dataCenter] save];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


//! 程序启动统计
- (void)statUserRunApp {
    static NSString *firstRunKey = @"user_has_first_run_preference";
    static NSString *lastRunKey = @"user_last_run_date_preference";
    NSDate *today = [NSDate dateFromString:[[NSDate date] stringWithFormat:@"yyyy-MM-dd"] withFormat:@"yyyy-MM-dd"];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:firstRunKey]) {
        [[EtaoSystemInfo sharedInstance] statUserAction:@"startup1"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:firstRunKey];
        [[NSUserDefaults standardUserDefaults] setObject:today forKey:lastRunKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        NSDate *lastRun = [[NSUserDefaults standardUserDefaults] objectForKey:lastRunKey];
        if (lastRun == nil || ![today isEqualToDate:lastRun]) {
            [[EtaoSystemInfo sharedInstance] statUserAction:@"startup"];
            [[NSUserDefaults standardUserDefaults] setObject:today forKey:lastRunKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //[self checkNewVersion];
        }
    }
}
 

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // 统计程序使用次数
    [self statUserRunApp]; 
    [_home checkPriceUpdate];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */

}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods
/*
 
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController1 didSelectViewController:(UIViewController *)viewController {
 	if ( tabBarController1.selectedIndex == 1 ) {
		// 再次点击tab，展现search，并focus在输入框上。
		if ([viewController isKindOfClass:[UINavigationController class]]) {
			UINavigationController *nav = (UINavigationController*) viewController;
			if ([[nav topViewController] isKindOfClass:[EtaoSRPHomeController class]]) {
				EtaoSRPHomeController * srp = (EtaoSRPHomeController *) [nav topViewController];
				[srp._textField becomeFirstResponder];
			}
		} 	  
	}  
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/
 

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    
	[managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
	[_etaoAuctionPriceCompareHistoryViewController release];
    [_etaoHistoryViewController release];
    [_navigationController release];
    [_home release];
    [_window release];
    [super dealloc];
}



@end

