//
//  EtaoAuctionSRPTableViewController.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETSRPTableViewController.h"
#import "EtaoAuctionSRPDataSource.h"
#import "EtaoSearchFilterViewController.h"
#import "ETUrlObject.h"
#import "EtaoMenuView.h"
#import "EtaoCustomButtonView.h"
#import "EtaoLocalListHeadDistanceView.h"
#import "EtaoAuctionSearchCategoryFilterViewController.h"

@interface EtaoAuctionSRPTableViewController : ETSRPTableViewController <UIGestureRecognizerDelegate,EtaoSearchFilterDelegate,EtaoAuctionSearchCategoryFilterDelegate> {
    
    // for filter
    NSMutableArray *_catList;  
    NSMutableArray *_catPath; 
    
    NSMutableArray *_sellerList;  
    
    NSMutableDictionary *_propDicts; 
    NSMutableArray *_propKeys; 
    
    NSMutableDictionary *_categorychoosed;
    NSMutableDictionary *_propchoosed;
    NSMutableSet *_fsellerNameSet;
    NSString *_start_price;
    NSString *_end_price;
}
 

@property (nonatomic,retain) ETUrlObject *requestUrl ;

@property (nonatomic,retain) NSString *keyword ;
@property (nonatomic,retain) NSString *catid ;
@property (nonatomic,retain) NSString *ppath ;
@property (nonatomic,retain) NSString *sort ;
@property (nonatomic,retain) NSString *website ;
@property (nonatomic, retain) NSString *start_price;
@property (nonatomic, retain) NSString *end_price;

@property (nonatomic, retain) NSMutableDictionary *categorychoosed;
@property (nonatomic, retain) NSMutableDictionary *propchoosed;
@property (nonatomic, retain) NSMutableSet *fsellerNameSet;
// for path 
@property (nonatomic,retain) UIPanGestureRecognizer *panGes;
@property (nonatomic,retain) EtaoSearchFilterViewController *filterView ;


@property (nonatomic,retain) EtaoLocalListHeadDistanceView *head ;
@property (nonatomic,retain) EtaoMenuView *rankView ;
@property (nonatomic,retain) EtaoCustomButtonView *rankbtnv;



- (void) search:(NSString*)keyword;

- (void) searchWord:(NSString*)word cat:(NSString*)cat ppath:(NSString*)ppath website:(NSString*) website start_price:(NSString *)start_price end_price:(NSString *)end_price sort:(NSString*) sort;


@end
