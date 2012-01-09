//
//  EtaoLocalMapFootView.m
//  etao4iphone
//
//  Created by iTeam on 11-8-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalMapFootView.h"


@implementation EtaoLocalMapFootView

@synthesize _delegate,_action;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor clearColor]; 
		
		float x = 20.0f;
		float y = 20.0f;
		
		UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(x+0, y, 60, 35)]; 
		[leftButton setImage:[UIImage imageNamed:@"etaoMapPre.png"] forState:UIControlStateNormal];
		[leftButton setTitleColor:[UIColor blackColor] forState:UIControlEventTouchDown]; 		
		[leftButton addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[leftButton setTag:1]; 

		UIButton *centerButton = [[UIButton alloc] initWithFrame:CGRectMake(x+75, y, 60, 35)]; 
		[centerButton setImage:[UIImage imageNamed:@"etaoMaplocation.png"] forState:UIControlStateNormal];
		[centerButton setTitleColor:[UIColor blackColor] forState:UIControlEventTouchDown];  		
		[centerButton addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[centerButton setTag:0]; 
		centerButton.hidden = YES;
		
		UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(x+150, y, 60, 35)];
		[rightButton setImage:[UIImage imageNamed:@"etaoMapNext.png"] forState:UIControlStateNormal];
		[rightButton setTitleColor:[UIColor blackColor] forState:UIControlEventTouchDown];  		
		[rightButton addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[rightButton setTag:2]; 
		 
		
		[self addSubview:leftButton];
		[self addSubview:centerButton];
		[self addSubview:rightButton];
		
		[leftButton release];
		[centerButton release];
		[rightButton release];
		
		
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action{
	self._delegate = target;
	self._action = action; 
}

- (void)downButtonPressed:(id)sender{
	if (self._delegate && self._action && [self._delegate  respondsToSelector:self._action]) {
		[self._delegate  performSelectorOnMainThread:self._action withObject:sender waitUntilDone:YES];
	}	
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
