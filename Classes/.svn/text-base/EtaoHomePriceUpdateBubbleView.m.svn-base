//
//  EtaoHomePriceUpdateBubbleView.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoHomePriceUpdateBubbleView.h"

@implementation EtaoHomePriceUpdateBubbleView
@synthesize  bubbleLabel = _bubbleLabel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *bubble = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homebubble.png"]]autorelease];
        [bubble setFrame:CGRectMake(0.0f, 0.0f , 30.f, 25.0f)]; 
        [self addSubview:bubble];  
        
        self.bubbleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(2.5f, -1.0f , 25.f, 23.0f)] autorelease];
        [_bubbleLabel setText:@""];
        [_bubbleLabel setFont:[UIFont systemFontOfSize:10]];
        [_bubbleLabel setTextColor:[UIColor whiteColor]];
        [_bubbleLabel setBackgroundColor:[UIColor clearColor]];
        [_bubbleLabel setTextAlignment:UITextAlignmentCenter];
        [_bubbleLabel setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f]];
        [self addSubview:_bubbleLabel];  
        self.alpha = 0.0;
    }
    return self;
}


- (void) setNumber:(int)num{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4]; 
    if (num == 0 ) {  
        self.alpha = 0.0;
    }
    else if(num > 100 )
    {
        _bubbleLabel.text = [NSString stringWithFormat:@"100+"];
        self.alpha = 1.0 ;
    } 
    else
    {
        _bubbleLabel.text = [NSString stringWithFormat:@"%d",num];
        self.alpha = 1.0 ;
    }
    [UIView commitAnimations]; 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
