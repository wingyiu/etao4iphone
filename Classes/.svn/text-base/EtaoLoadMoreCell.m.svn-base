//
//  EtaoLoadMoreCell.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLoadMoreCell.h"
#import "HTTPImageView.h"

@implementation EtaoLoadMoreCell
@synthesize _parent;
@synthesize delegate,action;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		for (UIView *v in [self subviews]) {
			if ([ v isKindOfClass:[UILabel class]] ||
				[ v isKindOfClass:[HTTPImageView class]] ||
				[ v isKindOfClass:[UIActivityIndicatorView class]]) {
				[v removeFromSuperview];
			} 
		} 
		
        // Initialization code.
		UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(self.frame.size.width/2 - 40,30,100, 20)] autorelease];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.text = @"正在加载...";
		titleLabel.font = [UIFont systemFontOfSize:15];
		titleLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
		titleLabel.textAlignment =  UITextAlignmentCenter; 
		
		UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
		activityIndicator.frame = CGRectMake(self.frame.size.width/2 - 50 ,30  , 20.0f, 20.0f);
		activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		[activityIndicator startAnimating]; 
		self.selectionStyle = UITableViewCellSelectionStyleNone ;
		self.accessoryView = nil;
		self.accessoryType = UITableViewCellAccessoryNone;
		[self addSubview:titleLabel];
		[self addSubview:activityIndicator];
    }
    return self;
}

- (void) setReload{
	
	for (UIView *v in [self subviews]) {
		if ([ v isKindOfClass:[UILabel class]] ||
			[ v isKindOfClass:[HTTPImageView class]] ||
			[ v isKindOfClass:[UIActivityIndicatorView class]]) {
			[v removeFromSuperview];
		} 
	} 
	
	// Initialization code.  
	
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(self.frame.size.width/2 - 50,30,100, 20)] autorelease];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = @"点击重新加载";
	titleLabel.font = [UIFont systemFontOfSize:15];
	titleLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
	titleLabel.textAlignment =  UITextAlignmentCenter; 
	
	[self addSubview:titleLabel];
	
//	self.selectionStyle =  UITableViewCellAccessoryDisclosureIndicator;
	self.accessoryView = nil;
 	self.accessoryType = UITableViewCellAccessoryNone;
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    if ( selected ) { 
		if (self.delegate && self.action && [delegate respondsToSelector:self.action]) {
			[delegate performSelectorOnMainThread:self.action withObject:self waitUntilDone:YES];
		}
	 	for (UIView *v in [self subviews]) {
			if ([ v isKindOfClass:[UILabel class]] ||
				[ v isKindOfClass:[HTTPImageView class]] ||
				[ v isKindOfClass:[UIActivityIndicatorView class]]) {
				[v removeFromSuperview];
			} 
		} 
		
        // Initialization code.
		UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(self.frame.size.width/2 - 40,30,100, 20)] autorelease];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.text = @"正在加载...";
		titleLabel.font = [UIFont systemFontOfSize:15];
		titleLabel.textColor =  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
		titleLabel.textAlignment =  UITextAlignmentCenter; 
		
		UIActivityIndicatorView *activityIndicator =  [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
		activityIndicator.frame = CGRectMake(self.frame.size.width/2 - 50 ,30  , 20.0f, 20.0f);
		activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		[activityIndicator startAnimating]; 
		self.selectionStyle = UITableViewCellSelectionStyleNone ;
		self.accessoryView = nil;
		self.accessoryType = UITableViewCellAccessoryNone;
		[self addSubview:titleLabel];
		[self addSubview:activityIndicator];  
		
	} 
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
