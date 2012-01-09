//
//  EtaoLocalDiscountDetailController.h
//  etao4iphone
//
//  Created by zhangsuntai on 11-8-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>  
#import "EtaoLocalDiscountItem.h"  
#import "ETaoUIViewController.h"
@interface EtaoLocalDiscountDetailController : ETaoUIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>{
 
	EtaoLocalDiscountItem *item;
	CLLocationCoordinate2D *from;
	CLLocationCoordinate2D *to;  
	
    CLLocation * userLocation;
    
    UIView *infoView;
    
    UITableView *_tableview ;
}

@property (retain, nonatomic) EtaoLocalDiscountItem *item;
@property (retain,nonatomic) CLLocation *userLocation;
@property (retain,nonatomic) UIView *infoView;

@property (retain,nonatomic) UITableView *tableview ;

- (void)actionPhone;
- (void)showLoaction;
- (void)showTheWay;
- (void)showMapMode;
@end

