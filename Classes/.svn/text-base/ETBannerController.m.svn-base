//
//  ETBannerController.m
//  etao4iphone
//
//  Created by 稳 张 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETBannerController.h"
#import "ETHttpImageView.h"
#import "EtaoSRP4SqureController.h"
#import "ETaoUINavigationController.h"
#import "EtaoUIBarButtonItem.h"
#import "TBWebViewControll.h"
#import "ETaoUINavigationController.h"

@implementation ETBannerController

@synthesize superDelegate;
@synthesize scrollView = _scrollView;


int scroll_Height = 150;


- (id)init {
    self = [super init];
    if (self) {
        
        // Initialization code here.
    }
    
    return self;
}


-(void) loadView {
    [super loadView];
    
    [self.view setFrame:CGRectMake(0, 0, 320, scroll_Height)];
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        
        [self.view addSubview:_scrollView];
        
        _scrollView.delegate = self;
        //_scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator=NO; //水平滚动条隐藏
        _scrollView.showsVerticalScrollIndicator=NO;//垂直滚动条隐藏
        //_scrollView.scrollsToTop = YES;
        [_scrollView setBackgroundColor:[UIColor colorWithRed:53/255.0f green:57/255.0 blue:65/255.0f alpha:1]];
    }
    
    
    
    if ( nil == _bannerSession ) {
        _bannerSession = [[ETBannerSession alloc] init];
        [_bannerSession setSessionDelegate:self];
    }
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0f, scroll_Height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}


- (NSArray*) getItemsArray {
    if ( nil == _bannerSession ) {
        return nil;
    }
    
    return [[_bannerSession bannerProtocal] bannerArray];     
}


- (void) initCircleScrollView {
    
    NSArray* itemArray = [self getItemsArray];
    
    if (itemArray.count == 0) {
        return;
    }
    
    int img_Y = 0;
    int img_Height = scroll_Height; 
    
    //add the last image first
    ETHttpImageView *httpImageView0 = [[ETHttpImageView alloc]init];
    httpImageView0.userInteractionEnabled = YES;
    httpImageView0.contentMode = UIViewContentModeScaleToFill;
    httpImageView0.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    [httpImageView0 load:[(ETBannerItem*)[itemArray objectAtIndex:([itemArray count]-1)] backImgUrl]];
    [httpImageView0 setFrame:CGRectMake(0, img_Y, self.view.bounds.size.width, img_Height)];
    
    UIButton *imageButton0 = [[UIButton alloc] init];
    [imageButton0 setFrame:httpImageView0.bounds];
    [imageButton0 setImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]] forState:UIControlStateHighlighted]; 
    [imageButton0 addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton0 setTag:[itemArray count]-1];
    
    [httpImageView0 addSubview:imageButton0];
    [_scrollView addSubview:httpImageView0];
    [httpImageView0 setSecondsToCache:285120000];//cache 1 mout
    [httpImageView0 release];
    [imageButton0 release];

    for (int i=0; i<itemArray.count; i++) {
        ETHttpImageView* httpImageView = [[ETHttpImageView alloc]init];
        httpImageView.userInteractionEnabled = YES;
        httpImageView.contentMode = UIViewContentModeScaleToFill;
        httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
        [httpImageView load:[(ETBannerItem*)[itemArray objectAtIndex:i] backImgUrl]];
        //[httpImageView setUrl:[(ETBannerItem*)[itemArray objectAtIndex:i] backImgUrl]];
        [httpImageView setFrame:CGRectMake(self.view.bounds.size.width*i+self.view.bounds.size.width, img_Y, self.view.bounds.size.width, img_Height)];
        
        UIButton *imageButton = [[UIButton alloc] init];
        [imageButton setFrame:httpImageView.bounds];
        [imageButton setBackgroundColor:[UIColor clearColor]];
        [imageButton setImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]] forState:UIControlStateHighlighted]; 
        [imageButton addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [imageButton setTag:i];
        [httpImageView addSubview:imageButton];
        [_scrollView addSubview:httpImageView];
        [httpImageView setSecondsToCache:285120000];//cache 1 mouth
        [httpImageView release];
        [imageButton release];
    }

    ETHttpImageView* httpImageView2 = [[ETHttpImageView alloc]init];
    httpImageView2.userInteractionEnabled = YES;
    httpImageView2.contentMode = UIViewContentModeScaleToFill;
    httpImageView2.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    [httpImageView2 load:[(ETBannerItem*)[itemArray objectAtIndex:0] backImgUrl]];
    [httpImageView2 setFrame:CGRectMake(self.view.bounds.size.width*([itemArray count]+1), img_Y, self.view.bounds.size.width, img_Height)];    
    
    UIButton *imageButton2 = [[UIButton alloc] init];
    [imageButton2 setFrame:httpImageView2.bounds];
    [imageButton2 setImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]] forState:UIControlStateHighlighted]; 
    [imageButton2 addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton2 setTag:0];
    
    [httpImageView2 addSubview:imageButton2];
    [_scrollView addSubview:httpImageView2];
    [httpImageView2 setSecondsToCache:285120000];//cache 1 mout
    [httpImageView2 release];
    [imageButton2 release];

    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width*(_scrollView.subviews.count),img_Height)]; 
    [_scrollView scrollRectToVisible:CGRectMake(self.view.bounds.size.width,self.view.bounds.origin.y,self.view.bounds.size.width,self.view.bounds.size.height) animated:NO];    
}


