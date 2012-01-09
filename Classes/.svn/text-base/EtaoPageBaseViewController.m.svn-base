//
//  EtaoPageBaseViewController.m
//  etaoetao
//
//  Created by GuanYuhong on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPageBaseViewController.h"
#import "RootViewController.h"
#import "ETaoUINavigationController.h"
#import "EtaoUIBarButtonItem.h"
#include<stdlib.h>
#include<math.h>

@implementation EtaoScrollView
@synthesize target = _target;
@synthesize action = _action;
@synthesize pagingEnabled;
 
- (id)initWithFrame:(CGRect)frame 
{
    return [super initWithFrame:frame];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    UITouch *touch = [[touches allObjects]objectAtIndex:0];

    
    if (!self.dragging) 
        [self.nextResponder touchesEnded: touches withEvent:event]; 
    else
        [super touchesEnded: touches withEvent: event];
    
    if (_target != nil && _action != nil) {
        [_target performSelector:_action withObject:touch];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        
    }
    [super touchesBegan:touches withEvent:event];
}

@end

@implementation EtaoPageBaseViewController
 
@synthesize scrollv= _scrollv;
@synthesize pagectrl = _pagectrl; 
@synthesize viewCtrls = _viewCtrls; 
@synthesize scrollHead = _scrollHead;
@synthesize headViews = _headViews;
@synthesize categoryController = _categoryController;
@synthesize searchController = _searchController;
@synthesize leftLabel = _leftLabel ;
@synthesize rightLabel = _rightLabel ;
@synthesize delegate;  
@synthesize kNumberOfPages;
@synthesize didPageSlideController;
const int titleWidth = 80 ;

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
- (id)initWithCategoryController:(EtaoPageBaseCategoryController *)categoryViewController {
    self = [self init];
    if (self) {  
		self.categoryController = categoryViewController;
        kNumberOfPages = [categoryViewController viewCount] + 1 ;
        
        
        self.viewCtrls = [NSMutableArray arrayWithCapacity:10];
        for (unsigned i = 0; i < kNumberOfPages; i++)
        {
            [_viewCtrls addObject:[NSNull null]];
        } 
        
        if (_categoryController != nil) {
            [_viewCtrls replaceObjectAtIndex:kNumberOfPages-1 withObject:_categoryController];
        }
        
        self.headViews = [NSMutableArray arrayWithCapacity:10];
        for (unsigned i = 0; i < kNumberOfPages + 2 ; i++)
        {
            [_headViews addObject:[NSNull null]];
        }

        
        return self;  
    }
	return nil; 
}


- (id)initWithViewController:(NSArray *)viewControllers {
    
    self = [self init];
    if (self) {  
		self.categoryController = nil;
        kNumberOfPages = [viewControllers count]; 
                  
        self.viewCtrls = [NSMutableArray arrayWithArray:viewControllers]; 
        
        self.headViews = [NSMutableArray arrayWithCapacity:10];
        for (unsigned i = 0; i < kNumberOfPages + 2 ; i++)
        {
            [_headViews addObject:[NSNull null]];
        } 
        
        return self;  
    }
	return nil;   
    
}

 
- (id)init{
    
    self = [super init];
    if (self) {   
        self.categoryController = nil;
        self.didPageSlideController = @selector(pageSlideController:);
        return self;  
    }
	return nil; 
}

- (void)dealloc
{
    [_leftLabel release];
    [_rightLabel release];
    [_viewCtrls release];
    [_headViews release];
    [_scrollv release];
    [_scrollHead release];
    [_pagectrl release];
    [super dealloc];     
}

