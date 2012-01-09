//
//  EtaoPriceSRPTableViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ETSRPTableViewController.h"
#import "ETUrlObject.h"
#import "EtaoLocalListHeadDistanceView.h"
#import "ETPageSwipeDelegate.h"

@interface EtaoPriceSRPTableViewController : ETSRPTableViewController<ETPageSwipeDelegate>

@property (nonatomic,retain) ETUrlObject *requestUrl ;

@property (nonatomic,retain) NSString *keyword ;
@property (nonatomic,retain) NSString *catid ;
@property (nonatomic,retain) NSString *ppath ;
@property (nonatomic,retain) NSString *sort ;
@property (nonatomic,retain) NSString *website ;
@property (nonatomic, retain) NSString *start_price;
@property (nonatomic, retain) NSString *end_price;

@property (nonatomic,retain) EtaoLocalListHeadDistanceView *head ;

- (void) search:(NSString*)keyword;

- (void) searchWord:(NSString*)word cat:(NSString*)cat ppath:(NSString*)ppath website:(NSString*) website start_price:(NSString *)start_price end_price:(NSString *)end_price sort:(NSString*) sort;

@end
