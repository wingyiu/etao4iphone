//
//  EtaoAuctionPriceCompareHistoryViewController.m
//  etao4iphone
//
//  Created by iTeam on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoAuctionPriceCompareHistoryViewController.h"
#import "HTTPImageView.h"
#import "EtaoSRPController.h"
#import "EtaoSRPCell.h"

@interface EtaoAuctionPriceCompareHistoryViewController ()
- (void)configureCell:(EtaoSRPCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setHistoryEditable:(BOOL)isAble;
@end

@implementation EtaoAuctionPriceCompareHistoryViewController

@synthesize fetchedResultsController=fetchedResultsController_;
@synthesize managedObjectContext;
@synthesize historyList ,bgView;
@synthesize parent = _parent;


 
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    self.title = @"比价历史";
    [super viewDidLoad];
 	 
    if(historyList == nil)
    {
        historyList = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, 320, 380) 
                                                    style:UITableViewStylePlain];
        [historyList setDelegate:self];
        [historyList setDataSource:self];
    }
    
    if(bgView == nil)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 160)]; 
    
        UILabel *bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 20)];
        bgLabel.text = @"当前没有比价历史";
        [bgLabel setFont:[UIFont systemFontOfSize:20.0]];
		bgLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
        [bgLabel setBackgroundColor:[UIColor clearColor]];
        [bgLabel setTextAlignment:UITextAlignmentCenter];
        [bgView addSubview:bgLabel];
        [bgLabel release];
    }
	
//	UIBarButtonItem* deleteAll = [[[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStyleBordered  target:self action:@selector(clearAllHistory)]autorelease];
//	self.navigationItem.leftBarButtonItem = deleteAll; 
     
    [self.view addSubview:historyList];
    
    [historyList reloadData];

}

- (void)clearAllHistory
{
    NSInteger count = [self tableView:self.historyList numberOfRowsInSection:0];
    if(count == 0)
    {
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"历史记录" 
                                                    message:[NSString stringWithFormat:@"你确定要删除历史记录吗？"] 
                                                   delegate:self 
                                          cancelButtonTitle:@"取消" 
                                          otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
    [alert release]; 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != alertView.cancelButtonIndex)
    {
        NSInteger count = [self tableView:self.historyList numberOfRowsInSection:0];
        for(int i = 0; i < count; i ++)
        {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
            NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:ip];
            [self.managedObjectContext deleteObject:managedObject];
        } 
		
		[self.managedObjectContext updatedObjects];
		NSError *error;
		if (![self.managedObjectContext save:&error]) {
			NSLog(@"save error");
		} 
    }
} 
 

- (void)editHistory
{
    if([historyList superview] != self.view)
    {
        return;
    }
    if(historyList.editing == YES)
    {
        [self setHistoryEditable:NO];   
    }
    else
    {
        [self setHistoryEditable:YES];        
    }
}

