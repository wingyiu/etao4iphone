//
//  ETPageSlideController.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETPageSlideController.h"

#define CACHE_CAPACITY  10      //缓存的容量

@implementation ETPageSlideController
@synthesize delegate = _delegate;
@synthesize viewBody = _viewBody;

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

- (void)dealloc
{
    
    [_headArray removeAllObjects];
    [_bodyArray removeAllObjects];
    [_keyArray removeAllObjects];
    
    
    [_headArray release];
    [_bodyArray release];
    [_keyArray release];
    
    [_ctrlsCache removeAllObjects];
    [_ctrlsCache release];
    
    [_viewHead release];
    [_viewBody release];
    [_leftLabel release];
    [_rightLabel release];
    
    [_activityView release];
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    _ctrlsCache = [[NSMutableDictionary alloc]initWithCapacity:CACHE_CAPACITY];
    
//    CGRect frame = self.view.frame;
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    frame.size.width = 320;
//    frame.size.height = 416;
//    self.view.frame = frame;
    
    //初始化头view
    _viewHead = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 30)]; 
    _viewHead.directionalLockEnabled = YES;
    _viewHead.pagingEnabled = NO;
    _viewHead.showsHorizontalScrollIndicator = NO;
    _viewHead.showsVerticalScrollIndicator = NO;
    _viewHead.scrollsToTop = NO;  
    _viewHead.scrollEnabled = YES;
    _viewHead.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_pageslide.png"]];
    _viewHead.delegate = self;
    
    //初始化主view
    _viewBody = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 30.0, self.view.frame.size.width, 416)];
    _viewBody.directionalLockEnabled = YES;
    _viewBody.pagingEnabled = YES;
    _viewBody.showsHorizontalScrollIndicator = NO;
    _viewBody.showsVerticalScrollIndicator = NO;
    _viewBody.scrollsToTop = YES; 
    _viewBody.delegate = self; 
    _viewBody.backgroundColor = [UIColor whiteColor];
    
    _leftLabel= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arowleft.png"]];
    _rightLabel= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arowright.png"]];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:_viewHead];
    [self.view addSubview:_viewBody];
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



#pragma mark -Apis
- (void)autoScrollUnLock{
    _autoScrollLock = NO;
}

/*
 *清空cache里的某一个对象
 */
- (void)removeCtrls:(id)key{
    [_ctrlsCache removeObjectForKey:key];
}

/*
 * 判断队列当前cache里是否有对应的body，没有就请求，并加载
 */
- (void)loadPage:(NSNumber*)page
{
    
    _currentPage = [page intValue];
    UIViewController* body = nil;

    //判断bodyArray里面对应的列是否有数据
    NSString* body_title = [_bodyArray objectAtIndex:[page integerValue]];
    NSString* key_title = [_keyArray objectAtIndex:[page integerValue]];
    if([body_title isEqual:key_title]==NO){
        if([_ctrlsCache objectForKey:key_title]==nil){
            if(_delegate && 
           [_delegate respondsToSelector:@selector(pageForColAtIndexPath:)]){
                body = [_delegate pageForColAtIndexPath:page];
                CGRect frame = body.view.frame;
                frame.origin.x = frame.size.width * _currentPage;
                frame.origin.y = 0;
  //              frame.size.height = 416-30;//self.view.frame.size.height-30;
                body.view.frame = frame;
                [_ctrlsCache setObject:body forKey:key_title];
     
            }
        }
        else{
            body = [_ctrlsCache objectForKey:key_title];
            CGRect frame = body.view.frame;
            frame.origin.x = frame.size.width * _currentPage;
            body.view.frame = frame;
        }
        
        [_bodyArray replaceObjectAtIndex:[page integerValue] withObject:key_title];
        if(body.view.superview == nil){

            [_viewBody performSelector:@selector(addSubview:) withObject:body.view afterDelay:0.0];//利用performSelector来实现异步的请求
        }
        else{
            NSLog(@"some thins is wrong!");
        }
    }
    else{
        NSString* key = [_bodyArray objectAtIndex:[page integerValue]];
        body = [_ctrlsCache objectForKey:key];
    }
    
    //告诉代理，滑动到指定页面
    if([_delegate respondsToSelector:@selector(slidePageForColAtIndexPath:withCtrls:)]){
        [_delegate slidePageForColAtIndexPath:page withCtrls:body];
    }
}

