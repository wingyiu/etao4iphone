//
//  EtaoQueryView.m
//  etao4iphone
//
//  Created by iTeam on 11-9-19.
//  Copyright 2011 taobao. All rights reserved.
//

#import "EtaoQueryView.h"
#import "NSObject+SBJson.h"
#import "NSString+QueryString.h"
#import <QuartzCore/QuartzCore.h>
@implementation EtaoQueryView

@synthesize delegate,action;




- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		self.backgroundColor = [UIColor whiteColor]; 
		CALayer *layer = [self layer];  
		[layer setBorderWidth:1.0]; 
		[layer setBorderColor:[[UIColor colorWithRed:208/255.0f green:210/255.0f blue:213/255.0f alpha:1.0]CGColor]]; 
		
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

- (void) downButtonPressed:(id)sender
{ 	
	if (self.delegate && self.action && [delegate respondsToSelector:self.action]) {
		[delegate performSelectorOnMainThread:self.action withObject:sender waitUntilDone:YES];
	}
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}


-(UIButton*) _createButtonWithFrame:(CGRect)frame Title:(NSString*)title {
	UIButton *btn = [[[UIButton alloc] initWithFrame:frame]autorelease];  
	CALayer *layer = [btn layer];  
	[layer setMasksToBounds:YES];
	[layer setCornerRadius:2.0] ; 	
	[btn setTitle:title forState:UIControlStateNormal];
	btn.titleLabel.font = [UIFont systemFontOfSize:12.0]; 
	[btn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
	[btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.8901 green:0.9098 blue:0.9490 alpha:1.0] ]forState:UIControlStateNormal];
	[btn setBackgroundImage:[self imageWithColor:[UIColor grayColor] ] forState:UIControlStateSelected];
	[btn addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	return btn;
}

- (NSArray*)_getFrames:(NSArray*)texts{ 
	UIFont *font = [UIFont systemFontOfSize:15.0];
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
	float total = 0.0f;
	for (NSString *s in texts ) {
		CGSize size = [s sizeWithFont:font];
		total += size.width+10;  
	}
 	float r = 260.0f - total ;
	for ( int i = 0 ; i < [texts count] ;i++) {
		CGSize size = [[texts objectAtIndex:i] sizeWithFont:font];
		 
		if ( r < 0 ) {
			[tmp addObject:[NSNumber numberWithFloat:size.width + 10 + r * (size.width/total) ]];
			continue;
		} 
		
		if ( i == [texts count] - 1 ) {
			[tmp addObject:[NSNumber numberWithFloat:size.width+10+r]]; 
		}
		else {
			float add = (arc4random()%100 /100.0 ) * r;
			float s = size.width + add ; 
			r = r - add ; 
			[tmp addObject:[NSNumber numberWithFloat:s+10]];
		} 		 
	}
	
	return tmp ;
}

- (NSArray*)_getFramesForTop3:(NSArray*)texts{ 
	UIFont *font = [UIFont systemFontOfSize:15.0];
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
	float total = 0.0f;
	for (NSString *s in texts ) {
		CGSize size = [s sizeWithFont:font];
		total += size.width+30;  
	}
 	float r = 260.0f - total ;
	for ( int i = 0 ; i < [texts count] ;i++) { 
		CGSize size = [[texts objectAtIndex:i] sizeWithFont:font];
		[tmp addObject:[NSNumber numberWithFloat:size.width + 30 + r * ((size.width+30)/total) ]];  
	}
	
	return tmp ;
}

- (void) setView:(NSDictionary*) info  left:(BOOL)b{
	
	NSArray *tmplines = [[info objectForKey:@"txt"] componentsSeparatedByString:@";"]; 
	
	NSMutableArray *lines = [NSMutableArray arrayWithCapacity:[tmplines count]];
	for ( NSString *s in tmplines) {
		[lines addObject:[s trimString]];
	}
	for(UIView *view in self.subviews){
		if([view isKindOfClass:[UIButton class]]){ 
			if (view.frame.origin.x < 0 || view.frame.origin.x > 300) {
				[view removeFromSuperview];
			} 
		}
	}
	 
	float xlen = -300.0f;
	if (b) {
		xlen = 300.0f;
	}
	for (int i = 0 ; i < 3; i+=3) { 
		float y =  (i / 3 + 1 )*10 + (i / 3 ) * 30 ;
		NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
		for (int j = 0 ; j < 3 && i+j < [lines count]; j++) {
			[tmp addObject:[lines objectAtIndex:i+j]];
		}
		NSArray *framex = [self _getFramesForTop3:tmp]; 
		float xsum = xlen;
		for (int k = 0 ; k < [framex count]; k++) {
			float x0 = [[framex objectAtIndex:k]floatValue];
			//UIButton * btn0 = [self _createButtonWithFrame:CGRectMake(10+xsum,y,x0,30) Title:[lines objectAtIndex:i+k]]; 
			UIImageView *number = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"EtaoHomeQueryNumber%d.png",k+1]]]autorelease];
			UIButton *btn = [[[UIButton alloc] initWithFrame:CGRectMake(10+xsum,y,x0,30)]autorelease];  
			CALayer *layer = [btn layer];  
			[layer setMasksToBounds:YES];
			[layer setCornerRadius:2.0] ; 
			[btn setTitle:[lines objectAtIndex:i+k] forState:UIControlStateNormal];
			btn.titleLabel.font = [UIFont systemFontOfSize:15.0]; 
			[btn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
			[btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.8901 green:0.9098 blue:0.9490 alpha:1.0] ]forState:UIControlStateNormal];
			[btn setBackgroundImage:[self imageWithColor:[UIColor grayColor] ] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside]; 			
			number.frame = CGRectMake(5,7.5,number.frame.size.width, number.frame.size.height);
			 
			[btn addSubview:number];
			
			[btn addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:btn];	
			btn.alpha = 0.0;
			xsum = btn.frame.origin.x +  x0 ;
		} 
	}
	 
	for (int i = 3 ; i < [lines count] && i < 12; i+=3) {
		if (i >=12 ) {
			break;
		}
		
		float y =  (i / 3 + 1 )*10 + (i / 3 ) * 30 ;
		NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
		for (int j = 0 ; j < 3 && i+j < [lines count]; j++) {
			[tmp addObject:[lines objectAtIndex:i+j]];
		}
		NSArray *framex = [self _getFrames:tmp]; 
		float xsum = xlen;
		for (int k = 0 ; k < [framex count]; k++) {
			float x0 = [[framex objectAtIndex:k]floatValue];
			UIButton * btn0 = [self _createButtonWithFrame:CGRectMake(10+xsum,y,x0,30) Title:[lines objectAtIndex:i+k]];
			[btn0 addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:btn0];	
			btn0.alpha = 0.0;
			xsum = btn0.frame.origin.x +  x0 ;
		} 
	}
	
	
	[self bringSubviewToFront: [self  viewWithTag:1002]];
	[self bringSubviewToFront: [self  viewWithTag:1001]];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; 	
	for(UIView *view in self.subviews){
		if([view isKindOfClass:[UIButton class]]){ 
			if (view.frame.origin.x - xlen > 0 ) {
				view.alpha = 1.0;
			}
			else {
				view.alpha = 0.0;
			} 
			[view setFrame:CGRectMake(view.frame.origin.x - xlen, view.frame.origin.y, view.frame.size.width,view.frame.size.height)];
		}
	}
	[UIView commitAnimations]; 

}

- (void)dealloc {
    [super dealloc];
}


@end
