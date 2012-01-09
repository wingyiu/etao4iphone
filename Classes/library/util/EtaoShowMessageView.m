//
//  EtaoShowMessageView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoShowMessageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation EtaoShowMessageView


- (id)initWithFrame:(CGRect)frame Message:(NSString*)msg { 
    
    self = [super initWithFrame:frame];
    if (self) {      
		
		self.tag = EtaoShowMessageView_TAG; 
		UILabel* detailLabel = [[[UILabel alloc ] initWithFrame:frame] autorelease];  
		detailLabel.text = msg ;
		detailLabel.font = [UIFont systemFontOfSize: 12];
		detailLabel.textAlignment = UITextAlignmentCenter;
		detailLabel.numberOfLines = 1 ; 
		detailLabel.textColor = [UIColor whiteColor];  
	 	detailLabel.backgroundColor = [UIColor blackColor]; 
 		self.alpha = 0.6 ;
		[self addSubview:detailLabel];
	//	[self performSelector:@selector(deleteMe) withObject:nil  afterDelay:10.0]; 
		  
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void) deleteMe{
	
	self.alpha = 0.6; 
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	self.alpha = 0.0;
	[UIView commitAnimations]; 
	//self.hidden = YES;  
	[self performSelector:@selector(removeFromSuperview) withObject:nil  afterDelay:1.0];
  //	[self removeFromSuperview];
}

- (void)dealloc {
    [super dealloc];
}


@end
