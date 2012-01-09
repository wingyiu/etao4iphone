//
//  EtaoTuanSettingController.h
//  etao4iphone
//
//  Created by  on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPageSlideController.h"
#import "EtaoTuanSettingController.h"
#import "EtaoTuanNavTitleView.h"
#import "EtaoTuanMapController.h"
#import "EtaoTuanCityController.h"
#import "ETaoUINavigationController.h"
#import "ETPageSlideController.h"
#import "EtaoTimerController.h"
#import "ETDataCenter.h"
#import "EtaoGroupBuySettingDataSource.h"
#import "EtaoGroupBuyLocationDataSource.h"


#ifndef MAP_HEIGHT
#define MAP_HEIGHT 252
#endif
@interface EtaoTuanHomeViewController : UIViewController<ETPageSlideDelegate,ETPageTouchDelegate> {
    
    ETPageSlideController* _slideView;
    int _currentPage;
    
    EtaoTuanNavTitleView* _cityButton;
    EtaoTuanCityController* _cityView;
    EtaoTuanMapController* _mapView;
    
    EtaoTuanSettingController* _settingBySlide;
    EtaoTuanSettingController* _settingByTouch;
    EtaoGroupBuySettingDataSource* _settingDataSource;   
    
    EtaoGroupBuyLocationDataSource* _locationDataSource;
    
    NSMutableArray* _cells;
    
    BOOL _isMap;

}
@property (nonatomic,retain) NSMutableArray* cells;

- (void)cityButtonClick:(id)sender;

- (void)appearMap;
- (void)disappearMap;

- (void)appearSetting;
- (void)disappearSetting;

- (void)showMapButton;
- (void)showListButton;
- (void)showDoneButton;

- (void)reloadPage;
+ (ETaoUINavigationController*)getNavgationController;



@end
