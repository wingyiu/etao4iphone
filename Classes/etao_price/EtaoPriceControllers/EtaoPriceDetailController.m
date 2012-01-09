//
//  EtaoPriceDetailController.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-11-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceDetailController.h"


@implementation touchController

//动画，放大

- (void)imageViewControllerBigAnimation{

    [UIView beginAnimations:@"imageViewBig" context:nil];
    [UIView setAnimationDuration:0.3];   
    CGAffineTransform newTransform = CGAffineTransformConcat(self.transform,CGAffineTransformInvert(self.transform));
    [self setTransform:newTransform];
    [self.superview  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [UIView commitAnimations];
    
}

//动画，缩小

- (void)imageViewControllerSmallAnimation{
    
    [UIView beginAnimations:@"imageViewSmall" context:nil];
    [UIView setAnimationDuration:0.3];
    CGAffineTransform newTransform =  CGAffineTransformScale(self.transform, 0.1, 0.1);
    [self setTransform:newTransform];
    self.superview.alpha = 0;
    [UIView commitAnimations];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //加载动画效果
    [self imageViewControllerSmallAnimation];
    [self.superview performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.3];
}

@end


@implementation shopViewTouchController
@synthesize item = _item;
@synthesize touchcontroller = _touchcontroller;
@synthesize goseesee = _goseesee;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   [_goseesee setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_goseesee_hover3.png"]]];
}
 

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_goseesee setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_goseesee3.png"]]];
    [self.touchcontroller imageViewControllerSmallAnimation];
    [self.superview performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.3];
    if(_item.wapLink==nil){
        TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:_item.link 
                                                                       title:_item.title 
                                                                        type:[_item.sellerType intValue] 
                                                                isSupportWap:NO] 
                                   autorelease];
    
        webv.hidesBottomBarWhenPushed = YES; 
        [[EtaoPriceMainViewController getNavgationController] pushViewController:webv animated:YES];
    }
    else{
        TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:_item.wapLink 
                                                                           title:_item.title 
                                                                            type:[_item.sellerType intValue] 
                                                                    isSupportWap:YES] 
                                   autorelease];
        
        webv.hidesBottomBarWhenPushed = YES; 
        [[EtaoPriceMainViewController getNavgationController] pushViewController:webv animated:YES];
    }
    
    [TBUserTrack trackPage:self eventId:TB_USERTRACK_EVENT_PAGE_CTL_CLICKED arg1:@"Button-Detail"];
}
@end


@implementation EtaoPriceDetailController

@synthesize item = _item;
@synthesize imgView = _imgView;

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

- (void)loadView
{
    [super loadView];
    
    //事件响应
    
 
    
}

