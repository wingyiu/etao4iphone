//
//  EtaoLocalDiscountDetailController.m
//  etao4iphone
//
//  Created by zhangsuntai on 11-8-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalDiscountDetailController.h"
#import "HTTPImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIDeleteLineLabel.h" 
#import "TBWebViewControll.h"
#import "EtaoLocalDiscountMapController.h"
#import "TBWebViewController.h"
#import "TBWebViewControll.h"


@interface EtaoLocalDiscountDetailController()
    
-(void)initButtomInfoView;
    
@end

@implementation EtaoLocalDiscountDetailController

@synthesize item;  
@synthesize userLocation;
@synthesize infoView;

@synthesize tableview = _tableview;

#pragma mark -
#pragma mark Initialization

#pragma mark -
#pragma mark View lifecycle


- (void) loadView {
    [super loadView];
    
    self.tableview = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-45)]autorelease];   
	_tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   
	[_tableview setDelegate:self];  
	[_tableview setDataSource:self];
	
    [self.view addSubview:_tableview];

    _tableview.separatorStyle = NO;
    _tableview.allowsSelection = NO;
    
    UIView *bg = [[UIView alloc] initWithFrame:_tableview.frame];
    [bg setBackgroundColor:[UIColor whiteColor]];

    [_tableview setBackgroundView:bg];
    [bg release];
    
    [self initButtomInfoView];
}

- (void)viewDidLoad {  
	[super viewDidLoad];  
}

