//
//  EtaoPageSlideController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPageSlideController.h"


@implementation EtaoPageSlideHeader
@synthesize target = _target;
@synthesize action = _action;
@synthesize pagingEnabled;


- (id)initWithFrame:(CGRect)frame 
{
    return [super initWithFrame:frame];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	


    if(_target && [_target respondsToSelector:@selector(touchMe)]){
        [_target performSelector:@selector(touchMe)];
    }
    
    if (!self.dragging) 
        [self.nextResponder touchesEnded: touches withEvent:event]; 
    else
        [super touchesEnded: touches withEvent: event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        
    }
    [super touchesBegan:touches withEvent:event];
}

@end



@implementation EtaoPageSlideController
@synthesize delegate;
@synthesize scrollv= _scrollv;
@synthesize viewCtrls = _viewCtrls; 
@synthesize scrollHead = _scrollHead;
@synthesize headViews = _headViews;
@synthesize kNumberOfPages = _kNumberOfPages;
@synthesize currentPage = _currentPage;


- (void) dealloc {     
    [_scrollv release];
    [_scrollHead release];
    [_headViews release];
    [_viewCtrls release ];
    [_leftLabel release ];
    [_rightLabel release ];
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

- (void)loadView
{
    [super loadView];

    //初始化主view
    self.scrollv = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 30.0, self.view.frame.size.width, self.view.frame.size.height)]autorelease]; 
    _scrollv.directionalLockEnabled = YES;
    _scrollv.pagingEnabled = YES;
    _scrollv.showsHorizontalScrollIndicator = NO;
    _scrollv.showsVerticalScrollIndicator = NO;
    _scrollv.scrollsToTop = YES; 
    _scrollv.delegate = self; 
    _scrollv.backgroundColor = [UIColor whiteColor];
    
    //初始化头view
    self.scrollHead = [[[EtaoPageSlideHeader alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 30)]autorelease]; 
    _scrollHead.target = self;
    _scrollHead.directionalLockEnabled = YES;
    _scrollHead.pagingEnabled = NO;
    _scrollHead.showsHorizontalScrollIndicator = NO;
    _scrollHead.showsVerticalScrollIndicator = NO;
    _scrollHead.scrollsToTop = NO;  
    _scrollHead.scrollEnabled = NO;
    _scrollHead.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_pageslide.png"]];
    
    //初始化ctrls队列
    _viewCtrls = [[NSMutableArray alloc]init];
    
    //_leftLabel = [[UILabel alloc]init];
    //[_leftLabel setBackgroundColor:[UIColor clearColor]];
    //_leftLabel.font = [UIFont boldSystemFontOfSize:10];
    //_leftLabel.text = @">";
    
    //_rightLabel = [[UILabel alloc]init];
    //[_rightLabel setBackgroundColor:[UIColor clearColor]];
    //_rightLabel.font = [UIFont boldSystemFontOfSize:8];
    //_rightLabel.text = @">";
    
    _leftLabel= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arowleft.png"]];
    
    _rightLabel= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arowright.png"]];
    
    [self.view addSubview:_scrollv];
    [self.view addSubview:_scrollHead];
    

    
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentPage = 0;
    
    //[self loadScrollViewWithPage:-1];
    [self loadScrollViewWithPage:0];
    //[self loadScrollViewWithPage:1]; 
    
    [self loadHeadScrollViewWithPage:-1];
    [self loadHeadScrollViewWithPage:0];
    [self loadHeadScrollViewWithPage:1]; 
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


/* NB函数 */

//调整到指定页
- (void)selectToPage:(int)page
{
    _currentPage = page;
    [_scrollv scrollRectToVisible:CGRectMake(320*_currentPage, 0, _scrollv.frame.size.width, _scrollv.frame.size.height) animated:NO];
    [self reloadData];
}


//加载当前页
- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= _kNumberOfPages)
        return; 
    
    UIViewController *controller = [_viewCtrls objectAtIndex:page];
    
    //回调代理函数
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageSlideController:didSildeViewController:)]){
        [self.delegate pageSlideController:self didSildeViewController:controller];
    }
    
    // add the controller's view to the scroll view

    CGRect frame = _scrollv.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    frame.size.height = frame.size.height-77; //75是一个magic number
    controller.view.frame = frame;   
    if (controller.view.superview == nil)
    {
        [_scrollv addSubview:controller.view];
    }
}

//加载当前头
- (void)loadHeadScrollViewWithPage:(int)vpage
{ 
    int page =  vpage + 1 ;
    UILabel *head = [_headViews objectAtIndex:page]; 
    
    //回调代理函数
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageSlideController:didSildeHeaderLabel:)]){
        [self.delegate pageSlideController:self didSildeHeaderLabel:head];
    }
    
    if ((NSNull *)head == [NSNull null])
    {
        head = [[UILabel alloc] init];  
        head.textAlignment = UITextAlignmentCenter;
        head.backgroundColor = [UIColor clearColor];
        
        //if(vpage == _currentPage)head.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
        //else head.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:10];
        
        if (vpage >= 0 && vpage < _kNumberOfPages) {
            UIViewController *controller = [_viewCtrls objectAtIndex:vpage];
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
        head.font = [UIFont boldSystemFontOfSize:12]; 
        [_scrollHead addSubview:head];  
    }
}