- (void) setDetailFromItem:(id) item {
    if ([item isKindOfClass:[EtaoPriceAuctionItem class]]) {
        self.item = item;
        //初始化框体
        _touchcontroller = [[[touchController alloc]init]autorelease];
        [_touchcontroller setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
      //  [self.view addSubview:_touchcontroller];
        [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        
        /* 商品图片 */
        _imageBGView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 290, 290)];
        [_imageBGView setBackgroundColor:[UIColor whiteColor]];
        _imgView = [[HTTPImageView alloc]init];
        TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
        _imgView.memoryCache = memoryCache ;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_imgView setFrame:CGRectMake(15, 10, 260, 270)];
        _imgView.isProgress = YES;
        if(_item.image == nil){
            _imgView.image = [UIImage imageNamed:@"no_picture_80x80.png"];
        }
        else{
            [_imgView setUrl:[NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@",_item.image]];
        }
        [_imageBGView addSubview: _imgView];
        
        /*  商品详情  */
        _auctionView = [[UIView alloc]init];
        [_auctionView setBackgroundColor:[UIColor whiteColor]];
        [_auctionView setFrame:CGRectMake(15, 305 , 290, 90)];
        
        
        UIFont *titleFont = [UIFont systemFontOfSize:16];
        UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
        UIFont *priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:25];
        UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ;
        //UIFont *uptimeFont = [UIFont systemFontOfSize:12];
        //UIColor *uptimeColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]; 
        UIFont *detailFont = [UIFont systemFontOfSize:13];
        UIColor *detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];    
        
        //标题label
        UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(15, 0, 260, 45)] autorelease];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [NSString stringWithFormat:@"%@",_item.title];
        titleLabel.font = titleFont;
        titleLabel.textColor = titleColor;
        titleLabel.textAlignment = UITextAlignmentLeft ;
        titleLabel.numberOfLines = 2;
        
        //价格label
        NSString *price = [NSString stringWithFormat:@"%1.2f",[_item.productPrice floatValue]];
        UIImageView *priceIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rmb_price.png"]]autorelease];
        [priceIcon setFrame:CGRectMake(15, 56, 9, 11)];
        UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(26, 45, 110, 30)] autorelease];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.text = [NSString stringWithFormat:@"%@",price];
        priceLabel.font = priceFont;
        priceLabel.numberOfLines = 1 ;
        priceLabel.textColor = priceColor;
        
        //原价label
        NSString *orgPrice = [NSString stringWithFormat:@"¥%1.2f",[_item.lowestPrice floatValue]];
        int word_count = orgPrice.length;
        UILabel* orgPriceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(130, 56, word_count*9, 13)] autorelease];
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
        UILabel* distLabel = [[[UILabel alloc]initWithFrame:CGRectMake(210,56, 60, 13)]autorelease];
        UIImageView* distIcon = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"etao_discount.png"]]autorelease];
        [distLabel addSubview:distIcon];
        distLabel.text = [NSString stringWithFormat:@"  %.1f折",dist];
        distLabel.textAlignment = UITextAlignmentCenter;
        distLabel.textColor = detailColor;
        distLabel.font = [UIFont systemFontOfSize:15];
        
        /*
         //小星星 label
         UILabel* starLabel = [[[UILabel alloc]initWithFrame:CGRectMake(30, 80, 100, 20)]autorelease];
         [self constructUserConmentsImgView:starLabel cmtScore:dist/2];
         */
        /* 
         //更新时间label
         [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
         NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
         [dateFormatter setDateStyle:NSDateFormatterShortStyle];
         [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
         NSString *uptime =  [NSString stringWithFormat:@"更新时间:%@", [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([_item.priceMtime floatValue] )]]];
         UILabel* uptimeLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(30,80,200,20)] autorelease];
         uptimeLabel.backgroundColor = [UIColor clearColor];
         uptimeLabel.text = uptime;
         uptimeLabel.font = uptimeFont;
         uptimeLabel.numberOfLines = 1 ;
         uptimeLabel.textColor = uptimeColor;
         */
        
        [_auctionView addSubview:titleLabel];
        [_auctionView addSubview:priceIcon];
        [_auctionView addSubview:priceLabel];
        [_auctionView addSubview:orgPriceLabel];
        [_auctionView addSubview:distLabel];
        //[_auctionView addSubview:starLabel];
        //[_auctionView addSubview:uptimeLabel];
        
        /* 商家详情 */
        _shopView = [[shopViewTouchController alloc]init];
        [_shopView setBackgroundColor:[UIColor whiteColor]];
        [_shopView setFrame:CGRectMake(15,395, 290, 50)];
        _shopView.item = _item;
        _shopView.touchcontroller = _touchcontroller;
        
        //logo
        HTTPImageView* logo = [[[HTTPImageView alloc]init]autorelease];
        logo.memoryCache = memoryCache ;
        logo.contentMode = UIViewContentModeScaleAspectFit;
        [logo setFrame:CGRectMake(15, 0, 80 , 50)];
        [logo setUrl:[NSString stringWithFormat:@"http://img02.taobaocdn.com/tps/%@",_item.logo]];
        
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
        _shopView.goseesee = goseeLabel;
        [goseeLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"etao_goseesee3.png"]]];
        goseeLabel.text = @"去看看";
        goseeLabel.textColor = [UIColor whiteColor];
        goseeLabel.font = [UIFont systemFontOfSize:16];
        goseeLabel.textAlignment = UITextAlignmentCenter;
        
        //arrow
        [_shopView addSubview:shopLabel];
        [_shopView addSubview:logo];
        [_shopView addSubview:goseeLabel];
    }
}

- (void)jumpTo:(id)sender
{
    UIButton* button = (UIButton*)sender;
    [button setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]];
    
    [self.view removeFromSuperview];
    TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:_item.link 
                                                                       title:_item.title 
                                                                        type:[_item.sellerType intValue] 
                                                                isSupportWap:NO] 
                               autorelease];
    
    webv.hidesBottomBarWhenPushed = YES;
}

- (void)dealloc
{
    [_item release];
    [_imgView release];
    [_imageBGView release];
    [_auctionView release];
    [_shopView release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGAffineTransform newTransform = 
    CGAffineTransformScale(_touchcontroller.transform, 0.1, 0.1);
    [_touchcontroller setTransform:newTransform];
    //self.view.alpha = 0;
    
    [_touchcontroller imageViewControllerBigAnimation];
    
    
    [_touchcontroller addSubview:_imageBGView];
    [_touchcontroller addSubview:_auctionView];
    [_touchcontroller addSubview:_shopView];
    
    
    //一条神奇的线
    UIView* line = [[[UIView alloc]initWithFrame:CGRectMake(30, 395, 260, 1)]autorelease];
    [line setBackgroundColor:[UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0]];
    [_touchcontroller addSubview:line];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) constructUserConmentsImgView:(UIView*)parent cmtScore: (float)pr {
    
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
        
        [imgView setFrame:CGRectMake(15*i, 3, 13, 13 )];
        
        [parent addSubview:imgView];
        
        [imgView release];
    }
}

@end