#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            return 52;
        }
        else {
            return 190;
        }
    } 
    
    else if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            return 40;
        }
        else if(indexPath.row == 1) {
            return 40;
        }
        else if(indexPath.row == 2) {
            return 40;
        }
        else if(indexPath.row == 3) {
            return 10;
        }
    }
    
    else if(indexPath.section == 2) {
        return 80;    
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog(@"%s", __FUNCTION__);
	// Return the number of sections.
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%s", __FUNCTION__); 
    
    if (section == 0) {
        return 2;
    }
    else if(section == 1) {
        return 4 ;
    }
    
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%s", __FUNCTION__);
	NSLog(@"indexpath %@",indexPath);
	// NSUInteger section = [indexPath section];
    
    //getting a cell
    NSString *id = [NSString stringWithFormat:@"%d%d", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    
    if(cell == nil) {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"] autorelease];
    }else {
        for (UIView *v in [cell subviews]) {
            if ([v isKindOfClass:[UILabel class]] || [v isKindOfClass:[UIImageView class]] 
                || [v isKindOfClass:[HTTPImageView class]] || [v isKindOfClass:[UIButton class]]) {
                [v removeFromSuperview];
            }
        }
    }
    
//    for(UIView *sub in [cell subviews])
//    {
//        if(sub.tag == 10)
//        {
//            [sub removeFromSuperview];
//        }
//    }

    //TITLE AND PIC
    if (indexPath.section == 0) {
        
        //title
        if (indexPath.row == 0) {
            
            UILabel *itemDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 16)];
            itemDiscountLabel.text = [NSString stringWithFormat:@"%@折", self.item.itemDiscount];
            itemDiscountLabel.numberOfLines = 1;
            itemDiscountLabel.textColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0];
            itemDiscountLabel.font = [UIFont systemFontOfSize:14];
            //[itemTitleLabel sizeToFit];
            //	itemTitleLabel.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
            itemDiscountLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemDiscountLabel];
            [itemDiscountLabel release];
            
            //	NSString *space = [NSString stringWithString:@"            "];
            //	NSString *str = [NSString stringWithFormat:@"%@折",self.item.itemTitle];
            
            //	UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 32)];
            //	itemTitleLabel.text = [NSString stringWithFormat:@"%@...", self.item.itemTitle];
            //
            
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 32)];
            itemTitleLabel.text = [NSString stringWithFormat:@"         %@...", self.item.itemTitle];
            itemTitleLabel.numberOfLines = 2;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:14];
            //[itemTitleLabel sizeToFit];
            //	itemTitleLabel.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
            
            return cell;
        }
        //piction 300*180
        else if(indexPath.row == 1) {
            HTTPImageView *httpImageView = [[HTTPImageView alloc] initWithFrame: CGRectMake(10, 3, 300, 180)];
            httpImageView.contentMode = UIViewContentModeScaleToFill;
            httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"]; 
            [httpImageView setUrl:self.item.itemImageURL]; 
            
            [cell addSubview: httpImageView];
            [httpImageView release];
            
            return cell;
        }
    }
    
    //info
    else if (indexPath.section == 1) {
        
        //title
        if (indexPath.row == 0) {
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
            itemTitleLabel.text = [NSString stringWithFormat:@"商户：%@", self.item.shopName];
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            //[itemTitleLabel sizeToFit];
            //	itemTitleLabel.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
            
            return cell;
        }
        //
        else if(indexPath.row == 1) {
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 230, 30)];
            itemTitleLabel.text = [NSString stringWithFormat:@"电话：%@", self.item.shopTelephone];
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            //[itemTitleLabel sizeToFit];
            //	itemTitleLabel.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
            
            UIButton* dailNumButton = [[[UIButton alloc] initWithFrame:CGRectMake(250, 5, 60, 30)]autorelease];
            [dailNumButton setTitle:@"拨打电话" forState:UIControlStateNormal];
            [dailNumButton setTitleColor:[UIColor colorWithRed:33/255.0f green:141/255.0f blue:180/255.0f alpha:1.0] forState:UIControlStateNormal];
            dailNumButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [dailNumButton setBackgroundColor:[UIColor clearColor]];
            
            [dailNumButton addTarget:self action:@selector(actionPhone) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview: dailNumButton];
            
            return cell;
        }
        //
        else if(indexPath.row == 2) {
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 230, 30)];
            itemTitleLabel.text = [NSString stringWithFormat:@"地址：%@", self.item.shopAddress];
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            //[itemTitleLabel sizeToFit];
            //	itemTitleLabel.backgroundColor =[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
            
            UIButton* dailNumButton = [[[UIButton alloc] initWithFrame:CGRectMake(250, 5, 60, 30)]autorelease];
            [dailNumButton setTitle:@"查看地图" forState:UIControlStateNormal];
            [dailNumButton setTitleColor:[UIColor colorWithRed:33/255.0f green:141/255.0f blue:180/255.0f alpha:1.0] forState:UIControlStateNormal];
            dailNumButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [dailNumButton setBackgroundColor:[UIColor clearColor]];
            
            [dailNumButton addTarget:self action:@selector(showTheWay) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview: dailNumButton];
            
            return cell;
        }
        //空10像素，补差
        else if(indexPath.row == 3) {
        
            return cell;
        }
    }
    
    return nil; 
}


-(void)initButtomInfoView {

    UIView* bottomInfoView = [[UIView alloc] initWithFrame:CGRectMake(0,370,320,50)];
    [bottomInfoView setBackgroundColor:[UIColor colorWithRed:27/255.0f green:27/255.0f blue:27/255.0f alpha:1.0f]];
    
    UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_wight.png"]] autorelease];
    [rmbImgView setFrame:CGRectMake(10, 17, 12, 18)];
    [bottomInfoView addSubview:rmbImgView];
    
    UILabel *priceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 0, 120, 50)]autorelease];
    priceLabel.text = self.item.itemPresentPrice;
    priceLabel.numberOfLines = 1;
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont systemFontOfSize:28];
    priceLabel.backgroundColor = [UIColor clearColor];
    [bottomInfoView addSubview: priceLabel];
    
    CGRect textRect = [priceLabel textRectForBounds:priceLabel.frame limitedToNumberOfLines:priceLabel.numberOfLines];

