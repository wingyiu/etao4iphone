//
//  EtaoPriceSettingController.m
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceSettingController.h"
#import "ETaoUITableViewCell.h"
#import "ETaoNetWorkAlert.h"
@implementation EtaoPriceSettingController

@synthesize httprequest = _httprequest;
@synthesize _requestFailed;

- (void) UIBarButtonHomeDone:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
} 

-(id)init
{
    self = [super init];
    if (self){
        EtaoPriceSettingHttpRequest *http = [[[EtaoPriceSettingHttpRequest alloc]init]autorelease];
        self.httprequest = http;
        _httprequest.delegate = self;
        _httprequest.requestDidFinishSelector = @selector(requestFinished:);
        _httprequest.requestDidFailedSelector = @selector(requestFailed:);
        return self;
    }
    return nil;
}

-(void)loadView{
    [super loadView];
    [self.tableView setEditing:YES animated:NO];
    
    EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"返回" bkColor:[UIColor clearColor] target:self action:@selector(UIBarButtonHomeDone:)]autorelease];
    self.navigationItem.leftBarButtonItem = back;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)requestFinished:(EtaoHttpRequest*)sender
{ 
   
    
    
    NSData* data = sender.data;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:enc];

    [_httprequest addItemsByJSON:jsonString];
    [jsonString release];
    
    self._requestFailed = NO;
    
    [self.tableView reloadData];
    
}

-(void)requestFailed:(EtaoHttpRequest*)sender
{
  
    self._requestFailed = YES;
    [self.tableView reloadData];
    [[ETaoNetWorkAlert alert]show]; 
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_httprequest count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%d", [indexPath row]);
    NSUInteger row = [indexPath row];
    static NSString *itemPriceCellId = @"itemPriceCell";
    ETaoUITableViewCell *cell = (ETaoUITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:itemPriceCellId];
    if(cell == nil){
        cell = [[[ETaoUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemPriceCellId]autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if([[_httprequest objectAtIndex:row] isKindOfClass:[EtaoPriceSettingModuleCell class]] && _requestFailed != YES)
    {
        EtaoPriceSettingModuleCell *tmp = [_httprequest objectAtIndex:row];
   
        if([tmp.selected isEqualToString:@"1"]){
            [cell setSelected:YES animated:YES];
            cell.btnView.hidden = NO;
            
        }else{
            [cell setSelected:NO animated:YES];
            cell.btnView.hidden = YES;
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", tmp.tag];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        [cell.textLabel setHighlightedTextColor:[UIColor blackColor]];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    if ([[_httprequest objectAtIndex:row]isKindOfClass:[EtaoPriceSettingModuleCell class]]) {
        EtaoPriceSettingModuleCell *tmp = [_httprequest objectAtIndex:row];
        if([tmp.choosed isEqualToString:@"1"]){
            [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:YES];

            ((ETaoUITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
            
           return nil;
        }
    }
    return indexPath;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;

}
/*
-(BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    if([_httprequest.items objectAtIndex:fromIndexPath.row]){
        EtaoPriceSettingModuleCell * cell = [[_httprequest.items objectAtIndex:fromIndexPath.row]retain];
        [_httprequest.items removeObjectAtIndex:fromIndexPath.row];
        [_httprequest.items insertObject:cell atIndex:toIndexPath.row];
        [cell release];
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
    EtaoPriceSettingModuleCell *cell = [_httprequest.items objectAtIndex:indexPath.row];
    if ([cell.selected isEqualToString:@"0"]) {
        cell.selected = @"1";
        
        ((ETaoUITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
        
    }
    else{
        cell.selected = @"0";
        
        ((ETaoUITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = YES;
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
//    [self.tableView cellForRowAtIndexPath:indexPath].textLabel.backgroundColor = [UIColor whiteColor];    
//    [[self.tableView cellForRowAtIndexPath:indexPath].contentView setBackgroundColor:[UIColor whiteColor]];
    
    NSLog(@"did select");
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    EtaoPriceSettingModuleCell *cell = [_httprequest.items objectAtIndex:indexPath.row];
    if ([cell.selected isEqualToString:@"1"]) {
        cell.selected = @"0";
        ((ETaoUITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = YES;
    } 
    
 //   [self.tableView cellForRowAtIndexPath:indexPath].textLabel.backgroundColor = [UIColor whiteColor];    
//    [[self.tableView cellForRowAtIndexPath:indexPath].contentView setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"did deselect");  
    
}

- (void)start
{
    [_httprequest start];
    [self.tableView reloadData];
}

-(void)save
{
    
    NSLog(@"save...");

    NSArray * arr = [NSArray arrayWithArray:[_httprequest.items sortedArrayUsingSelector:@selector(CellCompare:)]];
    [_httprequest.items setArray:arr];
    
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_httprequest.items];
    [[NSUserDefaults standardUserDefaults]setObject:arrayData forKey:@"user_choose_display"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

-(void)load
{
    NSLog(@"load...");
    if([_httprequest count] > 0){
        [_httprequest removeAllObjects];
    }
      
    NSData *arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_choose_display"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    [_httprequest.items setArray:array];

    [self.tableView reloadData];
}

-(NSMutableArray *)getDataSource{
    [self load];
    if(_httprequest.items.count == 0){
        _httprequest.isSyc = YES;
        [_httprequest start];
    }
    return _httprequest.items;
}

-(void)clear:(id)sender{
    NSLog(@"clear...");
    if([_httprequest count] > 0){
        [_httprequest removeAllObjects];
    }
    [self.tableView reloadData];
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil; 
    if(_httprequest != nil){
        _httprequest.delegate = nil;
    }
    
    [_httprequest release];    
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