/* 对外api 
 * 重新加载指定页，把原来的页去除
 */
- (void)reloadPage:(NSNumber *)page
{
    //获取索引
    if(_delegate && [_delegate respondsToSelector:@selector(getAllKeys)]){
        if (_keyArray!=nil)[_keyArray release];
        _keyArray = [[_delegate performSelector:@selector(getAllKeys)] retain];
    }
    
    UIViewController* body = nil;
    //删除原有的page
    for(int i =0;i<_bodyArray.count;i++){
        NSString* body_title = [_bodyArray objectAtIndex:i];
        NSString* key_title = [_keyArray objectAtIndex:i];
        if([body_title isEqual:key_title]==NO){
            body = [_ctrlsCache objectForKey:body_title];
            [body.view removeFromSuperview];
            body = [_ctrlsCache objectForKey:key_title];
            if(body !=nil){
                CGRect frame = body.view.frame;
                frame.origin.x = frame.size.width * i; //调整x坐标
                body.view.frame = frame;
                [_viewBody addSubview:body.view];
                [_bodyArray replaceObjectAtIndex:i withObject:key_title];
            }
            else{
                [_bodyArray replaceObjectAtIndex:i withObject:@""];

            }
        }
    }
    
    //增加动画效果
    if(_currentPage != [page intValue]){
        _currentPage = [page intValue];
        [_leftLabel removeFromSuperview];
        [_rightLabel removeFromSuperview];
        [self arrow];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [_viewBody scrollRectToVisible:
         CGRectMake(self.view.frame.size.width * [page intValue], 30, _viewBody.frame.size.width, _viewBody.frame.size.height) animated:NO];
        [UIView commitAnimations];
    }
    
    //加载新页面
    [self loadPage:page];
}

/* 对外api
 * 重新获取索引头，加载进header里面，清空队列，重新加载第一页。
 */
