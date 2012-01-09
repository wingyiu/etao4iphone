//
//  SearchDetailController.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchDetailController.h"
#import "SearchDetailSession.h"
#import "SearchDetailListItemViewCell.h"
#import "HTTPImageView.h"
#import "TBWebViewControll.h"
#import "EtaoShowAlert.h"
#import "ActivityIndicatorMessageView.h"
#import "etao4iphoneAppDelegate.h"
//图片圆边
#import <QuartzCore/QuartzCore.h>

//详细参数
#import "SearchDetailParametersController.h"
#import "SearchEvaluateController.h"

//跳外网提示
#import "EtaoAlertWhenInternetNotSupportWap.h"


@interface  SearchDetailController()
    -(void)initlizeSearchDetailSession;
    -(NSMutableArray*)getItemsArrayDataSource;
    -(int)getItemsArrayAllCount;
    -(UITableViewCell*)initlizeDetialProductViewCell:(NSString *)cellID;
    -(UITableViewCell*)initlizeDetialMoreParameterViewCell:(NSString *)cellID;
    -(UITableViewCell*)initlizeDetialUserCommentsViewCell:(NSString *)cellID;
@end


@implementation SearchDetailController

@synthesize detailTableView = _detailTableView;
//@synthesize detailDateSource = _detailDateSource;
@synthesize searchDetailSession = _searchDetailSession;
@synthesize delegate ;


//init with nib
- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        // Do something
    }
    return self;   
}


- (id)init {
    self = [super init];
    
    if (self) {
        // Initialization code here.
    }
    return self;
} 


- (id) initWithProduct:(NSDictionary*)dict {
	
	self = [super init];
    
    if (self) {
        // Initialization code here.
		[self initlizeSearchDetailSession];
        
		_searchDetailSession.dictParam = dict ;
    }
    return self;
	
}


- (id) initWithJson:(NSString*)json {
	
	self = [super init];
    
    if (self) {
        // Initialization code here.
        [self initlizeSearchDetailSession];
        
		_searchDetailSession.jsonStrin = json;
	}
    return self;
	
}


- (void) setJsonData:(NSString*)json {
    [self initlizeSearchDetailSession];
    _searchDetailSession.jsonStrin = json;
    [_searchDetailSession updateSessionByJsonDate:_searchDetailSession.jsonStrin];
    [_detailTableView reloadData];
}


-(void) initlizeSearchDetailSession {
    if(nil == _searchDetailSession) {
        _searchDetailSession = [[SearchDetailSession alloc] init];
        
        _searchDetailSession.sessionDelegate = self;
    }
}


- (void) loadView {
    [super loadView];
    
    if (nil == _detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,460)];//self.view.frame.size.height)];
        
        _detailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:_detailTableView];
        
        [_detailTableView setDelegate:self];
        [_detailTableView setDataSource:self];
    }
	
    [self initlizeSearchDetailSession];
    if ((_searchDetailSession.jsonStrin==nil) && (_searchDetailSession.dictParam!=nil)) {
        
        [self retain];
        
        ActivityIndicatorMessageView *loadv = [[[ActivityIndicatorMessageView alloc]initWithFrame:CGRectMake(120, 100, 80, 80) Message:@"正在加载"]autorelease];
        [loadv startAnimating];
        [self.view addSubview:loadv]; 
        [self.view bringSubviewToFront:loadv]; 
        self.detailTableView.hidden = YES;
        
        [_searchDetailSession requestSearchDetailDate];
    }
    
    [self setTitle:@"产品详情"];
}


- (void) viewWillAppear:(BOOL)animated {
    if(_searchDetailSession.jsonStrin!=nil) {
        
        //will call back SearchDetailRequestDidFinish
        [self retain];
        // if no retail .crush....
        [_searchDetailSession updateSessionByJsonDate:_searchDetailSession.jsonStrin];
    }
    [super viewWillAppear:animated];
}


