//
//  TuanCalloutMapAnnotationView.m
//  netaogo
//
//  Created by iTeam on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TuanCalloutMapAnnotationView.h"
#import "HTTPImageView.h"

@implementation TuanCalloutMapAnnotationView

@synthesize btn;

- (id) initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) { 
		UIButton *accessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		accessory.frame = CGRectMake(290,35,20,20);
		accessory.exclusiveTouch = YES;
		accessory.enabled = YES;
		//accessory.backgroundColor = [UIColor colorWithRed:0.2784 green:0.678 blue:0.0 alpha:1.0]; 
		[accessory addTarget: self   action: @selector(click)  forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchCancel];
		[self addSubview:accessory];
		
	}
	return self;
}


- (void) click
{ 
	if ([self.mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
		[self.mapView.delegate mapView:self.mapView 
						annotationView:self.parentAnnotationView 
		 calloutAccessoryControlTapped:self.btn];
	}
}

- (void) setImage:(NSString*)imgurl 
			Title:(NSString*)title  
		 Discount:(NSString*)discount
			Price:(NSString*)price
			 Shop:(NSString*)shopName
		  shopAdd:(NSString*)shopAddress
{
	 
	HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)] autorelease];
	[httpImageView setUrl:imgurl];
	
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(85, 5, 200, 30)] autorelease];
	titleLabel.text = title;
	//设置字体
	UIFont* uifont = [UIFont fontWithName:@"Times New Roman" size: 13];
	[titleLabel setFont:uifont];
	titleLabel.textColor = [UIColor blackColor];
	titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	titleLabel.numberOfLines = 2;
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.alpha = 1.0;
	titleLabel.textAlignment = UITextAlignmentLeft;
	
	UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(85, 38, 200, 20)] autorelease];
	priceLabel.text =  [NSString stringWithFormat:@"价格：￥%@（%@折）", price,discount];
	UIFont* uifontp = [UIFont fontWithName:@"Times New Roman" size: 13];
	
	[priceLabel setFont:uifontp];
	priceLabel.textColor = [UIColor redColor];
	priceLabel.backgroundColor = [UIColor clearColor];
	priceLabel.alpha = 1.0;
	priceLabel.textAlignment = UITextAlignmentLeft;
	
	UILabel* shopLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(85, 60, 200, 20)] autorelease];
	shopLabel.text =  [NSString stringWithFormat:@"店铺：%@", shopName];
	UIFont* uifonts = [UIFont fontWithName:@"Times New Roman" size: 13];
	[shopLabel setFont:uifonts];
	shopLabel.textColor = [UIColor blackColor];
	shopLabel.backgroundColor = [UIColor clearColor];
	shopLabel.alpha = 1.0;
	shopLabel.textAlignment = UITextAlignmentLeft;
	
	
	self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.btn.frame = CGRectMake(0,0,300,80);
	self.btn.backgroundColor = [UIColor clearColor];
	self.btn.alpha = 1.0;
	self.btn.exclusiveTouch = YES;
	
	self.btn.enabled = YES;
	[self.btn addTarget: self   action: @selector(click)  forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchCancel];
	
	[self.btn addSubview:httpImageView];
	[self.btn addSubview:titleLabel];
	[self.btn addSubview:priceLabel];
	[self.btn addSubview:shopLabel];
	
	[self.contentView addSubview:btn];
	
	 
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