- (void) UIBarButtonItemClick:(UIBarButtonItem*)sender{ 
    [[self parentViewController] dismissModalViewControllerAnimated:YES];  
}
- (void) headViewClick:(UITouch*)pos {
    CGPoint point = [pos locationInView:self.view ];
    NSLog(@"%f,%f",point.x,point.y);
    if (point.x > 260) { 
        int page = _pagectrl.currentPage + 1 ;
        [_scrollv scrollRectToVisible:CGRectMake(320*page, 0, _scrollv.frame.size.width, _scrollv.frame.size.height) animated:YES]; 
 
        [self performSelector:@selector(setArrow) withObject:nil afterDelay:5.3];
    }
    if (point.x < 60) { 
        int page = _pagectrl.currentPage - 1 ;
        [_scrollv scrollRectToVisible:CGRectMake(320*page, 0, _scrollv.frame.size.width, _scrollv.frame.size.height) animated:YES]; 
        [self performSelector:@selector(setArrow) withObject:nil afterDelay:5.3];
    }
}
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
    [super loadView];      
    self.title = @"一淘";
    EtaoUIBarButtonItem *home = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_home.png"] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
    home.title = @"gohome";
    
    EtaoUIBarButtonItem *about = [[[EtaoUIBarButtonItem alloc] initWithTitle:@"搜索" bkColor:[UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0] target:self action:@selector(UIBarButtonItemClick:)]autorelease];
     about.title = @"about";
    
   // self.navigationItem.leftBarButtonItem = home; 
   // self.navigationItem.rightBarButtonItem = about; 
    
    // OC2.0
    self.scrollv = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 30.0, self.view.frame.size.width, self.view.frame.size.height)]autorelease]; 
    /*
    // OC
    UIScrollView *tmp = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 30.0, self.view.frame.size.width, self.view.frame.size.height)];      
    self.scrollv  = tmp ;
    [tmp release];
    
    // C/ C++
    _scrollv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 30.0, self.view.frame.size.width, self.view.frame.size.height)]; 
    */
    NSLog(@"_scrollv=%d",[_scrollv retainCount]);
    _scrollv.directionalLockEnabled = YES;
    _scrollv.pagingEnabled = YES;
    _scrollv.showsHorizontalScrollIndicator = NO;
    _scrollv.showsVerticalScrollIndicator = NO;
    _scrollv.scrollsToTop = NO; 
    _scrollv.delegate = self; 
    _scrollv.backgroundColor = [UIColor whiteColor];
    
    self.scrollHead = [[[EtaoScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 30)]autorelease]; 
   // _scrollHead.backgroundColor = [UIColor purpleColor]; 
    _scrollHead.directionalLockEnabled = YES;
    _scrollHead.pagingEnabled = NO;
    _scrollHead.showsHorizontalScrollIndicator = NO;
    _scrollHead.showsVerticalScrollIndicator = NO;
    _scrollHead.scrollsToTop = NO;  
    _scrollHead.scrollEnabled = NO ;  
     _scrollHead.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_pageslide.png"]];
    _scrollHead.target = self;
    _scrollHead.action = @selector(headViewClick:);
    
    [self.view addSubview:_scrollHead];
    float headwidth =  titleWidth * (kNumberOfPages + 2 ) + (self.view.frame.size.width - 3*titleWidth ) / 2 *(kNumberOfPages + 1 );
    CGSize headSize = CGSizeMake(headwidth, 30);
    [_scrollHead setContentSize:headSize];
    
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width * kNumberOfPages,  self.view.frame.size.height);
    [_scrollv setContentSize:newSize];
    
    [self.view addSubview:_scrollv];
    
    self.pagectrl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0.0, 401, self.view.frame.size.width, 300)]autorelease];
    _pagectrl.hidesForSinglePage = YES;
    _pagectrl.userInteractionEnabled = NO;
    _pagectrl.backgroundColor = [UIColor redColor];
    //[self.view addSubview:_pagectrl];
     
    
    _pagectrl.numberOfPages = kNumberOfPages;
    _pagectrl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //  
  
     
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1]; 
    
    [self loadHeadScrollViewWithPage:-1]; 
    [self loadHeadScrollViewWithPage:0];
    [self loadHeadScrollViewWithPage:1]; 
    
    
    UILabel *head = [_headViews objectAtIndex:1];
    head.font =[UIFont boldSystemFontOfSize:15]; 
    
    
    self.leftLabel= [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arowleft.png"]]autorelease];
    _leftLabel.frame = CGRectMake(0, 7.5, 15, 15);
    [self.view addSubview:_leftLabel];
    
    self.rightLabel= [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arowright.png"]]autorelease];
    _rightLabel.frame = CGRectMake(305, 7.5, 15, 15);
    [self.view addSubview:_rightLabel];

}

- (void)setArrow
{ 
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];  
       
    [UIView commitAnimations];

    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.4]; 
