//
//  EtaoNoResultView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoNoResultView.h"


@implementation EtaoNoResultView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
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

- (void) setText:(NSString*) message {
	
	for (UIView *v in [self subviews]) {
		[v removeFromSuperview];
	} 
	
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(self.frame.origin.x + 20 , self.frame.origin.y + 50,
																	  self.frame.size.width - 40 , 40)] autorelease];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [NSString stringWithFormat:@"%@",message];
	titleLabel.font = [UIFont systemFontOfSize:14];
	titleLabel.textColor = [UIColor blackColor]; 
	titleLabel.textAlignment =  UITextAlignmentCenter ;
	titleLabel.numberOfLines = 2;
	
}


- (void)dealloc {
    [super dealloc];
}


@end
