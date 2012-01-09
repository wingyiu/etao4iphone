//
//  EtaoSRP4SqureCell.m
//  etao4iphone
//
//  Created by 稳 张 on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoSRP4SqureCell.h"
#import "EtaoProductItem.h"
#import "SearchDetailController.h"
#import "EtaoAuctionItem.h"
#import "TBWebViewControll.h"

@implementation EtaoSRP4SqureCell

@synthesize httpImg = _httpImg;
@synthesize button = _button;
@synthesize label = _label;
@synthesize loadv = _loadv; 
@synthesize item;
@synthesize parent;


- (UIImage *)imageWithColor:(UIColor *)color: (CGRect) rect {
    //CGRect rect = CGRectMake(0.0f, 0.0f, 160, 120.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        if( _httpImg == nil ) {
            _httpImg = [[HTTPImageView alloc] init];
            [_httpImg setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y+10, self.bounds.size.width, 120)];
            [self addSubview:_httpImg];
        }
        
        if (_label == nil) {
            _label = [[UILabel alloc] init];
            [_label setFrame:CGRectMake(self.bounds.origin.x+10, self.bounds.size.height-40, self.bounds.size.width-20, 40)];
            [_label setNumberOfLines:2];
            [_label setFont:[UIFont systemFontOfSize:13]];
            [self addSubview:_label];
        }
        
        if (_button == nil) {
            _button = [[UIButton alloc] init];
            [_button setFrame:self.bounds];
            [_button setImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] :self.bounds] forState:UIControlStateHighlighted]; 
            [self addSubview:_button];
        }
    }
    
    item = nil;
    parent = nil;
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
//   [super setSelected:selected animated:animated];
    
	if ( selected ) { 
        
		if ( [self.item isKindOfClass:[EtaoProductItem class]] ) {
			EtaoProductItem *proItem = (EtaoProductItem*) self.item;
			NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:proItem.title,@"q",proItem.pid,@"epid",nil];
			SearchDetailController *detail = [[[SearchDetailController alloc]initWithProduct:dict]autorelease];
			[self.parent.navigationController pushViewController:detail animated:YES];
		}
		else {
		 	EtaoAuctionItem *aucItem = (EtaoAuctionItem*) self.item;
			TBWebViewControll *webv = [[[TBWebViewControll alloc] initWithURLAndType:aucItem.link title:aucItem.title type:[aucItem.userType intValue] isSupportWap:[aucItem.isLinkWapUrl boolValue]] autorelease];
            
            webv.hidesBottomBarWhenPushed = YES;
            [self.parent.navigationController pushViewController:webv animated:YES];
		} 
	}
    // Configure the view for the selected state
}


-(void) dealloc {
    
    [_httpImg release];
    [_label release];
    [_button release];
    
    [super dealloc];
}

@end