//    if(_pagectrl.currentPage == 0){
//        CGRect frame = _rightLabel.frame;
//        frame.origin.x = titleWidth-14;
//        frame.origin.y = 8;
//        frame.size.width = 11;
//        frame.size.height = 11;
//        _rightLabel.frame = frame; 
//        [[_headViews objectAtIndex:_pagectrl.currentPage+2] addSubview:_rightLabel];
//        
//    }
//    else if(_pagectrl.currentPage == kNumberOfPages-1){
//        CGRect frame = _leftLabel.frame;
//        frame.origin.x = 3;
//        frame.origin.y = 8;
//        frame.size.width = 11;
//        frame.size.height = 11;
//        _leftLabel.frame = frame ; 
//        [[_headViews objectAtIndex:_pagectrl.currentPage] addSubview:_leftLabel];
//    }
//    else{
//        CGRect frame = _leftLabel.frame;
//        frame.origin.x = 3;
//        frame.origin.y = 8;
//        frame.size.width = 11;
//        frame.size.height = 11;
//        _leftLabel.frame = frame ; 
//        [[_headViews objectAtIndex:_pagectrl.currentPage] addSubview:_leftLabel];
//        
//        frame = _rightLabel.frame;
//        frame.origin.x = titleWidth-14;
//        frame.origin.y = 8;
//        frame.size.width = 11;
//        frame.size.height = 11;
//        _rightLabel.frame = frame ; 
//        [[_headViews objectAtIndex:_pagectrl.currentPage+2] addSubview:_rightLabel];
//    } 
//    [UIView commitAnimations];
}



- (void)scrollToPage:(int)page {      
    [_scrollv scrollRectToVisible:CGRectMake(320*page, 0, _scrollv.frame.size.width, _scrollv.frame.size.height) animated:NO];   
    [self setArrow];
}
 
- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
    // Process the single tap here
    NSLog(@"touchesEnded");
    if (_categoryController!=nil) {  
        _categoryController.title = @"选择分类"; 
        ETaoUINavigationController *nav =[[[ETaoUINavigationController alloc]initWithRootViewController:_categoryController andColor: [UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]]autorelease]; 
        nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:nav animated:YES]; 
          
    }
}

- (UIViewController*) viewAtPage:(int)page{
    
    RootViewController * controller = [[[RootViewController alloc] init]autorelease]; 
    controller.title = [NSString stringWithFormat:@"美食分类%d",page];  
    return controller;
    
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return; 
    
    
    
    // replace the placeholder if necessary
    RootViewController *controller = [_viewCtrls objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        NSArray *names = [NSArray arrayWithObjects:@"火锅",@"KTV",@"拉手网" ,@"美食娱乐",@"55团",@"24quan",@"京东商城",@"服装箱包",nil];
        NSLog(@"%@",names);
        controller = [[RootViewController alloc] init];   
        controller.title = [names objectAtIndex:page];
        [_viewCtrls replaceObjectAtIndex:page withObject:controller];
        [controller release];
    } 
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = _scrollv.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        frame.size.height = frame.size.height-80;
        controller.view.frame = frame;          
        [_scrollv addSubview:controller.view]; 
            
    }
}