- (void) SearchDetailRequestDidFinish:(NSObject *)obj {
    _isLoading = NO;
    
	ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)[self.view viewWithTag:ActivityIndicatorMessageView_TAG];
	if (loadv!=nil) { 
		[loadv stopAnimating];
	} 
	self.detailTableView.hidden = NO;
	
    if (_detailTableView.delegate != nil) {
        [_detailTableView reloadData];
    }
    
    // add by zhangsuntai for history
    UIApplication *app = [UIApplication sharedApplication];
    etao4iphoneAppDelegate *delgate= (etao4iphoneAppDelegate *)app.delegate; 
    ETaoHistoryViewController *his = [delgate etaoHistoryViewController];
    EtaoProductItem *item =  _searchDetailSession.SearchDetailProtocal._ProductItem;  
    NSString *json = [[item toDictionary] JSONRepresentation];
    [his addHistoryWithHash:[NSString stringWithFormat:@"%d",[item.pid hash]] Name:@"product" JSON:json];
    

    [self release];
}


-(NSMutableArray*)getItemsArrayDataSource {
    return _searchDetailSession.SearchDetailProtocal._items;
}


-(int)getItemsArrayAllCount {
    return _searchDetailSession.SearchDetailProtocal._totalCount;
}


- (void) SearchDetailRequestDidFailed:(NSObject *)obg {
	
    [self release];
    
	ActivityIndicatorMessageView * loadv = (ActivityIndicatorMessageView*)[self.view viewWithTag:ActivityIndicatorMessageView_TAG];
	if (loadv!=nil) { 
		[loadv stopAnimating];
	} 
	self.detailTableView.hidden = NO;
	
    //[EtaoShowAlert showAlert];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"网络不可用" message:@"无法与服务器通信，请连接到移动数据网络或者wifi." delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]autorelease];[alert show]; 
	
    _isLoading = NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if( _searchDetailSession.SearchDetailProtocal._ProductItem ) {
        return 2;
    }
    else {
        return 0;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if( section ==0 && _searchDetailSession.SearchDetailProtocal._ProductItem ) {
        return 3;
    }
    
    int totalCount = [self getItemsArrayAllCount];
    if (totalCount <= 0) {
        return 0;
    } else if ([[self getItemsArrayDataSource] count] < totalCount) {
        return [[self getItemsArrayDataSource] count] + 1;
    } else {
        return [[self getItemsArrayDataSource] count];
    }
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if(indexPath.row == 0) {
            CGSize constraint =CGSizeMake(300.0f, 20000.0f);
            CGSize titleSize = [_searchDetailSession.SearchDetailProtocal._ProductItem.title sizeWithFont:[UIFont systemFontOfSize:18]constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];

            return titleSize.height+100;
        }
        else if( indexPath.row == 2) {
            return 35;
        }
        else {
            return 30;
        }
    }
    else {
        return [SearchDetailListItemViewCell height];
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return 35;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        if (itemListHeadView == nil) {
            itemListHeadView = [[UIView alloc] initWithFrame:CGRectMake(20, 5, 200, 50)];
            
            UIImageView* imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"UserDetailListHeadBackGround.png"]];
            [imgView setFrame:CGRectMake(0, 0, 320, 35 )];
            
            [itemListHeadView addSubview:imgView];
            [imgView release];
            
            NSString *str = [self tableView:tableView titleForHeaderInSection:section];
            UILabel *label = nil;
            
            if (str != nil) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:16];
                [label setTextAlignment:UITextAlignmentCenter];
                label.text = str;
            }
            
            [itemListHeadView addSubview:label];
            [label release];
        }
        
        return itemListHeadView;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return [NSString stringWithFormat:@"同款比价(%d个商家)", [self getItemsArrayAllCount]];
    }

	return @"";
}


