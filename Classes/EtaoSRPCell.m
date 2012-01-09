//
//  EtaoSRPCell.m
//  etao4iphone
//
//  Created by iTeam on 11-9-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRPCell.h"
#import "EtaoAuctionItem.h"
#import "EtaoProductItem.h"
#import "HTTPImageView.h"
#import "TBWebViewControll.h"
#import "EtaoAlertWhenInternetNotSupportWap.h"
#import "TBMemoryCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation EtaoSRPCell

@synthesize _parent, _item ,_idx,_moved;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
        UIView *selectedView = [[[UIView alloc] initWithFrame:self.frame]autorelease];
        selectedView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0];
        self.selectedBackgroundView = selectedView;  
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
	if ( selected ) { 

		
		if ( [_item isKindOfClass:[EtaoProductItem class]] ) {
			EtaoProductItem *item = (EtaoProductItem*) _item;
			NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:item.title,@"q",item.pid,@"epid",nil];
			SearchDetailController *detail = [[[SearchDetailController alloc]initWithProduct:dict]autorelease];
			[_parent.navigationController pushViewController:detail animated:YES];
		}
		else {
		 	EtaoAuctionItem *item = (EtaoAuctionItem*) _item;
			
            TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:item.link title:item.title type:[item.userType intValue] isSupportWap:[item.isLinkWapUrl boolValue]] autorelease];
            
            webv.hidesBottomBarWhenPushed = YES;
            [_parent.navigationController pushViewController:webv animated:YES];
		} 
	}
    // Configure the view for the selected state
}

+ (int) height{
	return 120 ;
}

/*
- (void)layoutSubviews { 
	
    [super layoutSubviews];
	if ( self.editing ) { 
		if ( !self._moved ) {  	
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.3];
		for (UIView *view in [self subviews]) {
			if ([ view isKindOfClass:[UILabel class]] ||
				[ view isKindOfClass:[HTTPImageView class]]) { 
				[view setFrame:CGRectMake(view.frame.origin.x+30, view.frame.origin.y, view.frame.size.width,view.frame.size.height)];
			}  
		}
			
		[UIView commitAnimations];  
		self._moved = YES;
		}
	}   
	else {
		if (self._moved ) { 
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.3];
			for (UIView *view in [self subviews]) {
				if ([ view isKindOfClass:[UILabel class]] ||
					[ view isKindOfClass:[HTTPImageView class]]) { 
					[view setFrame:CGRectMake(view.frame.origin.x-30, view.frame.origin.y, view.frame.size.width,view.frame.size.height)];
				}  
			}
			
			[UIView commitAnimations]; 
			self._moved = NO;
		}
	}

}
*/

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
	[super setEditing:editing animated:animated]; 

}

