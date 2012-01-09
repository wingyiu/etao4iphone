//
//  etao4iphoneAppDelegate.h
//  etao4iphone
//
//  Created by zhangsuntai on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "EtaoAuctionPriceCompareHistoryViewController.h"
#import "ETaoHistoryViewController.h"
#import "EtaoNewHomeViewController.h"
#import "ETDataCenter.h"
#import "ETLocationDataSource.h"


@interface etao4iphoneAppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *_window; 

	UINavigationController *_navigationController; 
    
    EtaoNewHomeViewController *_home;	
	EtaoAuctionPriceCompareHistoryViewController *_etaoAuctionPriceCompareHistoryViewController;
	ETaoHistoryViewController *_etaoHistoryViewController;
	
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	
}

@property (nonatomic,retain) UIWindow *window; 
@property (nonatomic,retain) UINavigationController *navigationController;
 
@property (nonatomic, retain) IBOutlet EtaoAuctionPriceCompareHistoryViewController *etaoAuctionPriceCompareHistoryViewController;
@property (nonatomic, retain) ETaoHistoryViewController *etaoHistoryViewController;
@property (nonatomic, retain) EtaoNewHomeViewController *home;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end
