//
//  ETFilterController.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETFilterController.h"

@implementation ETFilterController
@synthesize panGes = _panGes;
@synthesize delegate = _delegate;
@synthesize view = _view;

- (void) dealloc {
    [_panGes release];
    [_etFilterViewController.view removeFromSuperview];
    [_etFilterViewController release];
    [super dealloc];
}


- (void) initWithDelegate: (id<NSObject>) delegate{
    if ([delegate isMemberOfClass:[UIViewController class]]) {
        self.delegate = delegate;
        _parent = (UIViewController*)delegate;
        self.view = ((UIViewController*)_delegate).view;
        
        self.panGes = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)]autorelease];
        
        _etFilterViewController = [[ETFilterViewController alloc]init];
        _etFilterViewController.delegate = self;
        
        [self.view addGestureRecognizer:_panGes];
        
        UIView *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:_etFilterViewController.view];
        [window sendSubviewToBack:_etFilterViewController.view]; 
        
    }
    
    
}

- (void) setParentFrameX:(float)x withAnimation:(float)sec{
    if ( sec > 0.0 ) {
        [UIView beginAnimations:nil context:nil]; 
        [UIView setAnimationDuration:sec];
    }
    if (_parent.navigationController != nil) {
        _parent.navigationController.view.frame = CGRectMake(x, 
                                                             _parent.navigationController.view.frame.origin.y,
                                                             _parent.navigationController.view.frame.size.width,
                                                             _parent.navigationController.view.frame.size.height); 
    }
    else
    {
        _parent.view.frame = CGRectMake(x, 
                                        _parent.view.frame.origin.y,
                                        _parent.view.frame.size.width,
                                        _parent.view.frame.size.height);  
    } 

    if ( sec > 0.0 ) {
        [UIView commitAnimations];
    }
}

- (float) getParentFrameX {
    if (_parent.navigationController != nil) {
        return _parent.navigationController.view.frame.origin.x;
    }
    return _parent.view.frame.origin.x;

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handelPan:(UIPanGestureRecognizer*)gestureRecognizer{
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    CGPoint curPoint = [gestureRecognizer locationInView:[self.view window] ]; 
    
    CGPoint ver = [gestureRecognizer velocityInView:[[UIApplication sharedApplication] keyWindow]];
    if (ver.x > 0 && _beginx == 0 && [self getParentFrameX ] == 0.0) {
        return ;
    }
    
    
    
    if (_beginx == 0) {
        _lastpos = [self getParentFrameX ] ;
        _beginx = curPoint.x ;
    }
    if (_lastpos + (curPoint.x - _beginx) >=0 ) { 
        [self setParentFrameX:0.0 withAnimation:0.1];
        
        if ( gestureRecognizer.state == UIGestureRecognizerStateEnded ){  
        }
        return ;
    }
    [self setParentFrameX:(_lastpos + curPoint.x - _beginx) withAnimation:0]; 
    
    
    if ([self getParentFrameX] >= 0 ) {
//        _filterView.tableView.frame = CGRectMake(0, 20, _filterView.tableView.frame.size.width, _filterView.tableView.frame.size.height);
    }
    else
    {
 //       _filterView.tableView.frame = CGRectMake(60, 20, _filterView.tableView.frame.size.width , _filterView.tableView.frame.size.height); 
    }
    
    if ( gestureRecognizer.state == UIGestureRecognizerStateBegan ){ 
        _beginx = curPoint.x ;  
    }
    
    if ( gestureRecognizer.state == UIGestureRecognizerStateEnded ){ 
        _beginx = 0 ; 
        float toSize = 0 ; 
        if (ver.x < 0 && [self getParentFrameX] < -16 ) {
            toSize = -260;
        }
        if (ver.x > 0 && [self getParentFrameX] < -240) {
            toSize = -260;
        }
        [self setParentFrameX:toSize withAnimation:0.1]; 
        
        if ( toSize == 0 ) { 
            // 
        }
        
    }
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{ 
    CGPoint translation = [gestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
    
    // Check for horizontal gesture
    if (sqrt(translation.x * translation.x) / sqrt(translation.y * translation.y) > 1)
    { 
        return YES;
    }
    
    return NO;
}

@end
