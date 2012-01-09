//
//  EtaoTuanDetailSwipeController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanDetailSwipeController.h"
#import "EtaoTuanListDetailController.h"
#import "TBWebViewControll.h"

@implementation EtaoTuanDetailSwipeController
@synthesize datasource = _datasource ;
@synthesize timerController = _timerController;

- (void) UIBarButtonItemBackClick:(UIBarButtonItem*)sender{   
 //   [_timerController stopTimer];
    [self.navigationController popViewControllerAnimated:YES];
    //[[self parentViewController] dismissModalViewControllerAnimated:YES];  
}

-(void)dealloc{
    if (_timerController != nil) {
        [[EtaoTimerController sharedTimeLabelPointerArray]removeAllObjects];
        [_timerController stopTimer];
        [_timerController release];
        _timerController = nil;
    }
    [super dealloc];
}

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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (id)init{
    self = [super init];
    if (self) {      
         //开始计时
        self.timerController = [[[EtaoTimerController alloc]init] autorelease];
        [_timerController startTimer];
    }
    return self;
}

- (void)viewDidUnload
{
    if (_timerController != nil) {
        [_timerController stopTimer];
    }
    _loading = NO ;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (void) setDetailByIndex:(int) idx {
    if (self.navTitle == nil) {
        self.navTitle = @"详情页";
    } 
    self.title = @"详情页";//[NSString stringWithFormat:@"%@(%d/%d)",self.navTitle,idx+1,[_detailsDataSourceItems count]];
    self.detailController = [[[self.cls alloc]init]autorelease]; 
    
    [_detailController setDetailFromItem:[_detailsDataSourceItems objectAtIndex:idx]];
    
    _detailController.view.frame = CGRectMake(_detailController.view.frame.origin.x , 0, _detailController.view.frame.size.width, 415);
    
    [self.view addSubview:_detailController.view];     
    _index = idx;
    
    EtaoTuanListDetailController* tmp  = (EtaoTuanListDetailController *)_detailController; 
//    EtaoGroupBuyMapViewController* map = (EtaoGroupBuyMapViewController*)_datasource.delegateForMap;
//    tmp.userLocation = [map getUserGPS];
     _localItem = tmp.item;
    [self.view addSubview:[self initButtomInfoView:tmp.item]];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
	CGPoint location = [recognizer locationInView:self.view]; 
    
    if (_loading) {
        return ;
    }
    
    
    int toward = 320 ;
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        location.x -= 220.0;
        toward = 320;
        _index += 1;
    }
    else {
        location.x += 220.0;
        toward = -320;
        _index -= 1;
    } 
    
    if ( _index < 0 ) {
        _index = 0 ;
        return;
    }
//    int total = [_datasource.updateNum intValue];
//    if (_index >= total) {
//        _index = total - 1;
//        return ;
//    }
    if (_index >= [super.detailsDataSourceItems count]) {  
//        [_datasource getNextAuctions]; 
        _loading = YES;
        return;
    }
    else
    {
        
        self.detailController2  = [[[self.cls alloc]init]autorelease]; 
        [_detailController2 setDetailFromItem:[_detailsDataSourceItems objectAtIndex:_index]]; 
        _detailController2.view.frame = CGRectMake(_detailController2.view.frame.origin.x + toward, 0, _detailController2.view.frame.size.width, 365);
        [self.view addSubview:_detailController2.view];
        
        [UIView animateWithDuration:0.4 
                         animations:^{
                             for (UIView *view in [self.view subviews]) {
                                 view.frame = CGRectMake(view.frame.origin.x - toward, view.frame.origin.y, view.frame.size.width, 365);
                             }
                         }
                         completion:^(BOOL finished){ 
                             [self.detailController.view removeFromSuperview]; 
                             self.detailController = _detailController2;
                             self.detailController2 = nil;  // release tmp
                         }
         ];  
        if (self.navTitle == nil) {
            self.navTitle = @"详情页";
        }
        self.title = @"详情页"; //[NSString stringWithFormat:@"%@(%d/%d)",self.navTitle,_index+1,[_detailsDataSourceItems count]];
        NSLog(@"after:%@",[self.view subviews]);
        
        EtaoTuanListDetailController* tmp  = (EtaoTuanListDetailController *)_detailController2;
//        EtaoGroupBuyMapViewController* map = (EtaoGroupBuyMapViewController*)_datasource.delegateForMap;
//        tmp.userLocation = [map getUserGPS];
        _localItem = tmp.item;
        [self.view addSubview:[self initButtomInfoView:tmp.item]];
         
    }
}


