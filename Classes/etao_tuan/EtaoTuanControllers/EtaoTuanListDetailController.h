//
//  EtaoTuanListDetailController.h
//  etao4iphone
//
//  Created by  on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "ETaoUITableViewController.h"
#import "EtaoTuanAuctionItem.h"
#import "ETDetailSwipeController.h"
#import "ETPageSwipeDelegate.h"

@interface EtaoTuanListDetailController : UIViewController <UIActionSheetDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate,UITableViewDelegate, UITableViewDataSource,ETPageSwipeDetailDelegate>{
    
    EtaoTuanAuctionItem *_item;
    
    CLLocationCoordinate2D _userLocation;
    
    UILabel *_timeLabel;
    
    //MKReverseGeocoder *geocoder;
    
    UITableView* _tableView;
}

@property (nonatomic, retain) EtaoTuanAuctionItem* item;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;


-(void)item2cell:(EtaoTuanAuctionItem *)item toCell:(UITableViewCell *)cell inPath: (NSIndexPath *)indexPath;
- (void)actionPhone;
- (void)showTheWay;
- (void)loadFoot;
@end
