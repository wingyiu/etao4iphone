//
//  EtaoAuctionSearchCategoryFilterViewController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "EtaoAuctionSearchCategoryFilterViewController.h"
#import "EtaoUIBarButtonItem.h"
#import "EtaoSearchFilterCell.h"

@implementation UINavigationBar (CustomImage)

-(void)drawRect:(CGRect)rect 
{
    UIImage *image = [UIImage imageNamed:@"navigationbar.png"];
    [image drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
}

@end

@implementation ETFiterItem
@synthesize key = _key;
@synthesize name = _name ;
@synthesize selected = _selected ;
@synthesize ftype = _ftype;

- (void) dealloc {
    [_key release];
    [_name release];
    [super dealloc];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self retain];
    /*   id copy = [[[self class] allocWithZone:zone] init];
     [copy setKey:[self key]];
     [copy setName:[self name]];
     [copy setFtype:[self ftype]];
     [copy setSelected:[self selected]];
     
     return copy;*/
}

@end

@implementation EtaoAuctionSearchCategoryFilterViewController

@synthesize delegate = _delegate;
@synthesize itemDicts = _itemDicts ;
@synthesize tableView = _tableView;
@synthesize itemKeys = _itemKeys;
@synthesize ftype = _ftype;
@synthesize choosedCategory = _choosedCategory;
@synthesize choosedProp = _choosedProp;
@synthesize choosedSeller = _choosedSeller;
@synthesize start_price = _start_price;
@synthesize end_price = _end_price;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id) init {
    self = [super init];
    
    self.itemDicts = [NSMutableDictionary dictionaryWithCapacity:1];
    self.itemKeys = [NSMutableArray arrayWithCapacity:1];
    self.choosedCategory = [[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    self.choosedProp = [[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    self.choosedSeller = [[[NSMutableSet alloc]initWithCapacity:1]autorelease];
    lastIndexPathRow = -1;
    return  self ;
}

- (void) dealloc {
    
    [_itemKeys release];
    [_itemDicts release];
    [_tableView release];
    if (_standDic != nil) {
        [_standDic removeAllObjects];
        [_standDic release];
        _standDic = nil;
    }
    [_choosedCategory release];
    [_choosedProp release];
    [_choosedSeller release];
    [_start_price release];
    [_end_price release];
    [super dealloc];
}
#pragma mark - View lifecycle

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

- (void) UIBarButtonItemBackClick:(UIBarButtonItem*)sender{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]] forBarMetrics: UIBarMetricsDefault];
    }
    [super UIBarButtonItemBackClick:sender];   
    SEL sel = @selector(EtaoAuctionSearchCategoryFilterBack:);
	if (self.delegate &&  [self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel withObject:self ];
	}
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView]; 

    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain]autorelease];  
    [self.view addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBackgroundColor:[UIColor grayColor]];
    if (![self.title isEqualToString:@"属性"]){
        _tableView.sectionHeaderHeight = 0;
    }
    if (![self.title isEqualToString:@"分类"]) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        _tableView.separatorColor = [UIColor grayColor];
    }
    _standDic = [[NSMutableDictionary alloc]initWithDictionary:[self standardizationArray]];
}

- (void)viewDidLoad{

    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forBarMetrics: UIBarMetricsDefault];
    }
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    EtaoUIBarButtonItem *forword = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemBackClick:)]autorelease];
//    self.navigationItem.leftBarButtonItem = forword; 
    [super viewDidLoad];
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

#pragma mark ----------对数据源规格化处理，得到每行显示的数据----------------
static float leftMargin = 15.0;
static float rightMargin = 15.0;
static float topMargin = 10.0;
static float bottonMargin = 10.0;
static float frameHeight = 30.0;
static float intervalY = 15.0;
static float intervalX = 16.0;

