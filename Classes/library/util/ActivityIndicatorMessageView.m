//
//  ActivityIndicatorMessageView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityIndicatorMessageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ActivityIndicatorMessageView


@synthesize _activityIndicator ;
@synthesize _message ;
- (id)initWithFrame:(CGRect)frame Message:(NSString*)msg {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.tag = ActivityIndicatorMessageView_TAG;
 
		self._activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
		
		self._activityIndicator.frame = CGRectMake((frame.size.width - 30 ) /2  , 10 , 30.0f, 30.0f);
		self._activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		
		
		UILabel* detailLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(5, 40, frame.size.width - 10 , 40)] autorelease]; 
		detailLabel.text = msg ;
		detailLabel.font = [UIFont systemFontOfSize: 12];
		detailLabel.textAlignment = UITextAlignmentCenter;
		detailLabel.numberOfLines = 2 ;
		detailLabel.backgroundColor = [UIColor clearColor];
		detailLabel.textColor = [UIColor blackColor]; 
		
		[self addSubview:self._activityIndicator];
		[self addSubview:detailLabel];
		
		//self.backgroundColor = [UIColor colorWithRed:0.1686 green:0.6509 blue:0.8235 alpha:1.0]; 
		self.backgroundColor = [UIColor clearColor];
        // Initialization code.
	 
    }
    return self;
}

- (void) startAnimating {
 	
	self.hidden = NO;
  	self.alpha = 0.0; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
 	self.alpha = 1.0;
	[UIView commitAnimations];
	
	[self._activityIndicator startAnimating];  	
}

- (void) stopAnimating {  
 	self.alpha = 1.0; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
 	self.alpha = 0.0;
	[UIView commitAnimations]; 
	[self._activityIndicator stopAnimating]; 
	[self removeFromSuperview];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)dealloc {
    [super dealloc];
}



@end
