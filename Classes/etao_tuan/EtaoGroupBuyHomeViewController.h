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
#import "EtaoTuanCityController.h"
#import "ETaoUINavigationController.h"
#import "ETPageSlideController.h"
#import "EtaoGroupBuyMapViewController.h"
#import "EtaoTimerController.h"

#ifndef MAP_HEIGHT
#define MAP_HEIGHT 252
#endif
@interface EtaoTuanHomeViewController : UIViewController<ETPageSlideDelegate,ETPageTouchDelegate> {
    
    ETPageSlideController* _slideView;
    int _currentPage;
    
    EtaoGroupBuyMapViewController* _mapView;
    
    EtaoTuanSettingController* _settingBySlide;
    EtaoTuanSettingController* _settingByTouch;
    EtaoTuanSettingDataSource* _settingDataSource;    
    
    NSMutableArray* _cells;
    NSMutableDictionary* _datasourceCache;
    
    EtaoTuanCityController* _cityView;
    
}

@property(nonatomic, retain) NSMutableArray* cells;
@property(nonatomic, retain) EtaoTuanCityController *cityView;
@property(nonatomic, retain) ETPageSlideController *slideView;
@property(nonatomic, retain) EtaoGroupBuyMapViewController* mapView;

- (void)reloadPage;
+ (ETaoUINavigationController*)getNavgationController;

@end