- (NSMutableDictionary *)standardizationArray{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    UIFont *font = [UIFont systemFontOfSize:15.0];
    float btnWidth2 = (320-leftMargin-rightMargin-intervalX)/2;//一行2个按钮
    float btnWidth3 = (320-leftMargin-rightMargin-2*intervalX)/3;//一行3个按钮
    for (int j=0; j<[_itemKeys count]; j++) {
        NSMutableArray *arrayAll = [_itemDicts objectForKey:[_itemKeys objectAtIndex:j]];
        NSMutableArray *array_section = [[[NSMutableArray alloc]initWithCapacity:1]autorelease];
        int three = -1;
        int two = -1;
        int current = 0;
        for (int i=0; i<[arrayAll count]; i++) {
            ETFiterItem *item = [arrayAll objectAtIndex:i];
            CGSize size = [item.name sizeWithFont:font];
            if (size.width > btnWidth2) {
                NSMutableArray *tmp = [[[NSMutableArray alloc]initWithCapacity:1]autorelease];
                [tmp addObject:item];
                [array_section addObject:tmp];
                current++;
            }
            else if(size.width > btnWidth3 && size.width <= btnWidth2){
                if (two == -1) {
                    NSMutableArray *tmp = [[[NSMutableArray alloc]initWithCapacity:1]autorelease];
                    [tmp addObject:item];
                    two = current;
                    [array_section addObject:tmp];
                    current ++;
                }else{
                    NSMutableArray *tmp = [array_section objectAtIndex:two];
                    [tmp addObject:item];
                    if ([tmp count] == 2) {
                        two = -1;
                    }
                }
            }
            else if(size.width <= btnWidth3){
                if (three == -1) {
                    NSMutableArray *tmp = [[[NSMutableArray alloc]initWithCapacity:1]autorelease];
                    [tmp addObject:item];
                    three = current;
                    [array_section addObject:tmp];
                    current++;
                }
                else{
                    NSMutableArray *tmp = [array_section objectAtIndex:three];
                    [tmp addObject:item];
                    if ([tmp count] == 3) {
                        three = -1;
                    }
                }
            }
            if (i == [arrayAll count]-1) {
                if (three != -1) {
                    NSMutableArray *tmp3 = [array_section objectAtIndex:three];
                    if ([tmp3 count] >= 2) {
                        ;
                    }else{
                        ETFiterItem *item3 = [tmp3 objectAtIndex:0];
                        if (two != -1) {
                            NSMutableArray *tmp2 = [array_section objectAtIndex:two];
                            [tmp2 addObject:item3];
                            [array_section removeObject:tmp3];
                            if ([tmp2 count] == 2) {
                                two = -1;
                            }
                            three = -1;
                        }
                    }
                }
            }
        }
        [dic setObject:array_section forKey:[_itemKeys objectAtIndex:j]];
    }
    return dic;
}
    
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    // Return the number of sections.
    if ([self.title isEqualToString:@"属性"]) {
        return [_itemKeys count];
    }
    else{
        return 1;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    // Return the number of rows in the section.
    if ([self.title isEqualToString:@"分类"]) {
        NSMutableArray *arr_tmp = [self.itemDicts objectForKey:@"分类"];
        return [arr_tmp count];
    }
    else{
        return 1;
    }    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if ([self.title isEqualToString:@"属性"]) {
        NSMutableArray *arr_tmp = [_standDic objectForKey:[_itemKeys objectAtIndex:[indexPath section]]];
        NSInteger row_section = [arr_tmp count];
        return row_section*frameHeight + (row_section-1)*intervalY + topMargin + bottonMargin;
    }
    if ([self.title isEqualToString:@"分类"]) {
        return 30;
    }if ([self.title isEqualToString:@"商家"]) {
        NSMutableArray *arr_tmp = [_standDic objectForKey:[_itemKeys objectAtIndex:[indexPath section]]];
        NSInteger row_section = [arr_tmp count];
        return row_section*frameHeight + (row_section-1)*intervalY + topMargin + bottonMargin;
    }
    if ([self.title isEqualToString:@"价格区间"]){
        return 300;
    } 
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    if ([self.title isEqualToString:@"属性"]) {
        UILabel *titleLabel = [[[UILabel alloc]init]autorelease];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.backgroundColor = [UIColor grayColor];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        ETFiterItem *item = [_itemKeys objectAtIndex:section];
        titleLabel.text = item.name;
        return titleLabel;
    } 
    return  nil;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if ([self.title isEqualToString: @"分类"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *arr = [_itemDicts objectForKey:@"分类"];
        ETFiterItem *it = [arr objectAtIndex:indexPath.row];
        cell.textLabel.text = it.name;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (it.selected == YES){
            [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
        }
        return cell;
    } 
    else if ([self.title isEqualToString:@"属性"]) {
        EtaoSearchFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[EtaoSearchFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        NSMutableArray *arr_tmp = [_standDic objectForKey:[_itemKeys objectAtIndex:[indexPath section]]];
        NSInteger row_section = [arr_tmp count];
        NSInteger hight =  row_section*frameHeight + (row_section-1)*intervalY + topMargin + bottonMargin;
        [cell setFrame:CGRectMake(0, 0, 320, hight)];
        [cell setItem:[_standDic objectForKey:[_itemKeys objectAtIndex:[indexPath section]]]];
        return cell;
    }
    else if ([self.title isEqualToString:@"商家"]) {
        EtaoSearchFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[EtaoSearchFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        NSMutableArray *arr_tmp = [_standDic objectForKey:[_itemKeys objectAtIndex:[indexPath section]]];
        NSInteger row_section = [arr_tmp count];
        NSInteger hight =  row_section*frameHeight + (row_section-1)*intervalY + topMargin + bottonMargin;
        [cell setFrame:CGRectMake(0, 0, 320, hight)];
        [cell setItem:[_standDic objectForKey:[_itemKeys objectAtIndex:[indexPath section]]]];
        return cell;
    }
    else if ([self.title isEqualToString:@"价格区间"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        EtaoSliderView *slider = [[[EtaoSliderView alloc]initWithFrame:CGRectMake(10, 60, 280, 100)]autorelease];
        slider.delegate = self;
        [slider setSliderMininumAndMaxinum:0 andMaxinum:1000];
        [slider setSliderPositions:[_start_price floatValue] andRightValue:[_end_price floatValue]];
        [cell addSubview:slider];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.title isEqualToString:@"分类"]) {
   /*     UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSArray *arr = [_itemDicts objectForKey:@"分类"];
        ETFiterItem *it = [arr objectAtIndex:indexPath.row];
        if ([_choosedCategory objectForKey:it.key]) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [_choosedCategory removeObjectForKey:it.key];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [_choosedCategory setObject:it.name forKey:it.key];
        }*/
        int newRow = [indexPath row];
        int oldRow = (lastIndexPathRow != -1)?lastIndexPathRow:-1;
        if (newRow != oldRow && oldRow != -1) {
            NSArray *arr = [_itemDicts objectForKey:@"分类"];
            ETFiterItem *it = [arr objectAtIndex:oldRow];
            [_choosedCategory removeObjectForKey:it.key];
            UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:oldRow inSection:0]];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        lastIndexPathRow = newRow;
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSArray *arr = [_itemDicts objectForKey:@"分类"];
        ETFiterItem *it = [arr objectAtIndex:indexPath.row];
        if (it.selected == YES) {
            it.selected = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            [_choosedCategory removeObjectForKey:it.key];
        }else{
            it.selected = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [_choosedCategory setObject:it.name forKey:it.key];
        }        
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - ------------delegate of cellbtn click-----------
- (void)EtaoSearchFilterCellBtnClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([self.title isEqualToString:@"属性"]) {
        if (btn.selected == YES) {
            btn.selected = NO;
            [_choosedProp removeObjectForKey:btn.titleLabel.text];
            NSEnumerator *e = [_itemDicts keyEnumerator];
            ETFiterItem *key;
            while (key = [e nextObject]) {
                NSArray *arrObj = [_itemDicts objectForKey:key];
                for (ETFiterItem *it in arrObj) {
                    if ([it.name isEqualToString: btn.titleLabel.text]) {
                        it.selected = NO;
                        break;
                    }
                }
            }
        }
        else{
            btn.selected = YES;
            NSEnumerator *e = [_itemDicts keyEnumerator];
            ETFiterItem *_key;
            while (_key = [e nextObject]) {
                NSArray *arrObj = [_itemDicts objectForKey:_key];
                for (ETFiterItem *it in arrObj) {
                    if ([it.name isEqualToString: btn.titleLabel.text]) {
                        [_choosedProp setObject:[NSString stringWithFormat:@"%@:%@", _key.key,it.key] forKey:it.name];
                        it.selected = YES;
                        break;
                    }
                }
            }
        }
    }
    if ([self.title isEqualToString:@"商家"]) {
        if (btn.selected == YES) {
            btn.selected = NO;
            [_choosedSeller removeObject:btn.titleLabel.text];
            NSArray *arrObj = [_itemDicts objectForKey:@"商家"];
            for (ETFiterItem *it in arrObj) {
                if ([it.name isEqualToString: btn.titleLabel.text]) {
                    it.selected = NO;
                    break;
                }
            }
        }
        else{
            btn.selected = YES;
            NSArray *arrObj = [_itemDicts objectForKey:@"商家"];
            for (ETFiterItem *it in arrObj) {
                if ([it.name isEqualToString: btn.titleLabel.text]) {
                    [_choosedSeller addObject:it.name];
                    it.selected = YES;
                    break;
                }
            }
        }
    }
    
}

#pragma mark - -----------sliderView delegate--------

- (void)handlePanLeftDragFinished:(NSString *)leftStr{
    self.start_price = leftStr;
}
- (void)handlePanRightDragFinished:(NSString *)rightStr{
    self.end_price = rightStr;
}
@end
