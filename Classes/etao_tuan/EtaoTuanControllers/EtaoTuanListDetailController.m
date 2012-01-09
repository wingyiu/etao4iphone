//
//  EtaoTuanListDetailController.m
//  etao4iphone
//
//  Created by  on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import "EtaoTuanListDetailController.h"
#import "HTTPImageView.h"
#import "TBMemoryCache.h"
#import "TBWebViewControll.h"
#import "EtaoTuanHomeViewController.h"
#import "EtaoTimeLabel.h"

@implementation EtaoTuanListDetailController

@synthesize item = _item;
@synthesize userLocation = _userLocation;
@synthesize tableView = _tableView;

-(void)dealloc{

    [[EtaoTimerController sharedTimeLabelPointerArray]removeObject:_timeLabel];
    if(_item != nil){[_item release];_item = nil;}
    [_tableView release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if(self)
    {
        CLLocationCoordinate2D tmp = {0,0};
        _userLocation = tmp;
        return  self;
    }
    return nil;
}

-(void)loadView{
    [super loadView];
    
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 370)]autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = NO;
    
    [self.view addSubview:self.tableView];
    
    [self loadFoot];
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark 去看看
- (void)gotoWeb:(id)sender{	
    TBWebViewControll *webv;
    if ([_item.wapLink isEqualToString:@""] || _item.wapLink==nil) {
        webv = [[[TBWebViewControll alloc] initWithURLAndType:_item.link title:_item.title type:-1 isSupportWap:NO] autorelease];
    }
    else{
        webv = [[[TBWebViewControll alloc] initWithURLAndType:_item.wapLink title:_item.title type:-1 isSupportWap:NO] autorelease];
    }
    webv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webv animated:YES];
} 

- (void)loadFoot{
    
    UIView* bottomInfoView = [[[UIView alloc] initWithFrame:CGRectMake(0,370,320,50)]autorelease];
    [bottomInfoView setBackgroundColor:[UIColor colorWithRed:27/255.0f green:27/255.0f blue:27/255.0f alpha:1.0f]];
    
    UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_wight.png"]] autorelease];
    [rmbImgView setFrame:CGRectMake(10, 17, 12, 18)];
    [bottomInfoView addSubview:rmbImgView];
    
    UILabel *priceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 0, 120, 50)]autorelease];
    priceLabel.text = _item.price;
    priceLabel.numberOfLines = 1;
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont systemFontOfSize:28];
    priceLabel.backgroundColor = [UIColor clearColor];
    [bottomInfoView addSubview: priceLabel];
    
    CGRect textRect = [priceLabel textRectForBounds:priceLabel.frame limitedToNumberOfLines:priceLabel.numberOfLines];
    
    //折扣
    UIImageView* salesImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"etao_discount.png"]] autorelease];
    [salesImgView setFrame:CGRectMake(30+textRect.size.width+10, 20, 13, 13)];
    [bottomInfoView addSubview:salesImgView];
    
    UILabel *beenSoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+textRect.size.width+15+20, 0, 120, 50)];
    beenSoldLabel.text = [NSString stringWithFormat:@"%1.2f折", [_item.rate floatValue]];
    beenSoldLabel.numberOfLines = 1;
    beenSoldLabel.textColor = [UIColor whiteColor];
    beenSoldLabel.font = [UIFont systemFontOfSize:13];
    beenSoldLabel.backgroundColor = [UIColor clearColor];
    [bottomInfoView addSubview: beenSoldLabel];
    [beenSoldLabel release];
    
    CGRect textRect2 = [beenSoldLabel textRectForBounds:beenSoldLabel.frame limitedToNumberOfLines:beenSoldLabel.numberOfLines];
    
    UIImageView* distanceImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_black_people.png"]] autorelease];
    [distanceImgView setFrame:CGRectMake(30+textRect.size.width+10+15+textRect2.size.width+25, 20, 13, 13)];
    [bottomInfoView addSubview:distanceImgView];
    
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+textRect.size.width+10+15+textRect2.size.width+20+25, 0, 120, 50)];
    distanceLabel.numberOfLines = 1;
    distanceLabel.textColor = [UIColor whiteColor];
    distanceLabel.font = [UIFont systemFontOfSize:13];
    distanceLabel.backgroundColor = [UIColor clearColor];
    [bottomInfoView addSubview: distanceLabel];
    [distanceLabel setText:_item.sales];   
    [distanceLabel release];
    
    UIButton* goToSeeButton = [[[UIButton alloc] initWithFrame:CGRectMake(240, 7, 70, 35)]autorelease];
    [goToSeeButton setBackgroundImage:[UIImage imageNamed:@"groupBuyGoAndSee.png"] forState:UIControlStateNormal];
    [goToSeeButton setTitle:@"去看看" forState:UIControlStateNormal];
    [goToSeeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomInfoView addSubview:goToSeeButton];
    goToSeeButton.tag = [_item.wapLink integerValue];
    [goToSeeButton addTarget:self action:@selector(gotoWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:bottomInfoView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            return 72;
        }else{
            return 190;
        }
    }
    else if(1 == indexPath.section){
        if (indexPath.row>=0 && indexPath.row<=3) {
            return 40;
        }
        else if(4 == indexPath.row){
            return 10;
        }
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 2;
    }
    else if(1 == section){
        return 5;
    }
    
    return 0;
}