- (void) viewDidLoad {

    [self initCircleScrollView];
    [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0)];    

    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                  target:self
                                                selector:@selector(handleTimer:)
                                                userInfo:nil
                                                 repeats:YES];        
    }
    
    [_bannerSession requestSearchBannerDate];
    
    [super viewDidLoad];
}
    


- (void) handleTimer: (NSTimer *) timer {

    int offset = [_scrollView contentOffset].x;
    
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationDuration: 0.5];//这个时间自己设定吧
    [_scrollView setContentOffset:CGPointMake(offset+320, self.view.bounds.origin.y) animated:YES]; 
    [UIView commitAnimations];
    
    [self scrollViewDidEndDecelerating:_scrollView];    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSArray* itemArray = [self getItemsArray];
    
    int currentPage = floor((_scrollView.contentOffset.x - self.view.bounds.size.width / (itemArray.count+2)) / self.view.bounds.size.width) + 1;
    if (currentPage == 0) {
        //go last but 1 page
        [_scrollView scrollRectToVisible:CGRectMake(320 * itemArray.count,_scrollView.bounds.origin.y,320,_scrollView.bounds.size.height) animated:NO];
    } else if (currentPage == (itemArray.count+1)) { //如果是最后+1,也就是要开始循环的第一个
        [_scrollView scrollRectToVisible:CGRectMake(320,_scrollView.bounds.origin.y,320,_scrollView.bounds.size.height) animated:NO];
    }
}


- (void) jumpToWebController:(NSString*) url titleStr:(NSString*) titlestr {
    
    TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:url title:titlestr type:2 isSupportWap:YES] autorelease];
    
    ETaoUINavigationController* nav =[[[ETaoUINavigationController alloc]initWithRootViewController:webv andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:webv action:@selector(UIBarButtonItemHomeClick:)]autorelease];      
    webv.navigationItem.leftBarButtonItem = home;
    
    [self.superDelegate presentModalViewController:nav animated:YES]; 
}


- (void) jumpToSrpListController:(NSString*) q cat:(NSString*) catID {
    
    EtaoSRP4SqureController * srp = [[[EtaoSRP4SqureController alloc] init]autorelease]; 
    srp._keyword = q;
    
    if (catID != nil) {
        [srp searchWord:q cat:catID ppath:@""]; 
    }
    
    ETaoUINavigationController* nav =[[[ETaoUINavigationController alloc]initWithRootViewController:srp andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:srp action:@selector(UIBarButtonItemHomeClick:)]autorelease];      
    srp.navigationItem.leftBarButtonItem = home;
    
    [self.superDelegate presentModalViewController:nav animated:YES]; 
}


