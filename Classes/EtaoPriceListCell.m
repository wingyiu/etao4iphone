//
//  EtaoPriceListCell.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceListCell.h"
#import "EtaoPriceAuctionItem.h"

@implementation EtaoPriceListCell

static UIFont *g_srp_titleFont ;
static UIColor *g_srp_titleColor ;
static UIFont *g_srp_priceFont;
static UIColor *g_srp_priceColor ;
static UIFont *g_srp_detailFont ;
static UIColor *g_srp_detailColor ;
static UIFont *g_srp_ppriceFont ; 



+ (void) initialize {
    if(self == [EtaoPriceListCell class])
	{
        g_srp_titleFont = [UIFont fontWithName:@"ArialMT" size:15];  
        g_srp_titleColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
        g_srp_priceFont = [UIFont fontWithName:@"Arial-BoldMT" size:18];  
        g_srp_priceColor = [UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] ; 
        g_srp_detailFont = [UIFont systemFontOfSize:13];
        g_srp_detailColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
        g_srp_ppriceFont = [UIFont fontWithName:@"Arial-BoldMT" size:15];  
        
	}
    
    
}

+ (int) height {
    return 120 ;
}

- (void) drawContentView:(id)it in:(CGRect)rect {  
    [self setBackgroundColor:[UIColor whiteColor]]; 
    if ([it isKindOfClass:[EtaoPriceAuctionItem class]] )
    {
        EtaoPriceAuctionItem *item = (EtaoPriceAuctionItem *)it;
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIColor *backgroundColor = self.selected || self.highlighted ? [UIColor clearColor] : [UIColor whiteColor];
        
        [backgroundColor set];
        CGContextFillRect(context, rect);   
        //accessory
        
        //title
        [[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] set];
        NSString *title_str = [NSString stringWithFormat:@"%@",item.title];
        [title_str drawInRect:CGRectMake(100, 10, 210, 34) withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeTailTruncation];
        // price  
        NSString *price = [NSString stringWithFormat:@"%1.2f",[item.productPrice floatValue]]; 		
        [[UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] set];
        CGSize price_size = [[NSString stringWithFormat:@"%@",item.productPrice]sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
        [price drawInRect:CGRectMake(110, 52, price_size.width, 20) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:18] lineBreakMode:UILineBreakModeCharacterWrap];
        UIImage *price_rmb = [UIImage imageNamed:@"rmb_price.png"];
        [price_rmb drawInRect:CGRectMake(100, 57, price_rmb.size.width, price_rmb.size.height)]; 
        //discount
        NSString *discount = [NSString stringWithFormat:@"%1.1f%折",[item.productPrice floatValue]*10/[item.lowestPrice floatValue]];
        [[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]set];
        CGSize discount_size = [[NSString stringWithFormat:@"%@",discount]sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
        [discount drawInRect:CGRectMake(240, 54, discount_size.width, 14) withFont:[UIFont systemFontOfSize:12] lineBreakMode:UILineBreakModeCharacterWrap];
        UIImage *discount_img = [UIImage imageNamed:@"etao_discount.png"];
        [discount_img drawInRect:CGRectMake(225, 53, discount_img.size.width, discount_img.size.height)];
        //update time
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *uptime =  [NSString stringWithFormat:@"降价时间:%@", [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([item.priceMtime floatValue] )]]];
        [[UIColor colorWithRed: 102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]set];
        CGSize uptime_size = [[NSString stringWithFormat:@"%@",uptime]sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
        [uptime drawInRect:CGRectMake(100, 78, uptime_size.width, 14) withFont:[UIFont systemFontOfSize:12] lineBreakMode:UILineBreakModeCharacterWrap];
        //seller type
        NSString *sellerType;
        if ([item.sellerType isEqualToString:@"0"] ) {
            sellerType = [NSString stringWithFormat:@"淘宝网 %@",item.nickName];
        }
        else if ([item.sellerType isEqualToString:@"1"] ) {
            sellerType = [NSString stringWithFormat:@"淘宝商城 %@",item.nickName];
        }
        else {
            sellerType = item.nickName;
        }
        [[UIColor colorWithRed: 102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0]set];
        CGSize seller_type_size = [[NSString stringWithFormat:@"%@",sellerType]sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
        [sellerType drawInRect:CGRectMake(10, 98, seller_type_size.width, 14) withFont:[UIFont systemFontOfSize:13] lineBreakMode:UILineBreakModeCharacterWrap];
    
    }
    
}

- (void) drawImageView:(UIImage*)img in:(CGRect)rect{  
    NSLog(@"%s",__FUNCTION__);
    
    [self setBackgroundColor:[UIColor whiteColor]]; 
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    UIColor *backgroundColor =  [UIColor whiteColor]; 
    
    [backgroundColor set];
    CGContextFillRect(context, rect);
    
    
    if (img == nil) {
        UIImage *img = [UIImage imageNamed:@"no_picture_80x80.png"];
        [img drawInRect: CGRectMake(10, 10, 80, 80) ]; 
    }
    else
    {
        [img drawInRect: CGRectMake(10, 10, 80, 80) ]; 
        
    }  
    
    
} 

@end
