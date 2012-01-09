//
//  EtaoNewHomeViewController.h
//  etaoetao
//
//  Created by GuanYuhong on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoUISearchDisplayController.h"
#import "EtaoPriceAuctionDataSource.h"
#import "EtaoHomePriceUpdateBubbleView.h"
#import "UpdateSessionDelegate.h"
#import "ETaoUIViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoPageBaseViewController.h"
#import "EtaoPageBaseCategoryController.h"
//#import "ETaoUINavigationController.h"
#import "RootViewController.h"
#import "EtaoHomeViewController.h"
#import "EtaoLocalViewController.h"
#import "EtaoSRPHomeController.h"
#import "EtaoSRPController.h"
#import "EtaoNewSearchHomeViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "UpdateSession.h"
#import "EtaoMoreViewController.h" 
#import "ETaoHelpView.h"
#import "EtaoPriceMainViewController.h"
#import "EtaoPriceSettingDataSource.h"
#import "EtaoPriceMainViewController.h"
#import "EtaoNewSearchHomeViewController.h"
#import "ETFirstAlertDelegate.h"


@class UpdateSession;

@interface EtaoNewHomeViewController : ETaoUIViewController <EtaoUISearchDisplayControllerDelegate, EtaoPriceAuctionDataSourceDelegate, UpdateSessionDelegate, ETFirstAlertDelegate>{

    EtaoUISearchDisplayController *_etaoUISearchDisplayController;
    UITextField *_textField;
    UITableView *_tableview; 
    UINavigationBar *_navBar;
    UINavigationItem *_navItems;
    
    //实时降价气泡 
    EtaoHomePriceUpdateBubbleView * _bubbleView;
    
    EtaoPriceAuctionDataSource* _auctionDataSource;
    EtaoPriceSettingDataSource* _settingDataSource;
    
    int CheckCnt;
    int NowCheckCnt;
    int priceTotalCnt;
    
    UpdateSession* _updateSession;

    ETaoUINavigationController *_nav;
}

@property (nonatomic,retain)  ETaoUINavigationController *navB2C;
@property (nonatomic,retain)  ETaoUINavigationController *navTuan;
@property (nonatomic,retain)  ETaoUINavigationController *navPrice;

@property (nonatomic,retain)  EtaoTuanHomeViewController *tuanHome;
@property (nonatomic,retain)  EtaoPriceMainViewController *priceHome;
@property (nonatomic,retain)  EtaoNewSearchHomeViewController *searchHome;

@property (nonatomic ,retain) EtaoUISearchDisplayController *etaoUISearchDisplayController;
@property (nonatomic ,retain) UITextField *textField;
@property (nonatomic ,retain) UITableView *tableview; 
@property (nonatomic ,retain) UINavigationBar *navBar;
@property (nonatomic ,retain) UINavigationItem *navItems; 
@property (nonatomic, retain) EtaoPriceAuctionDataSource* priceDownRequest;
@property (nonatomic, retain) NSMutableArray * priceDownRequestArray;
@property (nonatomic, retain) UpdateSession* updateSession;
@property (nonatomic, retain) EtaoHomePriceUpdateBubbleView * bubbleView;

@property int CheckCnt;
@property int NowCheckCnt;
@property int priceTotalCnt;

- (void) checkPriceUpdate ;

@end

