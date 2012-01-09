//
//  EtaoQueryTypeView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoQueryTypeView.h"


@implementation EtaoQueryTypeView
 
@synthesize _left,_right,_center,_labels;
@synthesize _left1,_right1,_center1;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code. 
		self.backgroundColor = [UIColor clearColor];
		
		UIView *tmp = [[[UIView alloc]initWithFrame:CGRectMake(-10, 0, 10,frame.size.height)]autorelease];
		tmp.backgroundColor = [UIColor whiteColor];
		tmp.backgroundColor = [[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"EtaoHomeBackground.png"]]autorelease];
		
		tmp.tag = 1001;
		
		UIView *tmp1 = [[[UIView alloc]initWithFrame:CGRectMake(300, 0, 10,frame.size.height)]autorelease];
		tmp1.backgroundColor = [UIColor whiteColor];
		tmp1.backgroundColor = [[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"EtaoHomeBackground.png"]]autorelease];
		tmp1.tag = 1002; 
		
		[self addSubview:tmp];
		[self addSubview:tmp1];
		
		self._labels = [NSMutableArray arrayWithCapacity:10];
		
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

- (void) setView:(NSArray*) texts {
	float x = 0.0f;
	UILabel *left = [[[UILabel alloc]initWithFrame:CGRectMake(x+0,0,80, 40)]autorelease];
	left.text = [texts objectAtIndex:0];
	left.textAlignment = UITextAlignmentCenter;
	left.backgroundColor = [UIColor clearColor]; 
	left.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f blue:114/255.0f alpha:1.0];
	left.font = [UIFont systemFontOfSize:16];
	self._left = left;
	
	UILabel *centerLabel = [[[UILabel alloc]initWithFrame:CGRectMake(x+110,0,80, 40)]autorelease];
	centerLabel.text = [texts objectAtIndex:1];
	centerLabel.backgroundColor = [UIColor clearColor];
	centerLabel.textAlignment = UITextAlignmentCenter; 
	centerLabel.textColor = [UIColor colorWithRed:14/255.0f green:120/255.0f blue:159/255.0f alpha:1.0];
	centerLabel.shadowColor = [UIColor whiteColor];
	centerLabel.font = [UIFont systemFontOfSize:18];
	CGSize s = {0,2};
	centerLabel.shadowOffset = s;
	self._center = centerLabel;
	
	UILabel *right = [[[UILabel alloc]initWithFrame:CGRectMake(x+220,0,80, 40)]autorelease];
	right.text = [texts objectAtIndex:2];
	right.backgroundColor = [UIColor clearColor];
	right.textAlignment = UITextAlignmentCenter;
	right.font = [UIFont systemFontOfSize:16];
	right.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f blue:114/255.0f alpha:1.0];
	self._right = right;
	
	UILabel *left1 = [[[UILabel alloc]initWithFrame:CGRectMake(x+0,0,80, 40)]autorelease];
	left1.text = [texts objectAtIndex:0];
	left1.textAlignment = UITextAlignmentCenter;
	left1.backgroundColor = [UIColor clearColor]; 
	left1.font = [UIFont systemFontOfSize:16];
	left1.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f blue:114/255.0f alpha:1.0];
	self._left1 = left1;
	self._left1.alpha = 0;
	
	
	UILabel *centerLabel1 = [[[UILabel alloc]initWithFrame:CGRectMake(x+110,0,80, 40)]autorelease];
	centerLabel1.text = [texts objectAtIndex:1];
	centerLabel1.backgroundColor = [UIColor clearColor];
	centerLabel1.textAlignment = UITextAlignmentCenter; 
	centerLabel1.textColor = [UIColor colorWithRed:14/255.0f green:120/255.0f blue:159/255.0f alpha:1.0];
	centerLabel1.shadowColor = [UIColor whiteColor]; 
	centerLabel1.shadowOffset = s;
	centerLabel1.font = [UIFont systemFontOfSize:18];
	self._center1 = centerLabel1;
	self._center1.alpha = 0;
	
	UILabel *right1 = [[[UILabel alloc]initWithFrame:CGRectMake(x+220,0,80, 40)]autorelease];
	right1.text = [texts objectAtIndex:2];
	right1.backgroundColor = [UIColor clearColor];
	right1.textAlignment = UITextAlignmentCenter;
	right1.font = [UIFont systemFontOfSize:16];
	right1.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f blue:114/255.0f alpha:1.0];
	self._right1 = right1;
	self._right1.alpha = 0;
	
	[self addSubview:_left];
	[self addSubview:_center];
	[self addSubview:_right];
	
	[self addSubview:_left1];
	[self addSubview:_center1];
	[self addSubview:_right1];
	
} 
 


- (void) set:(NSArray*) texts animated:(BOOL)animated left:(BOOL)b{
 	float x = 100.0f;
	if (b) {
		x = -110.f;
	}
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3]; 
		[_left setFrame:CGRectMake(_left.frame.origin.x + x/2, _left.frame.origin.y, _left.frame.size.width,_left.frame.size.height)];
		[_center setFrame:CGRectMake(_center.frame.origin.x + x/2, _center.frame.origin.y, _center.frame.size.width,_center.frame.size.height)];
		[_right setFrame:CGRectMake(_right.frame.origin.x + x/2, _right.frame.origin.y, _right.frame.size.width,_right.frame.size.height)];
		_left.alpha = 0.0;
		_center.alpha = 0.0;
		_right.alpha = 0.0;
		
		[UIView commitAnimations]; 
		
		_left1.text = [texts objectAtIndex:0];
		_center1.text = [texts objectAtIndex:1];
		_right1.text = [texts objectAtIndex:2];
		[_left1 setFrame:CGRectMake(_left1.frame.origin.x - x/2, _left1.frame.origin.y, _left1.frame.size.width,_left1.frame.size.height)];
		[_center1 setFrame:CGRectMake(_center1.frame.origin.x - x/2, _center1.frame.origin.y, _center1.frame.size.width,_center1.frame.size.height)];
		[_right1 setFrame:CGRectMake(_right1.frame.origin.x - x/2, _right1.frame.origin.y, _right1.frame.size.width,_right1.frame.size.height)];
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3]; 
		[_left1 setFrame:CGRectMake(0 , _left.frame.origin.y, _left.frame.size.width,_left.frame.size.height)];
		[_center1 setFrame:CGRectMake(110 , _center.frame.origin.y, _center.frame.size.width,_center.frame.size.height)];
		[_right1 setFrame:CGRectMake(220 , _right.frame.origin.y, _right.frame.size.width,_right.frame.size.height)];
		_left1.alpha = 1.0;
		_center1.alpha = 1.0;
		_right1.alpha = 1.0;
	
		
		[UIView commitAnimations];
 
		id tmp = self._left1;
		self._left1 = self._left;
		self._left = tmp;
		 
		tmp = self._center1;
		self._center1 = self._center;
		self._center = tmp ;
		
		tmp = self._right1;
		self._right1 = self._right;
		self._right = tmp ;
		
	}
	else {
		
	}
 
	
}
 

- (void)dealloc {
    [super dealloc];
}


@end