- (void) setDetailFromItem:(id) item {
    if ([item isKindOfClass:[EtaoTuanAuctionItem class]]) {
        self.item = item;
//        [self initButtomInfoView];
        [self.tableView reloadData];
    }
}

- (id)initWithItem:(id)item{
    self = [self init];
    self.item = item;
    return  self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *id = [NSString stringWithFormat:@"%d%d", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id]autorelease];
    }else{
        for (UIView *v in [cell subviews]) {
            if ( [v isKindOfClass:[EtaoTimeLabel class]] ||
                [v isKindOfClass:[UILabel class]] ||[v isKindOfClass:[UIImageView class]] ||
                [v isKindOfClass:[HTTPImageView class]] || [v isKindOfClass:[UIButton class]]) {
                [[EtaoTimerController sharedTimeLabelPointerArray]removeObject:v];
                [v removeFromSuperview];
            }
        }
    }
    
    [self item2cell:_item toCell:cell inPath:indexPath];
    return cell;
}

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

-(void)item2cell:(EtaoTuanAuctionItem *)item toCell:(UITableViewCell *)cell inPath: (NSIndexPath *)indexPath{
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            UIFont *titleFont = [UIFont systemFontOfSize:14];
            UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            UIFont *webTitleFont = [UIFont systemFontOfSize:15];
            UIColor *webTitleColor = [UIColor colorWithRed:33/255.0f green:142/255.0f blue:181/255.0f alpha:1.0];
            
            CGSize sizeWebTitle = [[NSString stringWithFormat:@"%@",item.webName] sizeWithFont:titleFont];
            UILabel *webTitleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 10, sizeWebTitle.width+10, 16)] autorelease];
            webTitleLabel.font = webTitleFont;
            webTitleLabel.backgroundColor = [UIColor clearColor];
            webTitleLabel.textColor = webTitleColor;
            webTitleLabel.numberOfLines = 1;
            webTitleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            webTitleLabel.text = [NSString stringWithFormat:@"%@",item.webName]; 
            
            UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(10, 10, 300, 60)] autorelease];
            NSMutableString *tmpStr = [[[NSMutableString alloc]initWithCapacity:1]autorelease];
            CGSize sizeBlank = [[NSString stringWithFormat:@"%@",@" "] sizeWithFont:titleFont];
            for (int i=0; i<=sizeWebTitle.width/sizeBlank.width+3; i++) {
                [tmpStr appendString:@" "];
            }
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = [NSString stringWithFormat:@"%@%@",tmpStr,[item titleStr]];    
            titleLabel.font = titleFont;
            titleLabel.textColor = titleColor;
            titleLabel.textAlignment = UITextAlignmentLeft ;
            titleLabel.numberOfLines = 3;
            titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
            //首行顶对齐
            CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
            [titleLabel setFrame:CGRectMake(10, 10, textRect.size.width, textRect.size.height)];
            [cell addSubview: titleLabel];
            [cell addSubview: webTitleLabel];
        }
        else if(1 == indexPath.row){
            HTTPImageView *httpImageView = [[HTTPImageView alloc] initWithFrame: CGRectMake(10, 3, 300, 180)];
            TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
            httpImageView.memoryCache = memoryCache ;
            httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_330x330.png"];
            NSString *picturl = [NSString stringWithFormat:@"http://img03.taobaocdn.com/bao/uploaded/i3/%@.jpg",item.image];
            
            [httpImageView setUrl:picturl]; 
            [httpImageView setFrame:CGRectMake(10, 3, 300, 180)];
            [httpImageView setContentMode:UIViewContentModeScaleToFill];
            [httpImageView setTransform:CGAffineTransformMakeScale(1, 0.96)];
            
            UIImageView *timeView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"time.png"]]autorelease]; 
            timeView.frame = CGRectMake(6, 7, 130, 40);
            
            UIImageView *clock = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock.png"]]autorelease];
            clock.frame = CGRectMake(6, 10, 14, 14);
            [timeView addSubview:clock];
            
            
            EtaoTimeLabel *timerLabel = [[EtaoTimeLabel alloc]initWithFrame:CGRectMake(20, 16, 110, 14)];
            [[EtaoTimerController sharedTimeLabelPointerArray]addObject:timerLabel];
            _timeLabel = timerLabel;
            timerLabel.textColor = [UIColor whiteColor];
            [timerLabel setBackgroundColor:[UIColor clearColor]];
            timerLabel.font = [UIFont systemFontOfSize:12];
            timerLabel.textAlignment = UITextAlignmentCenter;
            timerLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            timerLabel.item = item;
            [timerLabel showLabelText];

            [cell addSubview: httpImageView];
            [cell addSubview: timeView];
            [cell addSubview: timerLabel];
            [timerLabel release];
            [httpImageView release];

        }
    }
    else if(1 == indexPath.section){
        if (0 == indexPath.row) {
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
            if (item.merchantName != nil) {
                itemTitleLabel.text = [NSString stringWithFormat:@"商户：%@", item.merchantName];
            }
            else{
                itemTitleLabel.text = [NSString stringWithFormat:@"商户：%@", @""];
            }
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
        }
        else if(1 == indexPath.row){
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
                
            if(nil == _item.extInfo || [_item.extInfo isEqualToString:@""] || [_item.hasLbs isEqualToString:@"0"]) { 
                [itemTitleLabel setText:@"距离：无法获取距离"];  
            }
            else {
                NSString *distanceStr;
                if ([_item.extInfo doubleValue] > 1) {
                    distanceStr = [NSString stringWithFormat:@"距离：约%1.2f公里",[_item.extInfo floatValue] ];
                    
                }else { 
                    distanceStr = [NSString stringWithFormat:@"距离：约%g米",[_item.extInfo floatValue]*1000];
                }
                
                [itemTitleLabel setText:distanceStr];  
            }
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
        }
        else if(2 == indexPath.row){
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 230, 30)];
            if (item.merchantTel != nil) {
                itemTitleLabel.text = [NSString stringWithFormat:@"电话：%@", item.merchantTel];
            }else
            {
                itemTitleLabel.text = [NSString stringWithFormat:@"电话：%@", @""];
            }
            
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
            
            UIButton* dailNumButton = [[[UIButton alloc] initWithFrame:CGRectMake(240, 6, 60, 30)]autorelease];
            [dailNumButton setTitle:@"拨打电话" forState:UIControlStateNormal];
            [dailNumButton setTitleColor:[UIColor colorWithRed:33/255.0f green:141/255.0f blue:180/255.0f alpha:1.0] forState:UIControlStateNormal];
            dailNumButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [dailNumButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
            [dailNumButton setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateSelected];
            
            [dailNumButton addTarget:self action:@selector(actionPhone) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview: dailNumButton];
        }
        else if(3 == indexPath.row){
            UILabel *itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 230, 30)];
            if (item.merchantAddr != nil) {
                 itemTitleLabel.text = [NSString stringWithFormat:@"地址：%@", item.merchantAddr];
            }
            else{
                itemTitleLabel.text = [NSString stringWithFormat:@"地址：%@", @""];
            }
            
            itemTitleLabel.numberOfLines = 1;
            itemTitleLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
            itemTitleLabel.font = [UIFont systemFontOfSize:13];
            itemTitleLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview: itemTitleLabel];
            [itemTitleLabel release];
            
            UIButton* dailNumButton = [[[UIButton alloc] initWithFrame:CGRectMake(240, 6, 60, 30)]autorelease];
            [dailNumButton setTitle:@"查看地图" forState:UIControlStateNormal];
            [dailNumButton setTitleColor:[UIColor colorWithRed:33/255.0f green:141/255.0f blue:180/255.0f alpha:1.0] forState:UIControlStateNormal];
            dailNumButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [dailNumButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
            [dailNumButton setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateSelected];
            
            [dailNumButton addTarget:self action:@selector(showTheWay) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview: dailNumButton];
        }
        
    }
}