-(UITableViewCell*)initlizeDetialProductViewCell:(NSString *)cellID {
    
    UITableViewCell * cell = [_detailTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    else {
        for (UIView *v in [cell subviews]) {
            if( [v isKindOfClass:[UILabel class]] ||
                [v isKindOfClass:[HTTPImageView class]] ) {
                [v removeFromSuperview];
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *productTitle = [[UILabel alloc] init];
//    productTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    productTitle.backgroundColor = [UIColor clearColor];
	productTitle.font = [UIFont systemFontOfSize:18];
	productTitle.textColor = [UIColor blackColor]; 
	productTitle.numberOfLines = 2;
    productTitle.textAlignment = UITextAlignmentLeft; 
    productTitle.lineBreakMode = UILineBreakModeCharacterWrap;
    [productTitle setText:_searchDetailSession.SearchDetailProtocal._ProductItem.title];
    [cell addSubview:productTitle];
    
    CGSize constraint =CGSizeMake(300.0f, 20000.0f);
    CGSize titleSize = [productTitle.text sizeWithFont:[UIFont systemFontOfSize:18]constrainedToSize:constraint lineBreakMode:UILineBreakModeCharacterWrap];
    [productTitle setFrame:CGRectMake(10, 5, titleSize.width, titleSize.height)];
    [productTitle release];
                             
    HTTPImageView *httpImageView = [[HTTPImageView alloc]initWithFrame:CGRectMake(10, titleSize.height+10, 80, 80)];
    httpImageView.contentMode = UIViewContentModeScaleAspectFit;
    httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    
    NSString *picturl = [NSString stringWithFormat:@"%@_80x80.jpg",_searchDetailSession.SearchDetailProtocal._ProductItem.pictUrl];
    [httpImageView setUrl:picturl];
    NSLog(@"%@",picturl);
    CALayer *layer = [httpImageView layer];
    [layer setMasksToBounds:YES];
//    [layer setCornerRadius:5.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0] CGColor]];	 
    [cell addSubview: httpImageView]; 
    [httpImageView release];
    
    int offsetHeight = titleSize.height+2;
    
    if (_searchDetailSession.SearchDetailProtocal._ProductItem.priceListStr != nil && ![_searchDetailSession.SearchDetailProtocal._ProductItem.priceListStr isEqualToString:@""]) {
        NSLog(@"%@",_searchDetailSession.SearchDetailProtocal._ProductItem.priceListStr);
        NSArray *lines = [_searchDetailSession.SearchDetailProtocal._ProductItem.priceListStr componentsSeparatedByString:@";"]; 
        int idx = 0 ;
        float maxx = 0.0f; 
        for (NSString *line in lines) {
            NSArray *items = [line componentsSeparatedByString:@":"];
            if ([items count] == 2 ) {
                NSString *key = [NSString stringWithFormat:@"%@:",[items objectAtIndex:0]];  
                CGSize keysize = [key sizeWithFont:[UIFont systemFontOfSize:16]];  
                if (maxx < keysize.width) {
                    maxx = keysize.width;
                } 
            }
        }
        maxx += 2;
        for (NSString *line in lines) {
            NSArray *items = [line componentsSeparatedByString:@":"];
            if ([items count] == 2 ) {
                
                offsetHeight = titleSize.height+23+(19*idx);
                
                UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
                [rmbImgView setFrame:CGRectMake(95+maxx+2, titleSize.height+13+19*idx+5, 9, 11)];
                [cell addSubview:rmbImgView];
                
                NSString *key = [NSString stringWithFormat:@"%@:",[items objectAtIndex:0]];
                NSString *value = [NSString stringWithFormat:@"%1.2f",[[items objectAtIndex:1] floatValue]]; 
                
                CGSize valuesize = [value sizeWithFont:[UIFont systemFontOfSize:16]]; 
                UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:
                                        CGRectMake(95, titleSize.height+13+19*idx, maxx, 18)] autorelease];
                                        //CGRectMake(95, titleSize.height+5+(20*i), 200, 30)]
                priceLabel.backgroundColor = [UIColor clearColor];
                priceLabel.text = key;
                priceLabel.font = [UIFont systemFontOfSize:16]; 
                priceLabel.numberOfLines = 1 ;
                priceLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
                [cell addSubview:priceLabel];
                
                UILabel* priceLabel2 = [[[UILabel alloc ] initWithFrame:
                                         CGRectMake(95+maxx+15, titleSize.height+13+19*idx, valuesize.width+10, 18)] autorelease];
                priceLabel2.backgroundColor = [UIColor clearColor];
                priceLabel2.text = value;
                priceLabel2.font = [UIFont fontWithName:@"Arial-BoldMT" size:16]; 
                priceLabel2.numberOfLines = 1 ;
                priceLabel2.textColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0]; 
                [cell addSubview:priceLabel2];
                
                idx += 1 ;
                
                //offsetHeight += 20;
                
                if (idx >=2 ) {
                    break;
                }
            }
        }
    }

    else {
        
        offsetHeight = titleSize.height+5+20;
        
        UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
        [rmbImgView setFrame:CGRectMake(95+2, titleSize.height+10+12, 9, 11)];
        [cell addSubview:rmbImgView];
        
        UILabel *productPrice = [[UILabel alloc] initWithFrame:CGRectMake(95+15, titleSize.height+10, 200, 30)];
        productPrice.backgroundColor = [UIColor clearColor];
        productPrice.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        productPrice.textColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0]; 
        productPrice.numberOfLines = 1;
        productPrice.textAlignment = UITextAlignmentLeft; 
        
        [productPrice setText:[NSString stringWithFormat:@"%@",_searchDetailSession.SearchDetailProtocal._ProductItem.price]];
        [cell addSubview:productPrice];
        [productPrice release];
    }
    
    
    if(_searchDetailSession.SearchDetailProtocal._ProductItem.recommendSellerListStr) {
        NSArray* itemPricesArray = [_searchDetailSession.SearchDetailProtocal._ProductItem.recommendSellerListStr componentsSeparatedByString:@";"];
        //[itemPricesArray removeLastObject];
        
        int pricesArrayCount = [itemPricesArray count] -1; //去尾的分号生成的String。
        if (pricesArrayCount > 2) {
            pricesArrayCount = 2;
        }
        
        for (int i=0; i<pricesArrayCount; i++) {

            if((NSString*)[itemPricesArray objectAtIndex:i] == nil) {
                continue;
            }

            UILabel *productPriceListStr = [[UILabel alloc] initWithFrame:CGRectMake(100, offsetHeight+5+(16*i), 200, 30)];
            productPriceListStr.backgroundColor = [UIColor clearColor];
            productPriceListStr.font = [UIFont systemFontOfSize:13];
            productPriceListStr.textColor = [UIColor grayColor]; 
            productPriceListStr.numberOfLines = 2;
            productPriceListStr.textAlignment = UITextAlignmentLeft;
            
            NSString *price = @" ";
            NSArray* itemArray = [[itemPricesArray objectAtIndex:i] componentsSeparatedByString:@":"];
            NSString* itemPrice = [itemArray objectAtIndex:1];
            price = [itemArray objectAtIndex:0];
            price = [price stringByAppendingFormat:@"价:%.2f", [itemPrice floatValue]];
            
            [productPriceListStr setText:price];
            [cell addSubview:productPriceListStr];
            [productPriceListStr release];
        }
    }

    return cell;
}


