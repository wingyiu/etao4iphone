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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
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

@end
