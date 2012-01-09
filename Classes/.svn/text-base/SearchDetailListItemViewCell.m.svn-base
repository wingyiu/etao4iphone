//
//  SearchDetailProductListItem.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchDetailListItemViewCell.h"
#import "HTTPImageView.h"
//#import <QuartzCore/QuartzCore.h>

@implementation SearchDetailListItemViewCell

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
	return 70 ;
}


- (void) set:(EtaoAuctionItem*)item{
	//self.textLabel.text = item._title;
	
	for (UIView *v in [self subviews]) {
		[v removeFromSuperview];
	}  
	
    
    UIImageView *imagev = nil; 

    if ([item.isLinkWapUrl boolValue] == YES) {
        imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportWap.png"]];
    } else {
        imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportWww.png"]];
    }

    self.accessoryView = imagev;
    [imagev release];
    
	UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 10, 160, 25)] autorelease];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [NSString stringWithFormat:@"%@",item.price];
	titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
	titleLabel.textColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0]; 
    titleLabel.textAlignment = UITextAlignmentRight;
	titleLabel.numberOfLines = 1;
    
    CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
	
    UIImageView* rmbImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
    [rmbImgView setFrame:CGRectMake(120+160-textRect.size.width-12, 10+9, 9, 11)];
    [self addSubview:rmbImgView];
	
	UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(120, 35, 160, 25)] autorelease];
	priceLabel.backgroundColor = [UIColor clearColor];
    
  	priceLabel.text = [NSString stringWithFormat:@"运费:%.2f", [item.postFee floatValue]];
	priceLabel.font = [UIFont systemFontOfSize:14];
	priceLabel.textColor = [UIColor grayColor];
    priceLabel.textAlignment = UITextAlignmentRight;
	priceLabel.numberOfLines = 1 ;
	
    if ( [item.userType intValue] == 0 ) {
        UIImageView* imageUsetTypeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DetailTaobaoLogo.png"]]; 
        [imageUsetTypeView setFrame:CGRectMake(10, 5, 100, 30)];
        [self addSubview:imageUsetTypeView]; 
        [imageUsetTypeView release];
        
        UILabel* businessLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(10, 40, 160, 18)] autorelease];
        businessLabel.backgroundColor = [UIColor clearColor];
        
        businessLabel.text = [NSString stringWithFormat:@"%@",item.userNickName];
        businessLabel.font = [UIFont systemFontOfSize:14];
        businessLabel.textColor = [UIColor grayColor];
        businessLabel.textAlignment = UITextAlignmentLeft;
        businessLabel.numberOfLines = 1 ;
        
        [self addSubview:businessLabel];  
    }
    else if( [item.userType intValue] == 1 ) {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DetailTmallLogo.png"]]; 
        [imageView setFrame:CGRectMake(10, 5, 100, 30)];
        [self addSubview: imageView]; 
        [imageView release];
        
        UILabel* businessLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(10, 40, 160, 18)] autorelease];
        businessLabel.backgroundColor = [UIColor clearColor];
        
        businessLabel.text = [NSString stringWithFormat:@"%@",item.userNickName];
        businessLabel.font = [UIFont systemFontOfSize:14];
        businessLabel.textColor = [UIColor grayColor];
        businessLabel.textAlignment = UITextAlignmentLeft;
        businessLabel.numberOfLines = 1 ;
        
        [self addSubview:businessLabel];  
    }
    else {
        HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(10, 10, 100, 50)]autorelease];
        httpImageView.contentMode = UIViewContentModeScaleAspectFit;
        httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
        
        NSString *picturl = [NSString stringWithFormat:@"http://img2012.i02.wimg.taobao.com/bao/uploaded/%@", item.logo];
        [httpImageView setUrl:picturl];
        NSLog(@"%@",picturl);
//        CALayer *layer = [httpImageView layer];
//        [layer setMasksToBounds:YES];
//        [layer setCornerRadius:5.0];
//        [layer setBorderWidth:1.0];
//        [layer setBorderColor:[[UIColor grayColor] CGColor]];	 
        [self addSubview: httpImageView]; 
    }
	
    //运费目前不能确定，异常时，不显示
    int postPrice = [item.postFee intValue];
    if ( postPrice<=0 || postPrice>99999) {
     //运费不显示
        [priceLabel setText:@"  "];
        [titleLabel setFrame:CGRectMake(120, 10, 160, 50)];
        [rmbImgView setFrame:CGRectMake(120+160-textRect.size.width-12, 21+8, 9, 11)];
    }
    
	[self addSubview:titleLabel];  
	[self addSubview:priceLabel];  
	
}


- (void)dealloc {
    [super dealloc];
}


@end