- (void) set:(ETaoModel*)it{
	NSLog(@"%s", __FUNCTION__); 
	//self.textLabel.text = item._title;
	 
	for (UIView *v in [self subviews]) {
		if ([ v isKindOfClass:[UILabel class]] ||
            [v isKindOfClass:[UIImageView class]] ||
			[ v isKindOfClass:[HTTPImageView class]]) {
			[v removeFromSuperview];
		} 
	}  
	
    [it retain];
	[_item release];
	_item = it ; 
	 
	UIFont *titleFont = [UIFont fontWithName:@"ArialMT" size:15]; //[UIFont systemFontOfSize:15];
	UIColor *titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
	UIFont *priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:18]; //[UIFont systemFontOfSize:15]; 
	UIColor *priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ; 
	UIFont *detailFont = [UIFont systemFontOfSize:13];
	UIColor *detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
	UIFont *ppriceFont = [UIFont fontWithName:@"Arial-BoldMT" size:15]; //[UIFont systemFontOfSize:15];  
	
	if ([it isKindOfClass:[EtaoAuctionItem class]]) {

        UIImageView *imagev = nil; 
        
        EtaoAuctionItem *item = (EtaoAuctionItem*)it;
		
		if ([item.isLinkWapUrl boolValue] == YES) {
            imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportWap.png"]];
        } else {
            imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportWww.png"]];
        }

        self.accessoryView = imagev;
        [imagev release];
        
		UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 5, 200, 34)] autorelease];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.text = [NSString stringWithFormat:@"%@",item.title];
        titleLabel.lineBreakMode = UILineBreakModeWordWrap|UILineBreakModeTailTruncation;
		titleLabel.font = titleFont;
		titleLabel.textColor = titleColor;
		titleLabel.textAlignment = UITextAlignmentLeft;
		titleLabel.numberOfLines = 2;
        //首行顶对齐
        CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
		[titleLabel setFrame:CGRectMake(100, 5, textRect.size.width, textRect.size.height)];
        
		NSString *price = [NSString stringWithFormat:@"%1.2f",[item.price floatValue]]; 		
		
        UIImageView *rmbView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
        [rmbView setFrame:CGRectMake(100, 57, rmbView.frame.size.width, rmbView.frame.size.height)];
        [self addSubview:rmbView];
        
		UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(110, 55, 200, 16)] autorelease];
		priceLabel.backgroundColor = [UIColor clearColor];
		priceLabel.text = [NSString stringWithFormat:@"%@",price];
		priceLabel.font = priceFont;
		priceLabel.numberOfLines = 1 ;
		priceLabel.textColor = priceColor; 
        
        if(-1 != [item.postFee floatValue]) {
            UILabel* postFeeLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(220, 55, 80, 14)] autorelease];
            postFeeLabel.backgroundColor = [UIColor clearColor];
            
            postFeeLabel.text = [NSString stringWithFormat:@"运费:%.2f", [item.postFee floatValue]];
            postFeeLabel.font = [UIFont systemFontOfSize:13];
            postFeeLabel.textColor = [UIColor grayColor];
            postFeeLabel.textAlignment = UITextAlignmentLeft;
            postFeeLabel.numberOfLines = 1 ;
            [self addSubview:postFeeLabel];
        }
        
        UIImageView *people = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black_people.png"]]autorelease];
        people.frame = CGRectMake(100,78, 13,13);
        
        UILabel* salesLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 78, 200, 14)] autorelease];
        salesLabel.backgroundColor = [UIColor clearColor]; 
        salesLabel.text = [NSString stringWithFormat:@"售出%d笔", [item.sales intValue]];
        salesLabel.font = [UIFont systemFontOfSize:13];
        salesLabel.textColor = [UIColor grayColor];
        salesLabel.textAlignment = UITextAlignmentLeft;
        salesLabel.numberOfLines = 1 ;
        if ([item.sales intValue] > 0 ) {
            [self addSubview:salesLabel]; 
        //    [self addSubview:people];
        } 

		
		UILabel* DetailLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(5, 98+2.5, 300, 14)] autorelease];
		DetailLabel.backgroundColor = [UIColor clearColor];
	
		if ([item.userType isEqualToString:@"0"] ) {
			DetailLabel.text = [NSString stringWithFormat:@"淘宝网 %@",item.userNickName];
		}
		else if ([item.userType isEqualToString:@"1"] ) {
			DetailLabel.text = [NSString stringWithFormat:@"淘宝商城 %@",item.userNickName];
		}
		else {
			DetailLabel.text = item.userNickName;
		} 
		DetailLabel.font = [UIFont systemFontOfSize:12]; 
		DetailLabel.numberOfLines = 1 ;
		DetailLabel.textColor = detailColor;
		
        if ( [ item.pic  isEqualToString:@""]  ) { 
            UIImageView *img = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no_picture_80x80.png"]]autorelease];
            img.frame = CGRectMake(5, 5, 90, 90 );
            [self addSubview:img];
        } 
        else
        {
            HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(5, 5, 90, 90)]autorelease];
            httpImageView.contentMode = UIViewContentModeScaleAspectFit;
            httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
		
            NSString *picturl = [NSString stringWithFormat:@"%@_120x120.jpg",item.pic];
            [httpImageView setUrl:picturl];
            NSLog(@"%@",picturl);
            CALayer *layer = [httpImageView layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:0.0];
            [layer setBorderWidth:0.0];
            [layer setBorderColor:[[UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0]  CGColor]];	 
            [self addSubview: httpImageView];  
        }
		[self addSubview:titleLabel];  
		[self addSubview:DetailLabel];
		[self addSubview:priceLabel];
        		
	}else{
		EtaoProductItem *item = (EtaoProductItem*)it;
		 
        self.accessoryView = nil; 
		
        int priceNumber = 0 ;
        if (item.priceListStr != nil && ![item.priceListStr isEqualToString:@""]) { 
			NSArray *lines = [item.priceListStr componentsSeparatedByString:@";"]; 
			for (NSString *line in lines) {
				NSArray *items = [line componentsSeparatedByString:@":"];
				if ([items count] == 2 ) { 
                    priceNumber += 1 ;
                }
			}
        }
        UILabel* titleLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 5, 200, 34)] autorelease];
        titleLabel.numberOfLines = 2;
        if (priceNumber == 2 ) { 
            titleLabel.frame = CGRectMake(100, 10, 200, 17);
            titleLabel.numberOfLines = 1;
        }
        //		CGSize t = {200,20}; 
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [NSString stringWithFormat:@"%@",item.title];
        titleLabel.font = titleFont;
        titleLabel.textColor = titleColor;
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.lineBreakMode = UILineBreakModeWordWrap|UILineBreakModeTailTruncation;         
         
		
        //首行顶对齐
        CGRect textRect = [titleLabel textRectForBounds:titleLabel.frame limitedToNumberOfLines:titleLabel.numberOfLines];
		[titleLabel setFrame:CGRectMake(100, 5, textRect.size.width, textRect.size.height)];

        
        int minus = 0 ; 
        if (priceNumber == 2 ) {
            minus = 20 ;
        }
        
		if (item.priceListStr != nil && ![item.priceListStr isEqualToString:@""]) {
			NSLog(@"%@",item.priceListStr);
			NSArray *lines = [item.priceListStr componentsSeparatedByString:@";"]; 
			int idx = 0 ;
			float maxx = 0.0f; 
			for (NSString *line in lines) {
				NSArray *items = [line componentsSeparatedByString:@":"];
				if ([items count] == 2 ) {
					NSString *key = [NSString stringWithFormat:@"%@:",[items objectAtIndex:0]];  
					CGSize keysize = [key sizeWithFont:[UIFont systemFontOfSize:13]];  
					if (maxx < keysize.width) {
						maxx = keysize.width;
					} 
				}
			}
			maxx += 2;
			for (NSString *line in lines) { 
				NSArray *items = [line componentsSeparatedByString:@":"];
				if ([items count] == 2 ) {
                    NSString *key = [NSString stringWithFormat:@"%@:",[items objectAtIndex:0]];
					NSString *value = [NSString stringWithFormat:@"%1.2f",[[items objectAtIndex:1] floatValue]]; 
					 
					CGSize valuesize = [value sizeWithFont:ppriceFont]; 
					UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, textRect.size.height + 18 + idx *18, maxx, 18)] autorelease];
					priceLabel.backgroundColor = [UIColor clearColor];
					priceLabel.text = key;
					priceLabel.font = [UIFont systemFontOfSize:13]; 
					priceLabel.numberOfLines = 1 ;
					priceLabel.textColor = titleColor;
					[self addSubview:priceLabel];
					
					UILabel* priceLabel2 = [[[UILabel alloc ] initWithFrame:CGRectMake(110+maxx, textRect.size.height + 18 + idx *18, valuesize.width+10, 18)] autorelease];
					priceLabel2.backgroundColor = [UIColor clearColor];
					priceLabel2.text = value;
					priceLabel2.font = ppriceFont; 
					priceLabel2.numberOfLines = 1 ;
					priceLabel2.textColor = priceColor; 
					[self addSubview:priceLabel2];
                    
                    UIImageView *rmbView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
                    [rmbView setFrame:CGRectMake(100+maxx, textRect.size.height + 20 +idx *18, rmbView.frame.size.width, rmbView.frame.size.height)];
                    [self addSubview:rmbView];
					
					idx += 1 ;
				}
			}
            
            UILabel* postFeeLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(220, 78, 80, 14)] autorelease];
            postFeeLabel.backgroundColor = [UIColor clearColor];
            
            postFeeLabel.text = [NSString stringWithFormat:@"%d个商家", [item.sellerCount intValue]];
            postFeeLabel.font = [UIFont systemFontOfSize:12];
            postFeeLabel.textColor = [UIColor grayColor];
            postFeeLabel.textAlignment = UITextAlignmentLeft;
            postFeeLabel.numberOfLines = 1 ;
            [self addSubview:postFeeLabel];
		}
		else {
			UIImageView *rmbView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rmb_price.png"]] autorelease];
            [rmbView setFrame:CGRectMake(100, 53, rmbView.frame.size.width, rmbView.frame.size.height)];
            [self addSubview:rmbView];
            
            NSString *price = [NSString stringWithFormat:@"%1.2f",[item.price floatValue]]; 
			UILabel* priceLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(110, 51, 200, 16)] autorelease];
			priceLabel.backgroundColor = [UIColor clearColor];
			priceLabel.text = [NSString stringWithFormat:@"%@",price];
			priceLabel.font = priceFont;
			priceLabel.numberOfLines = 1 ;
			priceLabel.textColor = priceColor;
            
			[self addSubview:priceLabel];
            
            UILabel* postFeeLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(220, 78, 80, 14)] autorelease];
            postFeeLabel.backgroundColor = [UIColor clearColor];
            
            postFeeLabel.text = [NSString stringWithFormat:@"%d个商家", [item.sellerCount intValue]];
            postFeeLabel.font = [UIFont systemFontOfSize:12];
            postFeeLabel.textColor = [UIColor grayColor];
            postFeeLabel.textAlignment = UITextAlignmentLeft;
            postFeeLabel.numberOfLines = 1 ;
            [self addSubview:postFeeLabel];
		} 		
        
        UIImageView *people = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black_people.png"]]autorelease];
        people.frame = CGRectMake(100,78, 13,13);
        
        UILabel* salesLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(100, 78, 200, 14)] autorelease];
        salesLabel.backgroundColor = [UIColor clearColor];
        
        salesLabel.text = [NSString stringWithFormat:@"售出%d笔", [item.lwQuantity intValue]];
        salesLabel.font = [UIFont systemFontOfSize:13];
        salesLabel.textColor = [UIColor grayColor];
        salesLabel.textAlignment = UITextAlignmentLeft;
        salesLabel.numberOfLines = 1 ;
        if ([item.lwQuantity intValue] > 0 ) {
            [self addSubview:salesLabel];
        //    [self addSubview:people];
        } 
        
        UILabel* DetailLabel = [[[UILabel alloc ] initWithFrame:CGRectMake(5, 98 + 2.5, 300, 14)] autorelease];
        DetailLabel.backgroundColor = [UIColor clearColor];
        
        NSCharacterSet *character = [NSCharacterSet characterSetWithCharactersInString:@";"];
        item.propListStr = [item.propListStr stringByTrimmingCharactersInSet:character]; 
        
        NSString* tempParamentTextStr = [item.propListStr stringByReplacingOccurrencesOfString:@";" withString:@" | "];
        
        DetailLabel.text = [NSString stringWithFormat:@"%@",tempParamentTextStr];
        DetailLabel.font = detailFont;
        DetailLabel.numberOfLines = 1 ;
        DetailLabel.textColor = detailColor;
        
        [self addSubview:DetailLabel];
		
        if ( [ item.pictUrl  isEqualToString:@""]  ) {
            
            UIImageView *img = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no_picture_80x80.png"]]autorelease];
            img.frame = CGRectMake(5, 5, 90, 90 );
            [self addSubview:img];
        } 
        else
        {  
            HTTPImageView *httpImageView = [[[HTTPImageView alloc] initWithFrame: CGRectMake(5, 5, 90, 90)]autorelease];
            TBMemoryCache *memoryCache = [TBMemoryCache sharedCache];
            httpImageView.memoryCache = memoryCache ;
	
            httpImageView.contentMode = UIViewContentModeScaleAspectFit;
            httpImageView.placeHolder = [UIImage imageNamed:@"no_picture_80x80.png"];
            NSString *picturl = [NSString stringWithFormat:@"%@_120x120.jpg",item.pictUrl];
            [httpImageView setUrl:picturl];
            NSLog(@"%@",picturl);
            CALayer *layer = [httpImageView layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:0.0];
            [layer setBorderWidth:0.0];
            [layer setBorderColor:[[UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0]  CGColor]]; 
            [self addSubview: httpImageView]; 
        }
		  
		[self addSubview:titleLabel]; 
	}
    
//    UIImageView *rmbView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]] autorelease];
//    [rmbView setFrame:CGRectMake(0, 120-2, self.frame.size.width, 2)];
//    [self addSubview:rmbView];
}


- (void)dealloc {
    [_item release];
    [super dealloc];
}


@end