- (void) jumpToSrpDetailController:(NSString*) q epID:(NSString*) epid {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:q,@"q",epid,@"epid",nil];
    SearchDetailController *detail = [[[SearchDetailController alloc]initWithProduct:dict]autorelease];
    
    ETaoUINavigationController* nav =[[[ETaoUINavigationController alloc]initWithRootViewController:detail andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:detail action:@selector(UIBarButtonItemHomeClick:)]autorelease];      
    detail.navigationItem.leftBarButtonItem = home;
    
    [self.superDelegate presentModalViewController:nav animated:YES]; 
}


- (void) bannerRequestDidFinish:(NSObject *)obj {
    
    [self initCircleScrollView];
}


- (void) bannerRequestDidFailed:(NSObject *)obg {
    
}

- (void)ButtonClicked:(id)sender {
        
    NSLog(@"ButtonClicked。。。。。。。。。。。。");
    
    UIButton *btn = (UIButton*)sender;
    int index = [btn tag];

    //[delegate pageViewClicked:curPageIndex];
    
    NSArray* itemArray = [self getItemsArray];
    
    if (index >= [itemArray count]) {
        return;
    }
    
    ETBannerItem *bannerItem = [itemArray objectAtIndex:index];
    
    /*
     WebView = 1,
     SRPList = 2,
     SRPDetail = 3
     */
    
    switch (bannerItem.type) {
        case WebView: {
            [self jumpToWebController:bannerItem.url titleStr:bannerItem.bannerTitle];            
            break;
        }
            
        case SRPList: {
            [self jumpToSrpListController:bannerItem.q cat:bannerItem.cat];
            break;
        }
            
        case SRPDetail: {
            [self jumpToSrpDetailController:bannerItem.q epID:bannerItem.epid];
            break;
        }
            
        default:
            break;
    }
        
}


- (void) setBannerBoundRect:(CGRect)bounds {

//    NSString* tempstr = [NSString stringWithFormat:@"..%f,%f,", bounds.origin.y, bounds.size.height];
//    NSLog(tempstr, nil);
    
    [self.view setFrame:bounds];
     
//    if (bounds.size.height>=100) {
//        
//        if (bounds.size.height<=120) {
//            
//            float tempFloat = bounds.size.height-100;
//            
//            [_scrollView setBounds:bounds];
//           
//            for (ETHttpImageView* view in _scrollView.subviews) {
//                [view setBounds:CGRectMake(view.bounds.origin.x, -10+(tempFloat/2), view.bounds.size.width, 120)];
//            }
//        }
//        
//    }
    
//    NSString* tempstr = 
//    [NSString stringWithFormat:@"..%f,%f,",
//     bounds.origin.y,
//     bounds.size.height];
//    NSLog(tempstr, nil);
//
//    //[_scrollView setBounds:bounds];
//    
//    [self.view setBackgroundColor:[UIColor redColor]];
}


- (void) dealloc {
    
    self.superDelegate = nil;
    
    //[_itemsPageArray release];
    [_scrollView release];
    [_bannerSession release];
    
    [super dealloc];
}


/*
 UIView *tempView = [[UIView alloc] init];
 [tempView setFrame:CGRectMake(self.view.bounds.size.width*i+self.view.bounds.size.width, img_Y, self.view.bounds.size.width, img_Height)];
 
 
 ETHttpImageView* httpImageView = [[ETHttpImageView alloc]init];
 httpImageView.contentMode = UIViewContentModeScaleToFill;
 httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
 [httpImageView load:[(ETBannerItem*)[itemArray objectAtIndex:i] backImgUrl]];
 //[httpImageView setUrl:[(ETBannerItem*)[itemArray objectAtIndex:i] backImgUrl]];
 [httpImageView setFrame:CGRectMake(self.view.bounds.size.width*i+self.view.bounds.size.width, img_Y, self.view.bounds.size.width, img_Height)];
 
 UIButton *imageButton = [[UIButton alloc] init];
 [imageButton setFrame:httpImageView.bounds];
 [imageButton setBackgroundColor:[UIColor clearColor]];
 [imageButton setImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]] forState:UIControlStateHighlighted]; 
 [imageButton addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
 [imageButton setTag:i];
 [tempView addSubview:httpImageView];
 [tempView addSubview:imageButton];
 [_scrollView addSubview:tempView];
 [httpImageView setSecondsToCache:285120000];//cache 1 mouth
 [httpImageView release];
 [imageButton release];
 
 [tempView release];
 */

@end
