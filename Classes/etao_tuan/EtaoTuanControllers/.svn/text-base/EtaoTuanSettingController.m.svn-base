//
//  EtaoTuanSettingController.m
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanSettingController.h"
#import "ETaoNetWorkAlert.h"
@implementation EtaoTuanSettingController
@synthesize datasource = _datasource;


-(id)init
{
    self = [super init];
    if (self){
        return self;
    }
    return nil;
}

- (void)dealloc
{
    [_datasource removeObserver:self forKeyPath:@"status"];
    _datasource = nil;
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    [self.tableView setEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_datasource.items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *itemTuanCellId = @"itemTuanCell";
    EtaoTuanSettingCell *cell = (EtaoTuanSettingCell*)[self.tableView dequeueReusableCellWithIdentifier:itemTuanCellId];
    if(cell == nil){
        cell = [[[EtaoTuanSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemTuanCellId]autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if( indexPath.row < _datasource.items.count )
    {
        EtaoTuanSettingItem *item = [_datasource.items objectAtIndex:indexPath.row];
        
        if([item.selected isEqualToString:@"1"]){
            [cell setSelected:YES animated:YES];
            cell.btnView.hidden = NO;
            
        }else{
            [cell setSelected:NO animated:YES];
            cell.btnView.hidden = YES;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", item.tag];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        [cell.textLabel setHighlightedTextColor:[UIColor blackColor]];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    if ([[_datasource.items objectAtIndex:row]isKindOfClass:[EtaoTuanSettingItem class]]) {
        EtaoTuanSettingItem *tmp = [_datasource.items objectAtIndex:row];
        if([tmp.choosed isEqualToString:@"1"]){
            [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:YES];
            ((EtaoTuanSettingCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
            return nil;
        }
    }
    return indexPath;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    if([_datasource.items objectAtIndex:fromIndexPath.row]){
        EtaoTuanSettingItem * cell = [[_datasource.items objectAtIndex:fromIndexPath.row]retain];
        [_datasource.items removeObjectAtIndex:fromIndexPath.row];
        [_datasource.items insertObject:cell atIndex:toIndexPath.row];
        [cell release];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EtaoTuanSettingItem *cell = [_datasource.items objectAtIndex:indexPath.row];
    if ([cell.selected isEqualToString:@"0"]) {
        cell.selected = @"1";
        ((EtaoTuanSettingCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = NO;
    }
    else{
        cell.selected = @"0";
        ((EtaoTuanSettingCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = YES;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    EtaoTuanSettingItem *cell = [_datasource.items objectAtIndex:indexPath.row];
    if ([cell.selected isEqualToString:@"1"]) {
        cell.selected = @"0";
        ((EtaoTuanSettingCell*)[self.tableView cellForRowAtIndexPath:indexPath]).btnView.hidden = YES;
    } 
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    ET_DS_GROUPBUY_SETTING_STATUS status = [[change objectForKey:@"new"] intValue];
    switch (status) {
        case ET_DS_GROUPBUY_SETTING_OK:
            [self.tableView reloadData];
            break;
        case ET_DS_GROUPBUY_SETTING_LOADING:
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark -v Watch
/* 监视相关*/

- (void)watchWithKey:(NSString *)key{
    EtaoGroupBuySettingDataSource* datasource = (EtaoGroupBuySettingDataSource*)[[ETDataCenter dataCenter] getDataSourceWithKey:key];
    _datasource = datasource;
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
}

- (void)watchWithDatasource:(id)datasource{
    _datasource = datasource;
    [datasource addObserver:self 
                 forKeyPath:@"status" 
                    options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld 
                    context:nil];
}

@end
