//
//  MapLoadingView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapLoadingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MapLoadingView


- (id)initWithFrame:(CGRect)frame Message:(NSString*)msg {
    
    self = [super initWithFrame:frame];
    if (self) { 		
		self._activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
		
		self._activityIndicator.frame = CGRectMake(5.0f,5.0f, frame.size.height - 10.0f,frame.size.height - 10.0f);
		self._activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin; 	 		
		[self addSubview:self._activityIndicator];  
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

- (void)dealloc {
    [super dealloc];
}


@end
