//
//  EtaoLocalListHeadDistanceView.m
//  etao4iphone
//
//  Created by iTeam on 11-8-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalListHeadDistanceView.h"


@implementation EtaoLocalListHeadDistanceView

@synthesize _textLabel ;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		//self.backgroundColor = [UIColor blackColor];
		self.alpha = 1.0;
        // Initialization code.  
//		UIImageView *bg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_pageslide.png"]]autorelease];
//		[self addSubview:bg];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_pageslide.png"]];
		self._textLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(10, 5, 320, 20)] autorelease];
		self._textLabel.backgroundColor = [UIColor clearColor];	
		self._textLabel.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
		self._textLabel.font = [UIFont systemFontOfSize:13];
		[self addSubview:self._textLabel]; 
    }
    return self;
}

- (void) setText:(NSString*)str{
	self._textLabel.text = str;
}

- (void) setTextForSRP:(NSString*)key Total:(int)t Now:(int)n{
///	UIFont *font = [UIFont systemFontOfSize:14];
//	CGSize size = [key sizeWithFont:font];
	if ( [key length] > 8) {
		self._textLabel.text = [NSString stringWithFormat:@"\"%@...\" 找到第%d条结果(共%d条)",[key substringToIndex:8],n,t];
	}
	else {
		self._textLabel.text = [NSString stringWithFormat:@"\"%@\"找到第%d条结果(共%d条)",key,n,t];
	
	} 
}

- (void) setTextForLocal:(NSString*)distance Total:(int)t Now:(int)n{ 
	if ([ distance isEqualToString:@"0.00"]) {
		self._textLabel.text = [NSString stringWithFormat:@"附近第%d个团购(共%d个)",n,t];
	}
	else {
		self._textLabel.text = [NSString stringWithFormat:@"%@公里以内第%d个团购(共%d个)",distance,n,t];
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