-(UITableViewCell*)initlizeDetialMoreParameterViewCell:(NSString *)cellID {
    UITableViewCell * cell = [_detailTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        
        UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
        selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
        cell.selectedBackgroundView = selectedView; 
    }
    else {
        for (UIView *v in [cell subviews]) {
            if ([v isKindOfClass:[UILabel class]]) {
                [v removeFromSuperview];
            }
        }
    }
    
    UILabel *MoreParameterTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 220, 30)];
    MoreParameterTextLabel.backgroundColor = [UIColor clearColor];
	MoreParameterTextLabel.font = [UIFont systemFontOfSize:13];
	MoreParameterTextLabel.textColor = [UIColor grayColor]; 
	MoreParameterTextLabel.numberOfLines = 1;
    MoreParameterTextLabel.textAlignment = UITextAlignmentLeft; 
    
    NSCharacterSet *character = [NSCharacterSet characterSetWithCharactersInString:@";"];
    _searchDetailSession.SearchDetailProtocal._ProductItem.propListStr = [_searchDetailSession.SearchDetailProtocal._ProductItem.propListStr stringByTrimmingCharactersInSet:character]; 
    
    NSString* tempParamentTextStr = [_searchDetailSession.SearchDetailProtocal._ProductItem.propListStr stringByReplacingOccurrencesOfString:@";" withString:@" | "];
    
    [MoreParameterTextLabel setText:tempParamentTextStr];
    [cell addSubview:MoreParameterTextLabel];
    [MoreParameterTextLabel release];
    
    UILabel *MoreParameterButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 30)];
    MoreParameterButtonLabel.backgroundColor = [UIColor clearColor];
    MoreParameterButtonLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:13];
	MoreParameterButtonLabel.textColor = [UIColor colorWithRed:25/255.0 green:85/255.0 blue:141/255.0 alpha:1.0]; 
	MoreParameterButtonLabel.numberOfLines = 1;
    MoreParameterButtonLabel.textAlignment = UITextAlignmentLeft; 
    [MoreParameterButtonLabel setText:@"更多参数 >"];
    [cell addSubview:MoreParameterButtonLabel];
    [MoreParameterButtonLabel release];
    
    return cell;  
}