- (void)setHistoryEditable:(BOOL)isAble
{
    if(isAble == NO)
    {
        [historyList setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
    else
    {
        [historyList setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"完成";
    }
}

- (void)determineTopView
{
    if([historyList numberOfRowsInSection:0] == 0)
    {
        [historyList removeFromSuperview];
        [self.view addSubview:bgView];
        [self setHistoryEditable:NO];
    }
    else
    {
        [bgView removeFromSuperview];
        [self.view addSubview:historyList];
    }
}

// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self determineTopView];
}


/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)configureCell:(EtaoSRPCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSNumber *type = [managedObject valueForKey:@"type"];
    if([type intValue] == ProductItem)
    {
        EtaoProductItem *item = [[[EtaoProductItem alloc] init] autorelease];
        item.title = [managedObject valueForKey:@"title"];
        item.pid = [managedObject valueForKey:@"pid"];
        item.price = [managedObject valueForKey:@"price"];
        item.priceRank = [managedObject valueForKey:@"priceRank"];
        item.returnCount = [managedObject valueForKey:@"returnCount"];
        item.catId = [managedObject valueForKey:@"catId"];
        item.pictUrl = [managedObject valueForKey:@"pictUrl"];
        item.priceListStr = [managedObject valueForKey:@"priceListStr"];
        item.propListStr = [managedObject valueForKey:@"propListStr"];
        item.spuId = [managedObject valueForKey:@"spuId"];
        item.catIdPath = [managedObject valueForKey:@"catIdPath"];
        item.catPathName = [managedObject valueForKey:@"catPathName"];
        item.catMap = [managedObject valueForKey:@"catMap"];
        item.property = [managedObject valueForKey:@"property"];
        item.bbCount = [managedObject valueForKey:@"bbCount"];
        item.sellerCount = [managedObject valueForKey:@"sellerCount"];
        item.cmtCount = [managedObject valueForKey:@"cmtCount"];
        item.images = [managedObject valueForKey:@"images"];
        item.lwQuantity = [managedObject valueForKey:@"lwQuantity"];
        item.brand = [managedObject valueForKey:@"brand"];
        item.recommendSellerListStr = [managedObject valueForKey:@"recommendSellerListStr"];
        item.staticScore = [managedObject valueForKey:@"staticScore"];
        item.evaCount = [managedObject valueForKey:@"evaCount"];
        item.cmtScore = [managedObject valueForKey:@"cmtScore"];
        
        [cell set:item];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        EtaoAuctionItem *item = [[[EtaoAuctionItem alloc] init] autorelease];
        
        item.title = [managedObject valueForKey:@"title"];
        item.nid = [managedObject valueForKey:@"nid"];
        item.price = [managedObject valueForKey:@"price"];
        item.pic = [managedObject valueForKey:@"pic"];
        item.link = [managedObject valueForKey:@"link"];
        item.postFee = [managedObject valueForKey:@"postFee"];
        item.loc = [managedObject valueForKey:@"loc"];
        item.userId = [managedObject valueForKey:@"userId"];
        item.userType = [managedObject valueForKey:@"userType"];
        item.userNickName = [managedObject valueForKey:@"userNickName"];
        item.sales = [managedObject valueForKey:@"sales"];
        item.epid = [managedObject valueForKey:@"epid"];
        item.category = [managedObject valueForKey:@"category"];
        item.comUrl = [managedObject valueForKey:@"comUrl"];
        item.logo = [managedObject valueForKey:@"logo"];
        item.isComUrlWapUrl = [managedObject valueForKey:@"isComUrlWapUrl"];
        item.isLinkWapUrl = [managedObject valueForKey:@"isLinkWapUrl"];
        
        [cell set:item];
    } 
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EtaoSRPCell height];
}