//已卖多少笔，下个版本出现，预留
//    UILabel *beenSoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 120, 50)];
//    beenSoldLabel.text = [NSString stringWithFormat:@"%@笔", self.item.itemPresentPrice];
//    beenSoldLabel.numberOfLines = 1;
//    beenSoldLabel.textColor = [UIColor whiteColor];
//    beenSoldLabel.font = [UIFont systemFontOfSize:28];
//    beenSoldLabel.backgroundColor = [UIColor clearColor];
//    [bottomInfoView addSubview: beenSoldLabel];
//    [beenSoldLabel release];
   
    UIImageView* distanceImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"groupBuyDistance.png"]] autorelease];
    [distanceImgView setFrame:CGRectMake(30+textRect.size.width+10, 20, 10, 12)];
    [bottomInfoView addSubview:distanceImgView];
    
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+textRect.size.width+10+15, 0, 120, 50)];
    distanceLabel.numberOfLines = 1;
    distanceLabel.textColor = [UIColor whiteColor];
    distanceLabel.font = [UIFont systemFontOfSize:13];
    distanceLabel.backgroundColor = [UIColor clearColor];
    [bottomInfoView addSubview: distanceLabel];
    
    if(nil == self.item.shopDistance || [self.item.shopDistance isEqualToString:@""]) { 
        [distanceLabel setText:@"无法获取距离"];  
        }
    else {
        NSString *distanceStr;
        if ([self.item.shopDistance doubleValue] > 1) {
            distanceStr = [NSString stringWithFormat:@"约%1.2f公里",[self.item.shopDistance floatValue] ];
            
        }else { 
            distanceStr = [NSString stringWithFormat:@"约%g米",[self.item.shopDistance floatValue]*1000];
        }
        
        [distanceLabel setText:distanceStr];  
    }
    
    [distanceLabel release];
    
    
    UIButton* goToSeeButton = [[[UIButton alloc] initWithFrame:CGRectMake(240, 7, 70, 35)]autorelease];
    [goToSeeButton setBackgroundImage:[UIImage imageNamed:@"groupBuyGoAndSee.png"] forState:UIControlStateNormal];
    [goToSeeButton setTitle:@"去看看" forState:UIControlStateNormal];
    [goToSeeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomInfoView addSubview:goToSeeButton];
    
    [goToSeeButton addTarget:self action:@selector(gotoWeb) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomInfoView];
    [bottomInfoView release];
}


-(IBAction)gotoWeb {
	NSLog(@"%s", __FUNCTION__); 
	
    TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:item.itemURL title:item.title type:-1 isSupportWap:NO] autorelease];
    
    webv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webv animated:YES];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-JumpWebPage"];
} 

- (void)showTheWay {
    
    //添加查询路线代码
    [self showMapMode];
    
    NSString *flatlong = [NSString stringWithFormat:@"%@,%@", self.item.locationLatitude, self.item.locationLongitude];
    NSString *tlatlong = [NSString stringWithFormat:@"%f,%f", self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude];
    NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@", [tlatlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[flatlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  	
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-LookMap"];
}

 

- (void)showLoaction {
    EtaoLocalDiscountMapController *maploc = [[[EtaoLocalDiscountMapController alloc] init]autorelease];
    [maploc locate:self.item];
    [self.navigationController pushViewController:maploc animated:YES];
}
 

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = [NSString stringWithString:@""];
	return title;
}

 
#pragma mark -
#pragma mark Memory management


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	NSLog(@"%s", __FUNCTION__);
}


- (void)dealloc {
    [item release];
    [_tableview release];
    [super dealloc];
}


- (void)showMapMode {
	NSLog(@"%s", __FUNCTION__);
	if (self.userLocation == nil) {
		UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘" 
														  message:@"您需要打开定位功能来使用该功能" 
														 delegate:nil 
												cancelButtonTitle:@"OK" 
												otherButtonTitles:nil] autorelease];
		[alert show];
		return ;
	}  
}


- (void)actionPhone{
	UIActionSheet *phoneActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打电话" otherButtonTitles:nil];
	phoneActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[phoneActionSheet showInView:[self.view window]];
	[phoneActionSheet release]; 	
	 
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-TeleCall"];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (0 == buttonIndex) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.item.shopTelephone]]];
	}
}


@end

