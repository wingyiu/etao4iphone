//
//  EtaoAuctionPriceCompareHistoryViewController.h
//  etao4iphone
//
//  Created by iTeam on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EtaoUIViewWithBackgroundController.h"
enum
{
    ProductItem,
    AuctionItem
}HistoryItemType;

@interface EtaoAuctionPriceCompareHistoryViewController : EtaoUIViewWithBackgroundController  <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate> {
	
    UITableView *historyList;
    UIView *bgView;
    
    UIViewController *_parent ;
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext;
    
}

@property (nonatomic, retain) UITableView *historyList;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UIView *bgView;

@property (nonatomic, assign) UIViewController *parent ;

- (void)editHistory;
- (void)determineTopView;
- (void)insertNewObject:(id)newObj;

@end