#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject:(id)newObj {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    //to make sure has not too many items
    NSInteger count = [self tableView:self.historyList numberOfRowsInSection:0];    
    if(count >= 50)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:49 inSection:0];
        NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:ip];
        [self.managedObjectContext deleteObject:managedObject];
    }
    
    //to make sure will not add a same item
    for(int i = 0; i < count; i ++)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:ip];
        if([newObj isKindOfClass:[EtaoSRPCell class]])
        {
            EtaoSRPCell * cell = newObj;
            if([cell._item isKindOfClass:[EtaoProductItem class]])
            {
                EtaoProductItem* item = cell._item;
                NSString *pid = [managedObject valueForKey:@"pid"];
                if([pid isEqualToString:item.pid])
                {
                    [self.managedObjectContext deleteObject:managedObject];
                    break;
//                    return;
                }
            }
            else
            {
                EtaoAuctionItem *item = cell._item;
                NSString *nid = [managedObject valueForKey:@"nid"];
                if([nid isEqualToString:item.nid])
                {
                    [self.managedObjectContext deleteObject:managedObject];
                    break;
//                    return;
                }
            }
        }
    }
    
    //create a new item, set and add it to core data
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timestamp"];
    
    if([newObj isKindOfClass:[EtaoSRPCell class]])
    {
        EtaoSRPCell * cell = newObj;
        
        if([cell._item isKindOfClass:[EtaoProductItem class]])
        {
            EtaoProductItem* item = cell._item;
            [newManagedObject setValue:[NSNumber numberWithInt:ProductItem] forKey:@"type"];
            
            [newManagedObject setValue:item.title forKey:@"title"];
            [newManagedObject setValue:item.pid forKey:@"pid"];
            [newManagedObject setValue:item.price forKey:@"price"];
            [newManagedObject setValue:item.priceRank forKey:@"priceRank"];
            [newManagedObject setValue:item.returnCount forKey:@"returnCount"];
            [newManagedObject setValue:item.catId forKey:@"catId"];
            [newManagedObject setValue:item.pictUrl forKey:@"pictUrl"];
            [newManagedObject setValue:item.priceListStr forKey:@"priceListStr"];
            [newManagedObject setValue:item.propListStr forKey:@"propListStr"];
            [newManagedObject setValue:item.spuId forKey:@"spuId"];
            [newManagedObject setValue:item.catIdPath forKey:@"catIdPath"];
            [newManagedObject setValue:item.catPathName forKey:@"catPathName"];
            [newManagedObject setValue:item.catMap forKey:@"catMap"];
            [newManagedObject setValue:item.property forKey:@"property"];
            [newManagedObject setValue:item.bbCount forKey:@"bbCount"];
            [newManagedObject setValue:item.sellerCount forKey:@"sellerCount"];
            [newManagedObject setValue:item.cmtCount forKey:@"cmtCount"];
            [newManagedObject setValue:item.images forKey:@"images"];
            [newManagedObject setValue:item.lwQuantity forKey:@"lwQuantity"];
            [newManagedObject setValue:item.brand forKey:@"brand"];
            [newManagedObject setValue:item.recommendSellerListStr forKey:@"recommendSellerListStr"];
            [newManagedObject setValue:item.staticScore forKey:@"staticScore"];
            [newManagedObject setValue:item.evaCount forKey:@"evaCount"];
            [newManagedObject setValue:item.cmtScore forKey:@"cmtScore"];
        }
        else //when it was a EtaoAuctionItem
        {
            EtaoAuctionItem *item = cell._item;
            
            [newManagedObject setValue:[NSNumber numberWithInt:AuctionItem] forKey:@"type"];
            
            [newManagedObject setValue:item.title forKey:@"title"];
            [newManagedObject setValue:item.nid forKey:@"nid"];
            [newManagedObject setValue:item.price forKey:@"price"];
            [newManagedObject setValue:item.pic forKey:@"pic"];
            [newManagedObject setValue:item.link forKey:@"link"];
            [newManagedObject setValue:item.postFee forKey:@"postFee"];
            [newManagedObject setValue:item.loc forKey:@"loc"];
            [newManagedObject setValue:item.userId forKey:@"userId"];
            [newManagedObject setValue:item.userType forKey:@"userType"];
            [newManagedObject setValue:item.userNickName forKey:@"userNickName"];
            [newManagedObject setValue:item.sales forKey:@"sales"];
            [newManagedObject setValue:item.epid forKey:@"epid"];
            [newManagedObject setValue:item.category forKey:@"category"];
            [newManagedObject setValue:item.comUrl forKey:@"comUrl"];
            [newManagedObject setValue:item.logo forKey:@"logo"];
            [newManagedObject setValue:item.isComUrlWapUrl forKey:@"isComUrlWapUrl"];
            [newManagedObject setValue:item.isLinkWapUrl forKey:@"isLinkWapUrl"];
            
        }
//        [newManagedObject setValue:@"30.00" forKey:@"price"];
//        
//        [newManagedObject setValue:@"一个商品" forKey:@"title"];
    }
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    // Prevent new objects being added when in editing mode.
    [super setEditing:(BOOL)editing animated:(BOOL)animated];
    self.navigationItem.rightBarButtonItem.enabled = !editing;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section]; 
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//    // Configure the cell.
//    [self configureCell:cell atIndexPath:indexPath];
//    
//    return cell;
    NSString *CellIdentifier = nil;
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    int type = [[managedObject valueForKey:@"type"] intValue];
    switch (type) {
        case ProductItem:
             CellIdentifier = @"pCell";
            break;
        case AuctionItem:
             CellIdentifier = @"aCell";
            break;    
        default:
            break;
    }

    EtaoSRPCell * cell = (EtaoSRPCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EtaoSRPCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
//    [cell set:[self._srpdata objectAtIndex:row]];  
    cell._parent = self.parent;
    cell._idx = indexPath.row;                       
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    // Navigation logic may go here -- for example, create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"History" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [historyList beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [historyList insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [historyList deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = historyList;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(EtaoSRPCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [historyList endUpdates];
    [self determineTopView];
    [historyList reloadData];
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [fetchedResultsController_ release];
    [managedObjectContext release];
    [historyList release];
    [bgView release];
    [super dealloc];
}



@end