//重新展现
- (void)reloadData
{
    //回调代理函数
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageSlideController:reloadData:)]){
        [self.delegate pageSlideController:self reloadData:_viewCtrls];
    }
    
    _kNumberOfPages = _viewCtrls.count;
    
    //清空_headviews,塞满空货
    if(_headViews){
        [_headViews removeAllObjects];
    }
    else{
        _headViews = [[NSMutableArray alloc]init];
    }
    for(int i =0;i<_viewCtrls.count+2;i++){
        [_headViews addObject:[NSNull null]];
    }
    
    //重新计算head和body的宽度并加载
    [_scrollv.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //[_scrollv removeFromSuperview];
    CGSize newSize = CGSizeMake(self.view.frame.size.width * _kNumberOfPages,  self.view.frame.size.height);
    [_scrollv setContentSize:newSize];
    //[self.view addSubview:_scrollv];
    
    [_scrollHead.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //[_scrollHead removeFromSuperview];
    float headwidth =  titleWidth * (_kNumberOfPages + 2 ) + (self.view.frame.size.width - 3*titleWidth ) / 2 *(_kNumberOfPages + 1);
    CGSize headSize = CGSizeMake(headwidth, 30);
    [_scrollHead setContentSize:headSize];
    //[self.view addSubview:_scrollHead];

    
    //加载初始页
    //[self loadScrollViewWithPage:_currentPage - 1];
    [self loadScrollViewWithPage:_currentPage];
    //[self loadScrollViewWithPage:_currentPage + 1];
    
    [self loadHeadScrollViewWithPage:_currentPage - 1];
    [self loadHeadScrollViewWithPage:_currentPage];
    [self loadHeadScrollViewWithPage:_currentPage + 1];  
    
    [self arrow];
    
    UILabel *head = [_headViews objectAtIndex:_currentPage+1];
    head.font =[UIFont boldSystemFontOfSize:14];
    head.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
  
    head = [_headViews objectAtIndex:_currentPage];
    head.font =[UIFont boldSystemFontOfSize:12];
    head.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
    
    head = [_headViews objectAtIndex:_currentPage + 2];
    head.font =[UIFont boldSystemFontOfSize:12];
    head.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
    
}

/* scrollview 代理函数 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	

    // Switch the indicator when more than 50% of the previous/next page is visible
    CGPoint newPiont = CGPointMake(_scrollv.contentOffset.x * ( (self.view.frame.size.width - titleWidth ) / (2*self.view.frame.size.width) )  , _scrollHead.contentOffset.y);  
    [_scrollHead setContentOffset:newPiont animated:NO];
    
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
            title.font = [UIFont boldSystemFontOfSize:12+2*fabs(v)]; 
            title.textColor =  [UIColor colorWithRed:(102-51*fabs(v))/255.0f green:(102-51*fabs(v))/255.0f blue:(102-51*fabs(v))/255.0f alpha:1];
        } 
    }
    CGFloat pageWidth = _scrollv.frame.size.width;
    int page = floor((_scrollv.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(_currentPage == page) return;
    _currentPage = page;

    if (_scrollv.contentOffset.x >= self.view.frame.size.width * (_kNumberOfPages-1)) { 
        return ;
    }
    if (_scrollv.contentOffset.x < 0 || _scrollv.contentOffset.x >= self.view.frame.size.width * _kNumberOfPages) {
        return ;
    }
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page];
    //[self loadScrollViewWithPage:page + 1];
    
    [self loadHeadScrollViewWithPage:page - 1];
    [self loadHeadScrollViewWithPage:page + 1];  
    //[self arrow];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_leftLabel removeFromSuperview];
    [_rightLabel removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self arrow];
}

- (void)arrow
{
  
    if(_currentPage == 0){
        CGRect frame = _rightLabel.frame;
        frame.origin.x = titleWidth-14;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _rightLabel.frame = frame; 
        [[_headViews objectAtIndex:_currentPage+2] addSubview:_rightLabel];
        
    }
    else if(_currentPage == _kNumberOfPages-1){
        CGRect frame = _leftLabel.frame;
        frame.origin.x = 3;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _leftLabel.frame = frame ; 
        [[_headViews objectAtIndex:_currentPage] addSubview:_leftLabel];
    }
    else{
        CGRect frame = _leftLabel.frame;
        frame.origin.x = 3;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _leftLabel.frame = frame ; 
        [[_headViews objectAtIndex:_currentPage] addSubview:_leftLabel];
    
        frame = _rightLabel.frame;
        frame.origin.x = titleWidth-14;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _rightLabel.frame = frame ; 
        [[_headViews objectAtIndex:_currentPage+2] addSubview:_rightLabel];
    }
    
    
}

@end