- (void)reloadData
{
    //获取索引
    if(_delegate && [_delegate respondsToSelector:@selector(getAllKeys)]){
        if (_keyArray!=nil)[_keyArray release];
        _keyArray = [[_delegate performSelector:@selector(getAllKeys)] retain];
    }
    
    //获取头部
    if(_delegate && [_delegate respondsToSelector:@selector(getAllHeaders)]){
        if (_headArray!=nil)[_headArray release];
        _headArray = [[_delegate performSelector:@selector(getAllHeaders)] retain];
    }
    
    
    _countOfPage = _keyArray.count;
    
    //重新计算body的宽度，并且通过匹配重新调整body内view的布局
    CGSize newSize = CGSizeMake(self.view.frame.size.width * _countOfPage, 416);
    [_viewBody setContentSize:newSize];
    NSMutableArray* newBodyArray = [[NSMutableArray alloc]initWithCapacity:_keyArray.count];
    for(int i=0;i < _keyArray.count;i++){
        int j = 0;
        NSString* head_title = nil;
        NSString* body_title = nil;
        for(j=0; j<_bodyArray.count;j++){
            head_title = [_keyArray objectAtIndex:i];
            body_title = [_bodyArray objectAtIndex:j];
            if([head_title isEqualToString:body_title]){
                UIViewController* body = [_ctrlsCache objectForKey:head_title];
                CGRect frame = body.view.frame;
                frame.origin.x = frame.size.width * i; //调整x坐标
                body.view.frame = frame;
                [newBodyArray addObject:head_title];
                break;
            }
        }
        if(j == _bodyArray.count){
            UIViewController* body = [_ctrlsCache objectForKey:head_title];
            if(body == nil){
                [newBodyArray addObject:@""];
            }
            else{
                CGRect frame = body.view.frame;
                frame.origin.x = frame.size.width * i; //调整x坐标
                body.view.frame = frame;
                [_viewBody addSubview:body.view];
                [newBodyArray addObject:head_title];
            }
        }
    }
    
    //反向查找，去除已经不存在的body
    for(int i = 0; i<_bodyArray.count ; i++){
        int j = 0;
        for(j=0;j<newBodyArray.count;j++){
            NSString* old_body_title = [_bodyArray objectAtIndex:i];
            NSString* new_body_title = [newBodyArray objectAtIndex:j];
            if([old_body_title isEqualToString:new_body_title])break;
        }
        if (j == newBodyArray.count){
            NSString* old_body_title = [_bodyArray objectAtIndex:i];
            UIViewController* body = [_ctrlsCache objectForKey:old_body_title];
            [body.view removeFromSuperview];
        }
    }

    //清空body队列，但不清空cache
    [_bodyArray removeAllObjects];
    [_bodyArray release];
    _bodyArray = newBodyArray;

    //重新计算head的宽度，全部重新加载
    float headwidth =  titleWidth * (_countOfPage + 2 ) + (self.view.frame.size.width - 3*titleWidth ) / 2 *(_countOfPage + 1);
    CGSize headSize = CGSizeMake(headwidth, 30);
    [_viewHead setContentSize:headSize];
    [_viewHead.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(int i=0;i<_headArray.count+2;++i){
        NSString* title = nil;
        if(i == 0 || i == _headArray.count+1) title = @"";
        else title = [_headArray objectAtIndex:i-1];
        UILabel* head = [[[UILabel alloc] init] autorelease];
        head.userInteractionEnabled = YES;
        if(i==1)head.font =[UIFont boldSystemFontOfSize:14];
        else head.font = [UIFont boldSystemFontOfSize:12]; 
        head.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
        [head setBackgroundColor:[UIColor clearColor]];
        head.text = title;
      
        head.textAlignment = UITextAlignmentCenter;
        CGRect frame = _viewHead.frame;
        frame.origin.y = 0;
        frame.size.width = titleWidth ;
        frame.origin.x =  (_viewHead.frame.size.width - frame.size.width ) / 2 * (i);
        head.frame = frame;
        ETPageTouchView* touchView = [[[ETPageTouchView alloc]initWithFrame:CGRectMake(0, 0, titleWidth, 30)]autorelease];
        touchView.page = (i>0 && i<=_headArray.count)?i-1:-1;
        touchView.delegate = self.delegate;
        [touchView setBackgroundColor:[UIColor clearColor]];
        [head addSubview:touchView];
        [_viewHead addSubview:head];
    }
    
    //动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [_viewBody scrollRectToVisible:CGRectMake(0, 30, _viewBody.frame.size.width, _viewBody.frame.size.height) animated:NO];
    [UIView commitAnimations];

    [self arrow];
    //重新加载当前页
    [self loadPage:[NSNumber numberWithInt:0]];
}

#pragma mark -ScrollView Delegate
/*
 *scroll 滑动代理函数
 * 每次只加在当前页
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
    if(scrollView == _viewBody){
        //动态滑动头部的位置
        CGPoint newPiont = CGPointMake(_viewBody.contentOffset.x * ( (self.view.frame.size.width - titleWidth ) / (2*self.view.frame.size.width) )  , _viewHead.contentOffset.y);  
        [_viewHead setContentOffset:newPiont animated:NO];
        
        //head文字渐变
        const double PI = 3.1415926; 
        for (UILabel *title in _viewHead.subviews) {
            if ((NSNull *)title!=[NSNull null]) {
                if (newPiont.x > title.frame.origin.x) {
                    continue;
                }
                if (newPiont.x + 240 < title.frame.origin.x) {
                    continue;
                }
                float v = sin((newPiont.x+title.frame.origin.x)/240 * PI);
                title.font = [UIFont boldSystemFontOfSize:12+2*fabs(v)]; 
                //title.textColor =  [UIColor colorWithRed:(102-51*fabs(v))/255.0f green:(102-51*fabs(v))/255.0f blue:(102-51*fabs(v))/255.0f alpha:1];
            } 
        }
        
        //如果侦测到滑动导致了翻页
        CGFloat pageWidth = _viewBody.frame.size.width;
        int page = floor((_viewBody.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        if(_currentPage == page) return;
        _currentPage = page;
        
        if (_viewBody.contentOffset.x >= self.view.frame.size.width * (_countOfPage-1)) { 
            return ;
        }
        if (_viewBody.contentOffset.x < 0 || _viewBody.contentOffset.x >= self.view.frame.size.width * _countOfPage) {
            return ;
        }
        
        NSString* key = [_bodyArray objectAtIndex:_currentPage];
        if([key isEqualToString:@""]){
            //加载动画
            _activityView.frame = CGRectMake(140+_currentPage*320,178,40,40);
            [_viewBody addSubview:_activityView];
            [_activityView startAnimating];
            [_activityView performSelector:@selector(stopAnimating) withObject:nil afterDelay:0.5];
        }
        
        [self performSelector:@selector(loadPage:) withObject:[NSNumber numberWithInt:_currentPage] afterDelay:0.0];
    }
    else if(scrollView == _viewHead){
        if(_viewHead.decelerating){
            if(fabs(_last_head_x - _viewHead.contentOffset.x)<3.0){
                [self orientation];
            }
            _last_head_x = _viewHead.contentOffset.x;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_leftLabel removeFromSuperview];
    [_rightLabel removeFromSuperview];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(scrollView == _viewHead  && !decelerate){
        [self orientation];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self arrow];
}

- (void)orientation{
    int orign_x = (int)(_viewHead.frame.size.width - titleWidth ) / 2;
    //找出离得最近得一个head
    int headNumber = _viewHead.contentOffset.x/orign_x;
    int scrollPage ;
    if((2*headNumber+1)*orign_x>2*_viewHead.contentOffset.x){
        scrollPage = headNumber;
    }
    else{
        scrollPage = headNumber+1;
    }
    if(scrollPage >= _countOfPage)scrollPage = _countOfPage-1;
    if(scrollPage < 0) scrollPage = 0;
    
    if(scrollPage!=_currentPage){
        _currentPage = scrollPage;
        //动画
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [_viewBody scrollRectToVisible:CGRectMake(_currentPage*_viewBody.frame.size.width, 30, _viewBody.frame.size.width, _viewBody.frame.size.height) animated:NO];
        [UIView commitAnimations];
        
        //加载
        [self performSelector:@selector(loadPage:) withObject:[NSNumber numberWithInt:_currentPage] afterDelay:0.0];
    }
    else{//滑动未超过一页篇幅，头部滑回原来得位置
        //动画
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [_viewHead scrollRectToVisible:CGRectMake(_currentPage*orign_x, 0, _viewBody.frame.size.width, _viewBody.frame.size.height) animated:NO];
        [UIView commitAnimations];
    }
    [self arrow];
}

- (void)arrow
{
    if(_currentPage == 0 && _countOfPage==1){
        return;
    }
    else if(_currentPage == 0){
        CGRect frame = _rightLabel.frame;
        frame.origin.x = titleWidth-14;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _rightLabel.frame = frame; 
        [[_viewHead.subviews objectAtIndex:2] addSubview:_rightLabel];
        
    }
    else if(_currentPage == _countOfPage-1){
        CGRect frame = _leftLabel.frame;
        frame.origin.x = 3;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _leftLabel.frame = frame ; 
        [[_viewHead.subviews objectAtIndex:_currentPage] addSubview:_leftLabel];
    }
    else{
        CGRect frame = _leftLabel.frame;
        frame.origin.x = 3;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _leftLabel.frame = frame ; 
        [[_viewHead.subviews objectAtIndex:_currentPage] addSubview:_leftLabel];
        
        frame = _rightLabel.frame;
        frame.origin.x = titleWidth-14;
        frame.origin.y = 8;
        frame.size.width = 11;
        frame.size.height = 11;
        _rightLabel.frame = frame ; 
        [[_viewHead.subviews objectAtIndex:_currentPage+2] addSubview:_rightLabel];
    }
}

@end
