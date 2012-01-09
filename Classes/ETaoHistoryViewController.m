//
//  ETaoHistoryViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoHistoryViewController.h"
#import "EtaoAuctionItem.h"
#import "EtaoProductItem.h"
#import "EtaoSRPCell.h"
#import "NSObject+SBJson.h"
#import "etao4iphoneAppDelegate.h"
@implementation ETaoHistory

@dynamic timestamp;
@dynamic hashstr ;
@dynamic jsonstr ;
@dynamic name ;

@end

@implementation ETaoHistoryViewController

@synthesize tableView = _tableView;
@synthesize managedObjectContext = _managedObjectContext ;
@synthesize fetchedResultsController = _fetchedResultsController ;
@synthesize addingManagedObjectContext =_addingManagedObjectContext;
@synthesize parent = _parent;
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// copy from old version 
// deprecated for next version
// by zhangsuntai
- (void) checkOldVersion{ 
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *docuDir =  [[NSURL fileURLWithPath:documentsDirectory] absoluteString];
    
 	NSString *s = [docuDir stringByAppendingString:@"etao4iphone.sqlite" ]; 
	NSURL *storeURL = [NSURL URLWithString:s]; 
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext_ = [[[NSManagedObjectContext alloc] init]autorelease];
    
    NSManagedObjectModel *managedObjectModel_ = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    
    
    NSPersistentStoreCoordinator * persistentStoreCoordinator_ = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel_]autorelease];
    
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Handle error
        NSLog(@"Problem with PersistentStoreCoordinator: %@",error);
        return ;
    } 
         

    [managedObjectContext_ setPersistentStoreCoordinator:persistentStoreCoordinator_];
    
    NSFetchRequest * request = [[[NSFetchRequest alloc] init]autorelease]; 
    
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"History" inManagedObjectContext:managedObjectContext_]; 
    [request setEntity:entity];
    
    NSArray *results=[[managedObjectContext_ executeFetchRequest:request error:&error] copy];
    
    
    if (error) {
        return ; 
    }
      

    
    for (NSManagedObject *managedObject in results ) { 
        
        NSNumber *type = [managedObject valueForKey:@"type"];
        if([type intValue] == 0)
        {
            EtaoProductItem *item = [[[EtaoProductItem alloc] init] autorelease];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:30];
            [dict setValue:[managedObject valueForKey:@"title"] forKey:@"title"];
            [dict setValue:[managedObject valueForKey:@"pid"] forKey:@"pid"];
            [dict setValue:[managedObject valueForKey:@"price"] forKey:@"price"];
            [dict setValue:[managedObject valueForKey:@"priceRank"] forKey:@"priceRank"];
            [dict setValue:[managedObject valueForKey:@"returnCount"] forKey:@"returnCount"];
            [dict setValue:[managedObject valueForKey:@"catId"] forKey:@"catId"];
            [dict setValue:[managedObject valueForKey:@"pictUrl"] forKey:@"pictUrl"];
            [dict setValue:[managedObject valueForKey:@"priceListStr"] forKey:@"priceListStr"];
            [dict setValue:[managedObject valueForKey:@"propListStr"] forKey:@"propListStr"];
            [dict setValue:[managedObject valueForKey:@"spuId"] forKey:@"spuId"];
            [dict setValue:[managedObject valueForKey:@"catIdPath"] forKey:@"catIdPath"];
            [dict setValue:[managedObject valueForKey:@"catPathName"] forKey:@"catPathName"];
            [dict setValue:[managedObject valueForKey:@"catMap"] forKey:@"catMap"];
            [dict setValue:[managedObject valueForKey:@"property"] forKey:@"property"];    
            [dict setValue:[managedObject valueForKey:@"bbCount"] forKey:@"bbCount"]; 
            [dict setValue:[managedObject valueForKey:@"sellerCount"] forKey:@"sellerCount"];    
            [dict setValue:[managedObject valueForKey:@"cmtCount"] forKey:@"cmtCount"];             
            [dict setValue:[managedObject valueForKey:@"images"] forKey:@"images"];    
            [dict setValue:[managedObject valueForKey:@"lwQuantity"] forKey:@"lwQuantity"];             
            [dict setValue:[managedObject valueForKey:@"recommendSellerListStr"] forKey:@"recommendSellerListStr"];    
            [dict setValue:[managedObject valueForKey:@"staticScore"] forKey:@"staticScore"];    
            [dict setValue:[managedObject valueForKey:@"evaCount"] forKey:@"evaCount"];  
            [dict setValue:[managedObject valueForKey:@"cmtScore"] forKey:@"cmtScore"];   
            [item setFromDictionary:dict];
            /*
             
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
             */
            NSLog(@"%@",item);  
            NSString *json = [[item toDictionary] JSONRepresentation]; 
            [self addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.pid hash]] Name:@"product" JSON:json];   
 
        }
        else
        {
            EtaoAuctionItem *item = [[[EtaoAuctionItem alloc] init] autorelease];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:30];
            [dict setValue:[managedObject valueForKey:@"title"] forKey:@"title"];    
            [dict setValue:[managedObject valueForKey:@"nid"] forKey:@"nid"]; 
            [dict setValue:[managedObject valueForKey:@"price"] forKey:@"price"];    
            [dict setValue:[managedObject valueForKey:@"pic"] forKey:@"pic"]; 
            [dict setValue:[managedObject valueForKey:@"link"] forKey:@"link"];    
            [dict setValue:[managedObject valueForKey:@"loc"] forKey:@"loc"]; 
            [dict setValue:[managedObject valueForKey:@"userId"] forKey:@"userId"];    
            [dict setValue:[managedObject valueForKey:@"userType"] forKey:@"userType"]; 
            [dict setValue:[managedObject valueForKey:@"userNickName"] forKey:@"userNickName"];    
            [dict setValue:[managedObject valueForKey:@"sales"] forKey:@"sales"];   
            [dict setValue:[managedObject valueForKey:@"epid"] forKey:@"epid"];    
            [dict setValue:[managedObject valueForKey:@"category"] forKey:@"category"]; 
            [dict setValue:[managedObject valueForKey:@"comUrl"] forKey:@"comUrl"];    
            [dict setValue:[managedObject valueForKey:@"logo"] forKey:@"logo"]; 
            [dict setValue:[managedObject valueForKey:@"isComUrlWapUrl"] forKey:@"isComUrlWapUrl"];    
            [dict setValue:[managedObject valueForKey:@"isLinkWapUrl"] forKey:@"isLinkWapUrl"]; 
            [item setFromDictionary:dict];
            /*
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
             item.isLinkWapUrl = [managedObject valueForKey:@"isLinkWapUrl"]; */
            NSLog(@"%@",item);
            NSString *json = [[item toDictionary] JSONRepresentation];
            [self addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.nid hash]] Name:@"auction" JSON:json];  
        } 
        [managedObjectContext_ deleteObject:managedObject];
        NSError *error; 
        if (![managedObjectContext_ save:&error]) { 
            // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);             
        }
    } 	 
}