/* Http代理回调 */
- (void) showFirstAuctions
{
    // just do nothing
}

- (void) showNextAuctions
{ 
    int toward = 320 ;
    if ( _index >= [super.detailsDataSourceItems count] ) { 
        return;
    }
    
    self.detailController2  = [[[self.cls alloc]init]autorelease]; 
    [_detailController2 setDetailFromItem:[_detailsDataSourceItems objectAtIndex:_index]]; 
    _detailController2.view.frame = CGRectMake(_detailController2.view.frame.origin.x + toward, 0, _detailController2.view.frame.size.width, 365);
    [self.view addSubview:_detailController2.view];
    
    [UIView animateWithDuration:0.4 
                     animations:^{
                         for (UIView *view in [self.view subviews]) {
                             view.frame = CGRectMake(view.frame.origin.x - toward, view.frame.origin.y, view.frame.size.width, 365);
                         }
                     }
                     completion:^(BOOL finished){ 
                         [self.detailController.view removeFromSuperview]; 
                         self.detailController = _detailController2;
                         self.detailController2 = nil;  // release tmp
                     }
     ];  
    if (self.navTitle == nil) {
        self.navTitle = @"详情页";
    }
    self.title = @"详情页"; //[NSString stringWithFormat:@"%@(%d/%d)",self.navTitle,_index+1,[_detailsDataSourceItems count]];
    
    EtaoTuanListDetailController* tmp  = (EtaoTuanListDetailController *)_detailController2;
//    EtaoGroupBuyMapViewController* map = (EtaoGroupBuyMapViewController*)_datasource.delegateForMap;
//    tmp.userLocation = [map getUserGPS];
    _localItem = tmp.item;
    [self.view addSubview:[self initButtomInfoView:tmp.item]];
    _loading = NO ;
}

- (void) showNoMoreAuctions
{
    // just do nothing 
}


#pragma mark 去看看
-(IBAction)gotoWeb:(id)sender{
	NSLog(@"%s", __FUNCTION__); 
	
    TBWebViewControll *webv;
    if ([_localItem.wapLink isEqualToString:@""] || _localItem.wapLink==nil) {
        webv = [[[TBWebViewControll alloc] initWithURLAndType:_localItem.link title:_localItem.title type:-1 isSupportWap:NO] autorelease];
    }
    else{
        webv = [[[TBWebViewControll alloc] initWithURLAndType:_localItem.wapLink title:_localItem.title type:-1 isSupportWap:NO] autorelease];
    }
    webv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webv animated:YES];
} 

-(UIView *)initButtomInfoView:(EtaoTuanAuctionItem *)_item{
    
    UIView* bottomInfoView = [[UIView alloc] initWithFrame:CGRectMake(0,370,320,50)];
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
    [goToSeeButton setBackgroundImage:[UIImage imageNamed:@"groupBuyGoAndSee"] forState:UIControlStateNormal];
    [goToSeeButton setTitle:@"去看看" forState:UIControlStateNormal];
    [goToSeeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomInfoView addSubview:goToSeeButton];
    
    NSLog(@"%@", _item.wapLink);
    goToSeeButton.tag = [_item.wapLink integerValue];
    [goToSeeButton addTarget:self action:@selector(gotoWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    //   [self.view addSubview:bottomInfoView];
    //    [bottomInfoView release];
    return bottomInfoView;
}



@end
