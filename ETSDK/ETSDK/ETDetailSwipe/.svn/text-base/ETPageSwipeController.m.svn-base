//
//  ETPageSwipeController.m
//  etao4iphone
//
//  Created by 左 昱昊 on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ETPageSwipeController.h"
#import "EtaoTuanCommonAnimations.h"

@implementation ETPageSwipeController
@synthesize swipeLeftRecognizer = _swipeLeftRecognizer ;
@synthesize swipeRightRecognizer = _swipeRightRecognizer ;

+(void) showRightShakeAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(10, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-10, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
}

+(void) showLeftShakeAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-10, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(10, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
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

- (void)dealloc{
    
    [_swipeRightRecognizer release];
    [_swipeLeftRecognizer release];

    
    [_thisCtrls release];
    [_nextCtrls release];

    
    [super dealloc];
    
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.swipeLeftRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
    [_swipeLeftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:_swipeLeftRecognizer]; 
    
    self.swipeRightRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
    [_swipeRightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:_swipeRightRecognizer]; 
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_arrow.png"] target:self action:@selector(UIBarButtonHomeClick:)]autorelease];      
    self.navigationItem.leftBarButtonItem = back;
    
    self.title = [NSString stringWithFormat:@"详情页 %d/%d",_index+1,[_items count]];
    id item = [_items objectAtIndex:_index];
    _thisCtrls = [[_detailClass alloc]initWithItem:item]; 
    _thisCtrls.view.frame = CGRectMake(0, 0,320,370);
    [self.view addSubview:_thisCtrls.view];     

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

#pragma mark -V back
//主nav返回
- (void) UIBarButtonHomeClick:(UIBarButtonItem*)sender{ 
    //向代理发送信息
    if(_delegate && [_delegate respondsToSelector:@selector(swipeWillExitAtIndex:)]){
        [_delegate performSelector:@selector(swipeWillExitAtIndex:) 
                        withObject:[NSNumber numberWithInt:_index]];
    }
    
   [self.navigationController popViewControllerAnimated:YES];  
} 

#pragma mark -V init

- (id)initWithItems:(NSMutableArray *)items 
         withDelegate:(id<ETPageSwipeDelegate>)delegate 
              atIndex:(int)index 
        byDetailClass:(Class<ETPageSwipeDetailDelegate>)detailClass{
    
    self = [self init];
    _detailClass = detailClass;
    _index = index;
    _items = items;
    _delegate = delegate;
    return self;
}

#pragma mark -V Recognizer Delegate
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    int toward;
    
    CGPoint location = [recognizer locationInView:self.view]; 
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
        [[self class] showRightShakeAnimation:_thisCtrls.view];
        _index = 0 ;
        return;
    }
    if (_index >= [_items count]) { 
        _index = [_items count] - 1;
        [[self class] showLeftShakeAnimation:_thisCtrls.view];
        return;
    }
    
    id item = [_items objectAtIndex:_index];
    _nextCtrls = [[_detailClass alloc] initWithItem:item]; 
    _nextCtrls.view.frame = CGRectMake(_nextCtrls.view.frame.origin.x + toward, 0, _nextCtrls.view.frame.size.width,  _nextCtrls.view.frame.size.height);
    [self.view addSubview:_nextCtrls.view];
    
    
    //向代理发送信息
    if(_delegate && [_delegate respondsToSelector:@selector(swipeAtIndex:withCtrls:)]){
        [_delegate performSelector:@selector(swipeAtIndex:withCtrls:) 
                        withObject:[NSNumber numberWithInt:_index]
                        withObject:_nextCtrls];
    }
    
    [UIView animateWithDuration:0.4 
                     animations:^{
                         for (UIView *view in [self.view subviews]) {
                             view.frame = CGRectMake(view.frame.origin.x - toward, view.frame.origin.y, view.frame.size.width, 370);
                         }
                     }
                     completion:^(BOOL finished){ 
                         [_thisCtrls.view removeFromSuperview]; 
                         [_thisCtrls release];
                         _thisCtrls = _nextCtrls;
                         _nextCtrls = nil;
                     }
     ];  

    self.title = [NSString stringWithFormat:@"详情页 %d/%d",_index+1,[_items count]];

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch { 
    return YES;
}

@end