- (void) loadView{
    
    [super loadView];
/*    UIApplication *app = [UIApplication sharedApplication];
    etao4iphoneAppDelegate *delegate = (etao4iphoneAppDelegate *)app.delegate;
     
    NSPersistentStoreCoordinator *coordinator = delegate.persistentStoreCoordinator;
    if (coordinator != nil)
    {
        self.managedObjectContext = [[[NSManagedObjectContext alloc] init]autorelease];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    } 
  */  
    self.title = @"比价历史";
 	
	self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain]autorelease];   
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.delegate = self;
    _tableView.dataSource = self; 
    
    UIView *head = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)]autorelease];
 
    UIButton *edit = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)]autorelease];  
    [edit setTitle:@"编辑" forState:UIControlStateNormal  ];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside]; 
    [edit setBackgroundImage:[UIImage imageNamed:@"EtaoSearchbutton.png"] forState:UIControlStateNormal];
    //[head addSubview:edit];
 
    UIButton *clear = [[[UIButton alloc] initWithFrame:CGRectMake(110, 20, 100, 40)]autorelease];  
    [clear setBackgroundImage:[UIImage imageNamed:@"etao_clear_histoy.png"] forState:UIControlStateNormal];
    [clear setTitle:@"清除比价历史" forState:UIControlStateNormal]; 
    clear.titleLabel.font = [UIFont systemFontOfSize:14];
    [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearall) forControlEvents:UIControlEventTouchUpInside]; 
        [head addSubview:clear];
    
    
    _tableView.tableFooterView = head;
	
    [self.view addSubview:_tableView];
    
    [self checkOldVersion];

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != alertView.cancelButtonIndex)
    {
        NSInteger count = [_tableView numberOfRowsInSection:0];
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

- (void)clearall
{
    NSInteger count = [_tableView numberOfRowsInSection:0];
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
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ClearnCompareHistory"];
}

- (void) edit:(UIButton*)sender {
    if ( !_tableView.editing ) {
        [sender setTitle:@"完成" forState:UIControlStateNormal  ];
        [_tableView setEditing:YES animated:YES];
    }
    else
    {
        [sender setTitle:@"编辑" forState:UIControlStateNormal  ];
        [_tableView setEditing:NO animated:YES];
    } 
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EtaoSRPCell height];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section]; 
    int cnt = [sectionInfo numberOfObjects];
    return cnt;
}


