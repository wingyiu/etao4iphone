//
//  ETaoHistoryViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETaoUIViewController.h"

#import <CoreData/CoreData.h>

 
@interface ETaoHistory :  NSManagedObject  
{
    
}
@property (nonatomic, retain) NSString * hashstr;
@property (nonatomic, retain) NSString * jsonstr;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timestamp;

@end

@interface ETaoHistoryViewController : ETaoUIViewController <NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate> {
    
    
    UITableView *_tableView; 
    
    NSManagedObjectContext *_managedObjectContext;
    NSFetchedResultsController *_fetchedResultsController;
    NSManagedObjectContext *_addingManagedObjectContext;
    UIViewController *_parent ;
}
@property (nonatomic, assign) UIViewController *parent ;

@property (nonatomic, retain) UITableView *tableView; 

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;

- (void)addHistoryWithHash:(NSString*)hash Name:(NSString*)name JSON:(NSString*)json;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;




@end