- (void)loadHeadScrollViewWithPage:(int)vpage
{ 
    int page =  vpage + 1 ;
          
    // replace the placeholder if necessary
    UILabel *head = [_headViews objectAtIndex:page]; 
    if ((NSNull *)head == [NSNull null])
    {
        head = [[UILabel alloc] init];  
        head.textAlignment = UITextAlignmentCenter;
        head.backgroundColor = [UIColor clearColor];
        head.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        if (vpage >= 0 && vpage < kNumberOfPages) {
            RootViewController *controller = [_viewCtrls objectAtIndex:vpage];
            if ((NSNull *)controller != [NSNull null])
            {
                head.text = controller.title;
            }else
            {
                head.text = @"";
            }
        }
        else
        {
            head.text = @"";
        } 
         
        [_headViews replaceObjectAtIndex:page withObject:head];
        [head release];
    }
    
    // add the controller's view to the scroll view
    if (head.superview == nil)
    {  
        CGRect frame = _scrollHead.frame;
        frame.origin.y = 0;
        frame.size.width = titleWidth ;
        
        frame.origin.x =  (_scrollHead.frame.size.width - frame.size.width ) / 2 * (page );
        head.frame = frame;         
        
        //const double PI = 3.1415926;  
        //float v = sin((head.frame.origin.x)/240 * PI);
        head.font = [UIFont boldSystemFontOfSize:12]; 
        NSLog(@"frame=%f",frame.origin.x);
        [_scrollHead addSubview:head];  
    }
}
 
 

- (void)scrollViewDidScroll:(UIScrollView *)sender
{ 
	
    NSLog(@"scrollViewDidScroll");
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scrollv.frame.size.width;
    int page = floor((_scrollv.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pagectrl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
 
    
   // NSLog(@"_scrollv.frame.size.width=%f",_scrollv.contentOffset.x);  
    _rightLabel.hidden = NO;
    _leftLabel.hidden = NO;
    if (_scrollv.contentOffset.x >= self.view.frame.size.width * (kNumberOfPages-1)) { 
        _rightLabel.hidden = YES;
        return ;
    }
    if (_scrollv.contentOffset.x < 0 || _scrollv.contentOffset.x >= self.view.frame.size.width * kNumberOfPages) {
        _leftLabel.hidden = YES;
        return ;
    }
    if (page == 0) {
        _leftLabel.hidden = YES;
    }
    if (page == kNumberOfPages - 1 ) {
        _rightLabel.hidden = YES;
    }
    
    [self loadHeadScrollViewWithPage:page - 1];
    [self loadHeadScrollViewWithPage:page];
    [self loadHeadScrollViewWithPage:page + 1];     
  
    CGPoint newPiont = CGPointMake(_scrollv.contentOffset.x * ( (self.view.frame.size.width - titleWidth ) / (2*self.view.frame.size.width) )  , _scrollHead.contentOffset.y);  
    [_scrollHead setContentOffset:newPiont animated:NO];
    
    // 
    const double PI = 3.1415926; 
    for (UILabel *title in _headViews) {
        if ((NSNull *)title!=[NSNull null]) {
            if (newPiont.x > title.frame.origin.x) {
                continue;
            }
            if (newPiont.x + 240 < title.frame.origin.x) {
                continue;
            }
            float v = sin((newPiont.x+title.frame.origin.x)/240 * PI);
            title.font = [UIFont boldSystemFontOfSize:12+3*fabs(v)]; 
            title.alpha = 0.6 + 0.4 *fabs(v);
          //  NSLog(@"%@ sin=%f x=%fmnewPiont.x=%f",title.text, 12+3*fabs(v),title.frame.origin.x,newPiont.x); 
        } 
    }
    
     
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}



// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging"); 
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    _leftLabel.alpha = 0.0;
    _rightLabel.alpha = 0.0; 
    [UIView commitAnimations];
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    int page = _pagectrl.currentPage ; 
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    _leftLabel.alpha = 1.0;
    _rightLabel.alpha = 1.0; 
    [UIView commitAnimations];
    //回调代理函数 
    if(self.delegate && self.didPageSlideController && [self.delegate respondsToSelector:self.didPageSlideController]){ 
        [self.delegate performSelectorOnMainThread:self.didPageSlideController withObject:[_viewCtrls objectAtIndex:page] waitUntilDone:YES];
    }     
    
}

- (void) categorySelectedDone{
    
    int page = 0; 	
  
    // update the scroll view to the appropriate page
    CGRect frame = _scrollv.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_scrollv scrollRectToVisible:frame animated:NO];
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    [self loadHeadScrollViewWithPage:page - 1];
    [self loadHeadScrollViewWithPage:page];
    [self loadHeadScrollViewWithPage:page + 1];  
    
 
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

@end
