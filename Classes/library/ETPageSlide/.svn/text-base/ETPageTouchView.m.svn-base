//
//  ETPageTouchView.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETPageTouchView.h"

@implementation ETPageTouchView
@synthesize delegate = _delegate;
@synthesize page = _page;

@synthesize swipeLeftRecognizer = _swipeLeftRecognizer;
@synthesize swipeRightRecognizer = _swipeRightRecognizer;
@synthesize swipeUpRecognizer = _swipeUpRecognizer;
@synthesize swipeDownRecognizer = _swipeDownRecognizer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        //Left
        self.swipeLeftRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
        [_swipeLeftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:_swipeLeftRecognizer]; 
        //Right
        self.swipeRightRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
        [_swipeRightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:_swipeRightRecognizer]; 
        //Up
        self.swipeUpRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
        [_swipeUpRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [self addGestureRecognizer:_swipeUpRecognizer]; 
        //Down
        self.swipeDownRecognizer = [[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)]autorelease]; 
        [_swipeDownRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
        [self addGestureRecognizer:_swipeDownRecognizer]; 
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc{
    [_swipeUpRecognizer release];
    [_swipeDownRecognizer release];
    [_swipeLeftRecognizer release];
    [_swipeRightRecognizer release];
    _delegate = nil;
}


- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    if(_delegate && [_delegate respondsToSelector:@selector(SingleTouch:)]){
        [_delegate performSelector:@selector(SingleTouch:) withObject:self];
    }
    
    [self.nextResponder touchesEnded: touches withEvent:event]; 
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesEnded: touches withEvent:event]; 
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
     if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
         if(_delegate && [_delegate respondsToSelector:@selector(leftSlideTouch:)]){
             [_delegate performSelector:@selector(leftSlideTouch:) withObject:self];
         }
     }
     else if(recognizer.direction == UISwipeGestureRecognizerDirectionRight){
         if(_delegate && [_delegate respondsToSelector:@selector(rightSlideTouch:)]){
             [_delegate performSelector:@selector(rightSlideTouch:) withObject:self];
         }
     }
     else if(recognizer.direction == UISwipeGestureRecognizerDirectionUp){
         if(_delegate && [_delegate respondsToSelector:@selector(upSlideTouch:)]){
             [_delegate performSelector:@selector(upSlideTouch:) withObject:self];
         }
     }
     else if(recognizer.direction == UISwipeGestureRecognizerDirectionDown){
         if(_delegate && [_delegate respondsToSelector:@selector(downSlideTouch:)]){
             [_delegate performSelector:@selector(downSlideTouch:) withObject:self];
         }
     }
}

@end