- (void)configureCell:(EtaoSRPCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    
    NSString *name = [managedObject valueForKey:@"name"];
    NSString *jsonstr = [managedObject valueForKey:@"jsonstr"];  
    if([name isEqualToString:@"product"])
    {
        EtaoProductItem *item = [[EtaoProductItem alloc] init]; 
        [item initWithDictionary:[jsonstr JSONValue]];
        [cell set:item];   
        [item release];
    }
    else
    {
        EtaoAuctionItem *item = [[EtaoAuctionItem alloc] init]; 
        [item initWithDictionary:[jsonstr JSONValue]];
        [cell set:item]; 
        [item release];
    } 
    
    cell._parent = _parent;
    cell._idx = [indexPath row];  
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell"; 
          
    EtaoSRPCell * cell = (EtaoSRPCell*)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[EtaoSRPCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell; 
}
 
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

 
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
 

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];  
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	if ([cell isKindOfClass:[EtaoSRPCell class]]) {
        EtaoSRPCell *etaoinfo = (EtaoSRPCell*) cell; 
        if ( [etaoinfo._item isKindOfClass:[EtaoProductItem class]] ){
            EtaoProductItem *item =  etaoinfo._item;  
            NSString *json = [[item toDictionary] JSONRepresentation];
            
            [self addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.pid hash]] Name:@"product" JSON:json];
        }
        else
        {
            EtaoAuctionItem *item =  etaoinfo._item;   
            NSString *json = [[item toDictionary] JSONRepresentation];
            [self addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.nid hash]] Name:@"auction" JSON:json];
        }
	}   
}


#pragma mark -
#pragma mark Fetched results controller

- (void)addHistoryWithHash:(NSString*)hash Name:(NSString*)name JSON:(NSString*)json {
    NSError *error = nil;
    
    //This is your NSManagedObject subclass
    ETaoHistory * item = nil;
  
    NSManagedObjectContext *addingContext = [[[NSManagedObjectContext alloc] init]autorelease];
 	[addingContext setPersistentStoreCoordinator:[[self.fetchedResultsController managedObjectContext] persistentStoreCoordinator]];
    //Set up to get the thing you want to update
    NSFetchRequest * request = [[[NSFetchRequest alloc] init]autorelease];
    [request setEntity:[NSEntityDescription entityForName:@"ETaoHistory" inManagedObjectContext:addingContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"hashstr =%@",hash]];
    
    //Ask for it 
    item = [[addingContext executeFetchRequest:request error:&error] lastObject]; 
    
    if (error) {
        //Handle any errors
    }
    
    if (!item) {
       	ETaoHistory *his = (ETaoHistory *)[NSEntityDescription insertNewObjectForEntityForName:@"ETaoHistory" inManagedObjectContext:addingContext];
        [his setValue:[NSDate date] forKey:@"timestamp"];
        [his setValue:hash forKey:@"hashstr"];
        [his setValue:json forKey:@"jsonstr"];
        [his setValue:name forKey:@"name"];
    }else{
    
        //Update the object 
        [item setValue:[NSDate date] forKey:@"timestamp"];
        [item setValue:json forKey:@"jsonstr"];
    }

    NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(addControllerContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:addingContext];
    //Save it
    error = nil;
    if (![addingContext save:&error]) {
        //Handle any error with the saving of the context
    }  
	//[dnc removeObserver:self name:NSManagedObjectContextDidSaveNotification object:addingContext];

    
    
}
 
/**
 Notification from the add controller's context's save operation. This is used to update the fetched results controller's managed object context with the new book instead of performing a fetch (which would be a much more computationally expensive operation).
 */
- (void)addControllerContextDidSave:(NSNotification*)saveNotification {
	
 	NSManagedObjectContext *context = [_fetchedResultsController managedObjectContext];
   // NSManagedObjectContext *context = [saveNotification object]; 
	// Merging changes causes the fetched results controller to update its results
    [context mergeChangesFromContextDidSaveNotification:saveNotification];
    // ??? 
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
    
}


- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETaoHistory" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:10];
    [fetchRequest setFetchLimit:100];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    NSArray *arrayItem = [NSArray arrayWithObjects:@"product",@"auction",nil];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name IN %@", arrayItem];
                                     
    // must 
    [NSFetchedResultsController deleteCacheWithName:nil];    
    
    [fetchRequest setPredicate:pre];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSLog(@"%@",fetchRequest.propertiesToFetch); 
  //  [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"hashcode"]];
    [fetchRequest setReturnsDistinctResults:YES];
    
    
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
    if (![_fetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(EtaoSRPCell*)[tableView cellForRowAtIndexPath:indexPath]   atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
