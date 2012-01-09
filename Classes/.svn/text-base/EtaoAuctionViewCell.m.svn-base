//
//  EtaoAuctionViewCell.m
//  etao4iphone
//
//  Created by iTeam on 11-9-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoAuctionViewCell.h"
#import "HTTPImageView.h"

#import <QuartzCore/QuartzCore.h>

@implementation EtaoAuctionViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
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


- (void) set:(EtaoAuctionItem*)item{
	//self.textLabel.text = item._title;
	
	for (UIView *v in [self subviews]) {
		[v removeFromSuperview];
	}  
	
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 5, 200, 30)] autorelease];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [NSString stringWithFormat:@"%@",item.title];
	titleLabel.font = [UIFont systemFontOfSize:13];
	titleLabel.textColor = [UIColor blackColor]; 
	titleLabel.numberOfLines = 2;
	
	UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 45, 100, 20)] autorelease];
	priceLabel.backgroundColor = [UIColor clearColor];
	priceLabel.text = [NSString stringWithFormat:@"￥%@",item.price];
	priceLabel.font = [UIFont systemFontOfSize:20]; 
	priceLabel.numberOfLines = 1 ;
	priceLabel.textColor = [UIColor redColor];
	
	
	
	HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(10, 5, 90, 90)]autorelease];
	httpImageView.contentMode = UIViewContentModeScaleAspectFit;
	NSString *picturl = [NSString stringWithFormat:@"%@_80x80.jpg",item.pic];
	[httpImageView setUrl:picturl];
	NSLog(@"%@",picturl);
	CALayer *layer = [httpImageView layer];
	[layer setMasksToBounds:YES];
	[layer setCornerRadius:5.0];
	[layer setBorderWidth:1.0];
	[layer setBorderColor:[[UIColor grayColor] CGColor]];	 
	[self addSubview: httpImageView]; 
	[self addSubview:titleLabel];  
	[self addSubview:priceLabel];  
	
}


- (void)dealloc {
    [super dealloc];
}


@end
