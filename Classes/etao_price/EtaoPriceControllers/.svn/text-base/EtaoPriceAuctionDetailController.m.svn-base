//
//  EtaoPriceAuctionDetailController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceAuctionDetailController.h"
#import "ETHttpImageView.h"

@implementation EtaoPriceAuctionDetailController
@synthesize item = _item;
@synthesize tableView = _tableView ;

 

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView {
    [super loadView];
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0,0,320,370) style:UITableViewStylePlain]autorelease];
    [self.view addSubview:_tableView];
    _tableView.delegate = self ;
    _tableView.dataSource = self; 
    [self loadFoot];
    
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

- (id)initWithItem:(id)item{
    self = [self init];
    self.item = item;
    return self;
}

- (void) setDetailFromItem:(id) item {
    if ([item isKindOfClass:[EtaoPriceAuctionItem class]]) {
        self.item = item; 
        [self.tableView reloadData];
        
        UIView *foot = [[[UIView alloc]initWithFrame:CGRectMake(0, 370, 310, 44)]autorelease];
        foot.backgroundColor = [UIColor whiteColor];
        
        UIFont *detailFont = [UIFont systemFontOfSize:13];
        UIColor *detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
        //logo
        ETHttpImageView* logo = [[[ETHttpImageView alloc]init]autorelease]; 
        logo.contentMode = UIViewContentModeScaleAspectFit;
        [logo setFrame:CGRectMake(0, 0, 80 , 50)]; 
        [logo load:[NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@",_item.logo]];
        
        //shopinfo
        UILabel* shopLabel = [[[UILabel alloc ]initWithFrame:CGRectMake(100,0,110, 50)] autorelease];    
        if ([_item.sellerType isEqualToString:@"0"] ) {
            shopLabel.text = [NSString stringWithFormat:@"淘宝网 %@",_item.nickName];
        }
        else if ([_item.sellerType isEqualToString:@"1"] ) {
            shopLabel.text = [NSString stringWithFormat:@"淘宝商城 %@",_item.nickName];
        }
        else {
            shopLabel.text = _item.nickName;
        }
        shopLabel.textAlignment = UITextAlignmentCenter;
        shopLabel.font = detailFont;
        shopLabel.numberOfLines = 1 ;
        shopLabel.textColor = detailColor;
        
        //goseesee
        UILabel* goseeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(210, 10, 80, 32)]autorelease]; 
        [goseeLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_goseesee3.png"]]];
        goseeLabel.text = @"去看看";
        goseeLabel.textColor = [UIColor whiteColor];
        goseeLabel.font = [UIFont systemFontOfSize:16];
        goseeLabel.textAlignment = UITextAlignmentCenter;
        
        //arrow
        [foot  addSubview:shopLabel];
        [foot  addSubview:logo];
        [foot  addSubview:goseeLabel];
        
        [self.view addSubview:foot];
        
    }
}

- (void)loadFoot{
    UIView *foot = [[[UIView alloc]initWithFrame:CGRectMake(0, 370, 310, 44)]autorelease];
    foot.backgroundColor = [UIColor whiteColor];
    
    UIFont *detailFont = [UIFont systemFontOfSize:13];
    UIColor *detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
    //logo
    ETHttpImageView* logo = [[[ETHttpImageView alloc]init]autorelease]; 
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [logo setFrame:CGRectMake(0, 0, 80 , 50)]; 
    [logo load:[NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@",_item.logo]];
    
    //shopinfo
    UILabel* shopLabel = [[[UILabel alloc ]initWithFrame:CGRectMake(100,0,110, 50)] autorelease];    
    if ([_item.sellerType isEqualToString:@"0"] ) {
        shopLabel.text = [NSString stringWithFormat:@"淘宝网 %@",_item.nickName];
    }
    else if ([_item.sellerType isEqualToString:@"1"] ) {
        shopLabel.text = [NSString stringWithFormat:@"淘宝商城 %@",_item.nickName];
    }
    else {
        shopLabel.text = _item.nickName;
    }
    shopLabel.textAlignment = UITextAlignmentCenter;
    shopLabel.font = detailFont;
    shopLabel.numberOfLines = 1 ;
    shopLabel.textColor = detailColor;
    
    //goseesee
    UILabel* goseeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(210, 10, 80, 32)]autorelease]; 
    [goseeLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_goseesee3.png"]]];
    goseeLabel.text = @"去看看";
    goseeLabel.textColor = [UIColor whiteColor];
    goseeLabel.font = [UIFont systemFontOfSize:16];
    goseeLabel.textAlignment = UITextAlignmentCenter;
    
    //arrow
    [foot  addSubview:shopLabel];
    [foot  addSubview:logo];
    [foot  addSubview:goseeLabel];
    
    [self.view addSubview:foot];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    if (_item == nil) {
        return  0;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = [indexPath row];
    switch (row) {
        case 0:
            return 280;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 60;
            break;
        case 3:
            return 200;
            break;
        default:
            break;
    }
    return 0 ;
}

-(void)item2cell:(EtaoPriceAuctionItem *)item toCell:(UITableViewCell *)cell inPath: (NSIndexPath *)indexPath{

    UIFont *titleFont = [UIFont systemFontOfSize:16];
    UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    UIFont *priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ;
    //UIFont *uptimeFont = [UIFont systemFontOfSize:12];
    //UIColor *uptimeColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
    
    UIColor *detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
    
    for (UIView *v in [cell subviews] ){
        [v removeFromSuperview];
    }
    
    if ([indexPath row] == 0 ) {

        /* 商品图片 */
        ETHttpImageView *imageBGView = [[[ETHttpImageView alloc]initWithFrame:CGRectMake(35, 15, 250, 250)]autorelease]; 
        NSString *url = [NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@",_item.image];
        imageBGView.contentMode = UIViewContentModeScaleAspectFit;[imageBGView load:url];
        [cell addSubview:imageBGView]; 
    }
    if ([indexPath row] == 1 ) {
        /*  商品详情  */ 
        //标题label
        UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(15, 0, 260, 45)] autorelease];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [NSString stringWithFormat:@"%@",_item.title];
        titleLabel.font = titleFont;
        titleLabel.textColor = titleColor;
        titleLabel.textAlignment = UITextAlignmentLeft ;
        titleLabel.numberOfLines = 2;
        [cell addSubview:titleLabel];
         
    }
    if ([indexPath row] == 2 ) { 

        
        //价格label
        NSString *price = [NSString stringWithFormat:@"%1.2f",[_item.productPrice floatValue]];
        UIImageView *priceIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rmb_price.png"]]autorelease];
        [priceIcon setFrame:CGRectMake(15, 9, 9, 11)];
        UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(26, 0, 110, 30)] autorelease];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.text = [NSString stringWithFormat:@"%@",price];
        priceLabel.font = priceFont;
        priceLabel.numberOfLines = 1 ;
        priceLabel.textColor = priceColor;
        
        //原价label
        NSString *orgPrice = [NSString stringWithFormat:@"¥%1.2f",[_item.lowestPrice floatValue]];
        int word_count = orgPrice.length;
        UILabel* orgPriceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(130, 9, word_count*9, 13)] autorelease];
        UIView* line = [[[UIView alloc]initWithFrame:CGRectMake(0,6, word_count*8, 1)]autorelease];
        [line setBackgroundColor:[UIColor grayColor]];
        [orgPriceLabel addSubview:line];
        orgPriceLabel.backgroundColor = [UIColor clearColor];
        orgPriceLabel.textAlignment = UITextAlignmentLeft;
        orgPriceLabel.font = [UIFont systemFontOfSize:15];
        orgPriceLabel.textColor = detailColor;
        orgPriceLabel.text = [NSString stringWithFormat:@"%@",orgPrice];
        orgPriceLabel.numberOfLines = 1 ;
        
        //折扣label
        float dist = [_item.productPrice floatValue]*10/[_item.lowestPrice floatValue];
        UILabel* distLabel = [[[UILabel alloc]initWithFrame:CGRectMake(210,9, 60, 13)]autorelease];
        UIImageView* distIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"etao_discount.png"]]autorelease];
        [distLabel addSubview:distIcon];
        distLabel.text = [NSString stringWithFormat:@"  %.1f折",dist];
        distLabel.textAlignment = UITextAlignmentCenter;
        distLabel.textColor = detailColor;
        distLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:priceIcon];
        [cell addSubview:priceLabel];
        [cell addSubview:orgPriceLabel];
        [cell addSubview:distLabel];
        
    }
    if ([indexPath row] == 4 ) {  
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone ;
        cell.accessoryView = nil ;
    }
    
    // Configure the cell...
    [self item2cell:_item toCell:cell inPath:indexPath];
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
