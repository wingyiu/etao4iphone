//
//  EtaoPriceMainViewController.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETaoUINavigationController.h"
#import "EtaoPriceSettingController.h"
#import "ETPageSlideDelegate.h"
#import "ETPageSlideController.h"
#import "EtaoPriceAuctionItem.h"
#import "EtaoPricebuyAuctionDataSource.h"
#import "EtaoPriceListController.h"
#import "EtaoPriceWaterfallController.h"
#import "EtaoPricePubuliuController.h"
#import "EtaoUISearchDisplayController.h"

@interface EtaoPriceMainViewController : UIViewController <ETPageSlideDelegate,ETPageTouchDelegate,EtaoUISearchDisplayControllerDelegate>
{
    ETPageSlideController* _mainView;
    EtaoPriceSettingController* _settingBySlide;
    EtaoPriceSettingController* _settingByTouch;
    EtaoPriceBuySettingDataSource* _settingDataSource;
    int _currentPage;
    
    NSMutableArray* _cells;
    
    BOOL _isWaterFall;
    
    EtaoUISearchDisplayController *_etaoUISearchDisplayController;
    UITextField *_textField;
    UITableView *_tableview; 

}
@property(nonatomic,retain) NSMutableArray* cells;

+ (ETaoUINavigationController*)getNavgationController;

- (void)appearSetting;
- (void)disappearSetting;

- (void)showImageButton;
- (void)showListButton;
- (void)showDoneButton;

@end
