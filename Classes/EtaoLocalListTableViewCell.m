//
//  EtaoLocalListTableViewCell.m
//  etao4iphone
//
//  Created by iTeam on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoLocalListTableViewCell.h"
#import "HTTPImageView.h"
#import "UIDeleteLineLabel.h"

#import <QuartzCore/QuartzCore.h>

@implementation EtaoLocalListTableViewCell
@synthesize _idx,_item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code. 
        UIView *selectedView = [[[UIView alloc] initWithFrame:self.frame]autorelease];
        selectedView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0];
        self.selectedBackgroundView = selectedView;  
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

+ (int) height{
	return 100 ;
}

- (void) set:(EtaoLocalDiscountItem*)item{
	//self.textLabel.text = item._title;
	
	for (UIView *v in [self subviews]) {
		if ( [v isKindOfClass:[UILabel class]] ||
			 [v isKindOfClass:[UIDeleteLineLabel class]] ||
			 [v isKindOfClass:[HTTPImageView class] ] ) 
		{
			[v removeFromSuperview];
		}
		
	} 
	UIFont *titleFont = [UIFont systemFontOfSize:14];
	UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
	UIFont *priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:18]; 
	UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ;  
	
	self._item = item;
	//self.backgroundColor = [UIColor lightGrayColor];
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(130, 5, 160, 60)] autorelease];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [NSString stringWithFormat:@"%@...",item.itemTitle];
	titleLabel.font = titleFont;
	titleLabel.textColor = titleColor; 
	titleLabel.numberOfLines = 3;
	 
	CGSize sizePrice = [[NSString stringWithFormat:@"%@",item.itemOriginalPrice] sizeWithFont:priceFont];
	NSLog(@"%f",sizePrice.width);
    
    UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
    [rmbImgView setFrame:CGRectMake(130, 75, 9, 11)];
    [self addSubview:rmbImgView];

	
	UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(143, 70, sizePrice.width, 20)] autorelease];
	priceLabel.backgroundColor = [UIColor clearColor];
	priceLabel.text = item.itemPresentPrice;
	priceLabel.font = priceFont; 
	priceLabel.numberOfLines = 1 ;
	priceLabel.textColor = priceColor;
	
	UIFont *font = [UIFont systemFontOfSize:13.0];
/*	CGSize size = [[NSString stringWithFormat:@"￥%@",item.itemOriginalPrice] sizeWithFont:font];
	NSLog(@"%f",size.width);
	UIDeleteLineLabel* oripriceLabel = [[[UIDeleteLineLabel alloc ] initWithFrame:CGRectMake(130+sizePrice.width, 70, size.width, 20)] autorelease];
	oripriceLabel.backgroundColor = [UIColor clearColor];
	oripriceLabel.text = [NSString stringWithFormat:@"￥%@",item.itemOriginalPrice];
	oripriceLabel.font = [UIFont systemFontOfSize:13]; 
	oripriceLabel.numberOfLines = 1 ;
	oripriceLabel.textAlignment =   UITextAlignmentCenter ; 
	oripriceLabel.textColor = [UIColor lightGrayColor];
  */
	CGSize size1 = [[NSString stringWithFormat:@"约%@km",item.shopDistance] sizeWithFont:font];
	NSLog(@"%f",size1.width);
	
	UILabel* distanceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(220, 70, size1.width, 20)] autorelease];
	distanceLabel.backgroundColor = [UIColor clearColor];
	if (![item.shopDistance isEqualToString:@"0.00"]) {
		distanceLabel.text = [NSString stringWithFormat:@"约%@km",item.shopDistance];
	}
	
	distanceLabel.font = [UIFont systemFontOfSize:13]; 
	distanceLabel.numberOfLines = 1 ;
	distanceLabel.textColor = [UIColor lightGrayColor]; 
	
	
	HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(5, 10, 120, 80)]autorelease];
    httpImageView.contentMode = UIViewContentModeScaleToFill;
    httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
    
											
	[httpImageView setUrl:item.itemImageURL]; 
	[self addSubview: httpImageView]; 
	[self addSubview:titleLabel];
	//[self addSubview:oripriceLabel];  
	[self addSubview:priceLabel]; 
	[self addSubview:distanceLabel]; 
	
