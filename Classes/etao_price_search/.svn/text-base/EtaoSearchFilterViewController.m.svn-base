//
//  EtaoSearchFilterViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoSearchFilterViewController.h"

@implementation ETaoFilterItem

@synthesize title = _title;
@synthesize image = _image;
@synthesize tag,type;

- (void) dealloc {
    [_title release];
    [_image release];
    [super dealloc];
}

@end

@implementation EtaoSearchFilterViewController
@synthesize tableView = _tableView;
@synthesize headTitle = _headTitle ;
@synthesize delegate  = _delegate ;
@synthesize items = _items ;
@synthesize catNameSet = _catNameSet;
@synthesize propNameSet = _propNameSet;
@synthesize sellerNameSet = _sellerNameSet;
@synthesize start_price = _start_price;
@synthesize end_price = _end_price;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.catNameSet = [[[NSMutableSet alloc]initWithCapacity:1]autorelease];
        self.propNameSet = [[[NSMutableSet alloc]initWithCapacity:1]autorelease];
        self.sellerNameSet = [[[NSMutableSet alloc]initWithCapacity:1]autorelease];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc {
    
    [_items release];
    [_tableView release];
    [_headTitle release];
    [_catNameSet release];
    [_propNameSet release];
    [_sellerNameSet release];
    [_start_price release];
    [_end_price release];
    [super dealloc];
    
}

- (id) init {
    self = [super init];
    _items = [[NSMutableArray alloc]initWithCapacity:5];
    return  self ;
}
#pragma mark - View lifecycle

 
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{ 
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)]autorelease];
    self.view = view;
    self.view.backgroundColor = [UIColor grayColor];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(60,20,self.view.frame.size.width - 60,self.view.frame.size.height) style:UITableViewStylePlain]autorelease];  
    self.tableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    _tableView.dataSource = self;
    _tableView.delegate = self;
     
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    // Return the number of rows in the section.
    return [_items count];
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{  
    return  _headTitle != nil ? _headTitle : @"筛选" ; 
}
*/

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }else{
        for (UIView *view in [cell subviews]) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
            }
        }
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    [self item2cell:cell andindexPath:indexPath];
    
    return cell;
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *titleLabel = [[[UILabel alloc]init]autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.backgroundColor = [UIColor grayColor];
    [titleLabel setFont:[UIFont systemFontOfSize:16]];
    titleLabel.text = [NSString stringWithFormat:@"  %@", _headTitle];

    return titleLabel;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
       
}

- (void)item2cell:(UITableViewCell *)cell andindexPath:(NSIndexPath *)path{
    
    ETaoFilterItem *item = [_items objectAtIndex:[path row]];
    cell.textLabel.text = item.title;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //显示已选择的类目
    if ([item.title isEqualToString:@"分类"]) {
        NSString *chooosed = @"";
        for (NSString *cat in _catNameSet) {
            chooosed = [chooosed stringByAppendingFormat:@"   %@", cat];      
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@      %@", item.title, chooosed];
    }
    if ([item.title isEqualToString:@"属性"]) {
        NSString *chooosed = @"";
        for (NSString *p in _propNameSet) {
            chooosed = [chooosed stringByAppendingFormat:@"   %@", p];      
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@      %@", item.title, chooosed];
    }
    if ([item.title isEqualToString:@"商家"]) {
        NSString *chooosed = @"";
        for (NSString *p in _sellerNameSet) {
            chooosed = [chooosed stringByAppendingFormat:@"   %@", p];      
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@      %@", item.title, chooosed];
    }
    if ([item.title isEqualToString:@"价格区间"]) {
        if (_start_price != nil && _end_price != nil) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@      [%@,%@]", item.title, _start_price, _end_price];
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ETaoFilterItem *item = [_items objectAtIndex:[indexPath row]];
    SEL sel = @selector(EtaoSearchFilterItemSelected:);
	if (self.delegate &&  [self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel withObject:item ];
	}  
}


@end
