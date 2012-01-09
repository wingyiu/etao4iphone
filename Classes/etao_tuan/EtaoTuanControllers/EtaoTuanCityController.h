//
//  EtaoCityPageSlideController.h
//  etao4iphone
//
//  Created by  on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoUIViewController.h"
#import "ETaoUITableViewController.h"
#import "ETPageTouchView.h"
#import "EtaoTuanNavTitleView.h"

@interface EtaoTuanCityController : UIViewController <UITableViewDelegate, ETPageTouchDelegate,UITableViewDataSource ,UIAlertViewDelegate>{

    
    UITableView *_cityTableView;
    UILabel *localLabel;
    
    NSMutableDictionary *_cities;
    NSArray *_keys;
    NSMutableArray *_citiesSort;
    NSMutableDictionary *_citiesSortRow;
    NSMutableArray *_citiesHot;
    NSMutableDictionary *_citiesHotRow;
    NSMutableArray *_titleForSection;
    
    UILabel *characterLabel;
    
    NSMutableDictionary *_LatitudeAndLongtitude;
    
    BOOL _need;
    
    CLLocationCoordinate2D _userLocationCoordinate;
    
    NSString* _userLocationName;
    NSString* _userLocationCity;
    
    int _character_num;

    BOOL _isCheck;
    
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic, retain)NSArray *keys;
@property (nonatomic, retain)NSMutableDictionary *cities;
@property (nonatomic, retain)NSMutableArray *citiesSort;
@property (nonatomic, retain)NSMutableArray *citiesHot;
@property (nonatomic, retain)NSMutableArray *titleForSection;
@property (nonatomic, retain)UITableView *cityTableView;
@property (nonatomic, retain)NSMutableDictionary *citiesSortRow;
@property (nonatomic, retain)NSMutableDictionary *citiesHotRow;

/* 监视函数 */
- (void)watchWithDatasource:(id)datasource;
- (void)watchWithKey:(NSString*)key;


-(void)setViewHot:(UITableViewCell *)cell;
-(void)setViewNorm:(UITableViewCell *)cell inPath:(NSIndexPath *)indexPath;

-(void)btnClick: (UIButton *)btn;

-(CLLocationCoordinate2D )getLatitudeAndLongitude:(NSString *)cityName;

- (void)check;

@end