/*	
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(10, 5, 280, 30)] autorelease];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [NSString stringWithFormat:@"%@...",item.itemTitle];
	titleLabel.font = [UIFont systemFontOfSize:13];
	titleLabel.textColor = [UIColor blackColor]; 
	titleLabel.numberOfLines = 2;

	UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 45, 100, 20)] autorelease];
	priceLabel.backgroundColor = [UIColor clearColor];
	priceLabel.text = [NSString stringWithFormat:@"￥%@",item.itemPresentPrice];
	priceLabel.font = [UIFont systemFontOfSize:20]; 
	priceLabel.numberOfLines = 1 ;
	priceLabel.textColor = [UIColor redColor];

	UILabel* oripriceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 80, 100, 20)] autorelease];
	oripriceLabel.backgroundColor = [UIColor clearColor];
	oripriceLabel.text = [NSString stringWithFormat:@"￥%@",item.itemOriginalPrice];
	oripriceLabel.font = [UIFont systemFontOfSize:20]; 
	oripriceLabel.numberOfLines = 1 ;
	oripriceLabel.textColor = [UIColor redColor];
	
	UILabel* discountLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(200, 45, 100, 20)] autorelease];
	discountLabel.backgroundColor = [UIColor clearColor];
	discountLabel.text = [NSString stringWithFormat:@"折扣:%@折",item.itemDiscount];
	discountLabel.font = [UIFont systemFontOfSize:12]; 
	discountLabel.numberOfLines = 1 ;
	discountLabel.textColor = [UIColor grayColor];

	UILabel* addressLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 90, 200, 20)] autorelease];
	addressLabel.backgroundColor = [UIColor clearColor];
	addressLabel.text = [NSString stringWithFormat:@"%@",item.shopAddress];
	addressLabel.font = [UIFont systemFontOfSize:12]; 
	addressLabel.numberOfLines = 1 ;
	addressLabel.textColor = [UIColor grayColor];
	
	UILabel* shopnameLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 70, 200, 20)] autorelease];
	shopnameLabel.backgroundColor = [UIColor clearColor];
	shopnameLabel.text = [NSString stringWithFormat:@"%@",item.shopName];
	shopnameLabel.font = [UIFont systemFontOfSize:12]; 
	shopnameLabel.numberOfLines = 1 ;
	shopnameLabel.textColor = [UIColor grayColor];

	UILabel* distanceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(200, 80, 100, 20)] autorelease];
	distanceLabel.backgroundColor = [UIColor clearColor];
	distanceLabel.text = [NSString stringWithFormat:@"约:%@公里",item.shopDistance];
	distanceLabel.font = [UIFont systemFontOfSize:12]; 
	distanceLabel.numberOfLines = 1 ;
	distanceLabel.textColor = [UIColor grayColor];

	
	HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(10, 40, 100, 70)]autorelease];
	[httpImageView setUrl:item.itemImageURL];
	CALayer *layer = [httpImageView layer];
	[layer setMasksToBounds:YES];
	[layer setCornerRadius:5.0];
	[layer setBorderWidth:1.0];
	[layer setBorderColor:[[UIColor grayColor] CGColor]];	 
	[self addSubview: httpImageView]; 
	[self addSubview:titleLabel];
	[self addSubview:addressLabel];
	//[self addSubview:distanceLabel]; 
	[self addSubview:discountLabel];
	[self addSubview:priceLabel];
	[self addSubview:shopnameLabel];
 */
}


- (void)dealloc {
    [super dealloc];
}


@end