-(void) constructUserConmentsImgView:(UITableViewCell*) cell cmtScore: (float)pr {

    UIImage* imgStarOn = [UIImage imageNamed:@"star01.png"];
    UIImage* imgStarOff = [UIImage imageNamed:@"star03.png"];
    UIImage* imgStarHalf = [UIImage imageNamed:@"star02.png"];
    
    for (int i=0; i<5; i++) {
        
        UIImage* imgStar = nil;
        
        if (pr > (i+0.5)) {
            //on
            imgStar = imgStarOn;
        }
        else if(pr <= i) {
            //off
            imgStar = imgStarOff;
        }
        else {
            //half
            imgStar = imgStarHalf;
        }
        
        UIImageView* imgView = [[UIImageView alloc] initWithImage: imgStar];

        [imgView setFrame:CGRectMake(72+(15*i), 10, 12, 12 )];
                
        [cell addSubview:imgView];
        
        [imgView release];
    }
}


-(UITableViewCell*)initlizeDetialUserCommentsViewCell:(NSString *)cellID {
    UITableViewCell * cell = [_detailTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        
        UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
        selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
        cell.selectedBackgroundView = selectedView; 
    }
    else {
        for (UIView *v in [cell subviews]) {
            if ([v isKindOfClass:[UILabel class]] || [v isKindOfClass:[UIImageView class]] ) {
                [v removeFromSuperview];
            }
        }
    }
    
    UILabel *UserConmentsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 30)];
    UserConmentsTextLabel.backgroundColor = [UIColor clearColor];
	UserConmentsTextLabel.font = [UIFont systemFontOfSize:13];
	UserConmentsTextLabel.textColor = [UIColor grayColor]; 
	UserConmentsTextLabel.numberOfLines = 1;
    UserConmentsTextLabel.textAlignment = UITextAlignmentLeft; 
    
    [UserConmentsTextLabel setText:@"用户点评:"];
    [cell addSubview:UserConmentsTextLabel];
    [UserConmentsTextLabel release];
    
    
    //星星图片
    [self constructUserConmentsImgView: cell cmtScore:[_searchDetailSession.SearchDetailProtocal._ProductItem.cmtScore floatValue]];
    
    
    UILabel *ConmentsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(152, 0, 80, 30)];
    ConmentsTextLabel.backgroundColor = [UIColor clearColor];
	ConmentsTextLabel.font = [UIFont systemFontOfSize:13];
	ConmentsTextLabel.textColor = [UIColor grayColor]; 
	ConmentsTextLabel.numberOfLines = 1;
    ConmentsTextLabel.textAlignment = UITextAlignmentLeft; 
    
    [ConmentsTextLabel setText:[NSString stringWithFormat:@"%@/满分5.0...",_searchDetailSession.SearchDetailProtocal._ProductItem.cmtScore]];
   
    [cell addSubview:ConmentsTextLabel];
    [ConmentsTextLabel release];
    
    
    UILabel *MoreConmentsButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 30)];
    MoreConmentsButtonLabel.backgroundColor = [UIColor clearColor];
    MoreConmentsButtonLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:13];
	MoreConmentsButtonLabel.textColor = [UIColor colorWithRed:25/255.0 green:85/255.0 blue:141/255.0 alpha:1.0]; 
	MoreConmentsButtonLabel.numberOfLines = 1;
    MoreConmentsButtonLabel.textAlignment = UITextAlignmentLeft; 
    [MoreConmentsButtonLabel setText:@"用户点评 >"];
    [cell addSubview:MoreConmentsButtonLabel];
    
    if ([_searchDetailSession.SearchDetailProtocal._ProductItem.cmtCount intValue]<= 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [MoreConmentsButtonLabel setText:@"暂无点评"];
    }
    else {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    [MoreConmentsButtonLabel release];
    
    return cell;  

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *itemCellId = [NSString stringWithFormat:@"itemCell_%d%d",indexPath.section, indexPath.row];	
    
    if (indexPath.section == 0) {
        if(indexPath.row == 0) {
            return [self initlizeDetialProductViewCell:itemCellId];
        }
        else if(indexPath.row == 1) {
            return [self initlizeDetialMoreParameterViewCell:itemCellId];
        }
        else if(indexPath.row == 2) {
            return [self initlizeDetialUserCommentsViewCell:itemCellId];
        }
    }
    
    // section == 2....item list array
    else {
        static NSString *moreCellId = @"moreCell"; 
        NSUInteger row = [indexPath row];
        NSUInteger count = [[self getItemsArrayDataSource] count]; 
        
        if (row == count ) {
            
            UITableViewCell * cell = [_detailTableView dequeueReusableCellWithIdentifier:moreCellId];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId] autorelease];
                
                cell.textLabel.text = @"正在加载";
                cell.textLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
                cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
                cell.textLabel.textAlignment = UITextAlignmentCenter; 
                
                UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
                activityIndicator.frame = CGRectMake(cell.frame.size.width/2-60, (70-20)/2, 20.0f, 20.0f);
                //activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
                [cell addSubview:activityIndicator];
                [activityIndicator startAnimating]; 
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
                selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
                cell.selectedBackgroundView = selectedView;  

            }	 
            return cell;  
        }
        else 
        {  
            
            if ( [[[self getItemsArrayDataSource] objectAtIndex:row] isKindOfClass:[EtaoAuctionItem class] ]) {
                SearchDetailListItemViewCell * cell = nil;
                cell = (SearchDetailListItemViewCell*)[_detailTableView dequeueReusableCellWithIdentifier:itemCellId];
                if (cell == nil) {
                    cell = [[[SearchDetailListItemViewCell alloc]  initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:itemCellId] autorelease];  
                    EtaoAuctionItem *currentItem = (EtaoAuctionItem *)[[self getItemsArrayDataSource] objectAtIndex:row];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [cell set:currentItem];  
                    
                    UIView *selectedView = [[[UIView alloc] initWithFrame:cell.frame]autorelease];
                    selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
                    cell.selectedBackgroundView = selectedView;  

                }
                return cell;
                
            }
            //		else {
            //			EtaoProductViewCell *cell = nil;
            //			cell = (EtaoProductViewCell*)[self._tableView dequeueReusableCellWithIdentifier:itemCellId];
            //			if (cell == nil) {
            //				cell = [[[EtaoProductViewCell alloc]  initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:itemCellId] autorelease];  
            //				EtaoProductItem *currentItem = (EtaoProductItem *)[self._srpdata objectAtIndex:row];
            //				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //				[cell set:currentItem]; 
            //			}
            //			return cell;
            //		} 
        } 
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 	
    if(indexPath.section != 1) {
        return;
    }
    
	NSUInteger row = [indexPath row];
	NSUInteger count = [[self getItemsArrayDataSource] count];  
	
    if(row >= [self getItemsArrayAllCount] ) {
        //已经全拿完了
        return;
    }
        
    // load more
	if (row == count ) {
		
		if (_isLoading == YES) {
			return;
		} 
 		_isLoading = YES; 
        [self retain];

        //为了适应搜索直达，搜索列表是按照每页5条取的，详情页是按照10条去的。
        if (count%10 != 0) {
            int page = count/5;
            int countNum = 5;
            [_searchDetailSession loadMoreFrom: page+1 count:countNum];
        }
        else {
            //- (void) loadMoreFrom:(int)page count:(int)pageCount;
            [_searchDetailSession loadMoreFrom: count/10+1 count:10];
        }
	} 
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_detailTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if( indexPath.section == 0) {
        if (indexPath.row == 1) {
            SearchDetailParametersController* searchDetailParametersController = [[[SearchDetailParametersController alloc] init]autorelease];
            [searchDetailParametersController setDetaiParametersController:_searchDetailSession.SearchDetailProtocal._ProductItem.property];
            if (delegate!=nil && [delegate isKindOfClass:[UIViewController class]]) {  
				UIViewController *v = (UIViewController*)delegate;
                [v.navigationController pushViewController:searchDetailParametersController animated:YES];
			}
			else{
                [self.navigationController pushViewController:searchDetailParametersController animated:YES];
			}
            
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-MoreInfo"];
        }    
        else if(indexPath.row == 2) {
            //点评为0时，不跳转
            if ([_searchDetailSession.SearchDetailProtocal._ProductItem.cmtCount intValue]<= 0) {
                return;
            }
            
            SearchEvaluateController* searchEvaluateController = [[[SearchEvaluateController alloc] 
                                                                  initWithProduct:_searchDetailSession.dictParam]autorelease];
         
            if (delegate!=nil && [delegate isKindOfClass:[UIViewController class]]) {  
				UIViewController *v = (UIViewController*)delegate;
                [v.navigationController pushViewController:searchEvaluateController animated:YES];
			}
			else{
				[self.navigationController pushViewController:searchEvaluateController animated:YES];
			}
            
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-ItemComment"];
        }
    }
    else if( indexPath.section == 1) {
        if ( [[[self getItemsArrayDataSource] objectAtIndex:indexPath.row] isKindOfClass:[EtaoAuctionItem class] ]) {
            
            EtaoAuctionItem *currentItem = (EtaoAuctionItem *)[[self getItemsArrayDataSource] objectAtIndex:indexPath.row];

            TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:currentItem.link title:currentItem.title type:[currentItem.userType intValue] isSupportWap:[currentItem.isLinkWapUrl boolValue]] autorelease];
            
            webv.hidesBottomBarWhenPushed = YES;
			if (delegate!=nil && [delegate isKindOfClass:[UIViewController class]]) {  
				UIViewController *v = (UIViewController*)delegate;
				[v.navigationController pushViewController:webv animated:YES];
			}
			else{
				[self.navigationController pushViewController:webv animated:YES];
			}
            
            [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-SelectIndex"];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void) dealloc {
    
    _detailTableView.delegate = nil;
    _detailTableView.dataSource = nil;
    
    [_detailTableView release];
    
    [_searchDetailSession release];
    [itemListHeadView release];

    [super dealloc];
}

    
@end