- (void)actionPhone{
	UIActionSheet *phoneActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打电话" otherButtonTitles:nil];
	phoneActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[phoneActionSheet showInView:[self.view window]];
	[phoneActionSheet release]; 	
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (0 == buttonIndex) {
        if ([_item.merchantTel isEqualToString:@""] || _item.merchantTel == nil || [_item.merchantTel rangeOfString:@" "].location != NSNotFound) {
            return;
        }
        NSString *urlString = [NSString stringWithFormat:@"tel://%@",_item.merchantTel];
        
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	}
}

- (BOOL)showMapMode {
	NSLog(@"%s", __FUNCTION__);
	if (_userLocation.latitude == 0 || _userLocation.longitude == 0) {
		UIAlertView * alert = [[[UIAlertView alloc] initWithTitle:@"一淘" 
														  message:@"您需要打开定位功能来使用该功能" 
														 delegate:nil 
												cancelButtonTitle:@"OK" 
												otherButtonTitles:nil] autorelease];
		[alert show];
		return NO;
	}  
    return YES;
}

- (void)showTheWay {
    
    if (![CLLocationManager locationServicesEnabled]) {
        [[ETaoNetWorkAlert alert]showLocation];
        return;
    }
    
    //添加查询路线代码
    if (![self showMapMode]) {
        return;
    }
    
  //  [_locationManager startUpdatingLocation];
    
    NSString *flatlong = [NSString stringWithFormat:@"%@,%@", _item.latitude, _item.longitude];
    NSString *tlatlong = [NSString stringWithFormat:@"%f,%f", _userLocation.latitude, _userLocation.longitude];
    NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@", [tlatlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[flatlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
/*  	
    MKReverseGeocoder *reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:_userLocation.coordinate];  
    reverseGeocoder.delegate = self;  
    [reverseGeocoder start];  
 */   
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}
/*
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{  
    
    NSLog(@"当前地理信息为：%@",placemark);  
}  
*/

@end
