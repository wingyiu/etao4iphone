//
//  EtaoGroupBuyCell.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoGroupBuyListCell.h"
#import "EtaoTuanAuctionItem.h"

@implementation EtaoGroupBuyListCell

static UIFont *g_srp_titleFont ;
static UIColor *g_srp_titleColor ;
static UIFont *g_srp_priceFont;
static UIColor *g_srp_priceColor ;
static UIFont *g_srp_detailFont ;
static UIColor *g_srp_detailColor ;
static UIFont *g_srp_ppriceFont ; 



+ (void) initialize {
    if(self == [EtaoGroupBuyListCell class])
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
    return 106 ;
}

- (void) drawContentView:(id)it in:(CGRect)rect {  
    [self setBackgroundColor:[UIColor whiteColor]]; 
    if ([it isKindOfClass:[EtaoTuanAuctionItem class]] )
    {
        EtaoTuanAuctionItem *item = (EtaoTuanAuctionItem *)it;
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIColor *backgroundColor = self.selected || self.highlighted ? [UIColor clearColor] : [UIColor whiteColor];
        
        [backgroundColor set];
        CGContextFillRect(context, rect);      
        //title 
        [[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] set];
        NSString *title_str = [NSString stringWithFormat:@"[%@]%@",item.webName, [item titleStr]];
        [title_str drawInRect:CGRectMake(120, 13, 180, 34) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeTailTruncation];
        // price  
        NSString *price = [NSString stringWithFormat:@"%1.2f",[item.price floatValue]]; 		
        [[UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] set];
        CGSize price_size = [[NSString stringWithFormat:@"%@",item.price]sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:21]];
        [price drawInRect:CGRectMake(133, 50, price_size.width, 20) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:18] lineBreakMode:UILineBreakModeCharacterWrap];
        UIImage *price_rmb = [UIImage imageNamed:@"rmb_price.png"];
        [price_rmb drawInRect:CGRectMake(120, 56, price_rmb.size.width, price_rmb.size.height)]; 
        //sales
        UIImage *sales_img = [UIImage imageNamed:@"black_people.png"];
        [sales_img drawInRect:CGRectMake(120, 79, sales_img.size.width, sales_img.size.height)];
        NSString *sales = [NSString stringWithFormat:@"%d", [item.sales intValue]];
        CGSize sales_size = [sales sizeWithFont:[UIFont systemFontOfSize:15]];
        [sales drawInRect:CGRectMake(138, 77, sales_size.width, 14) withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeCharacterWrap];
        //distance
        UIImage *distance_img = [UIImage imageNamed:@"groupBuyDistance.png"];
        [distance_img drawInRect:CGRectMake(200, 79, distance_img.size.width, distance_img.size.height)];
        NSString *distance_str;
        if(nil == item.extInfo || [item.extInfo isEqualToString:@""] || [item.hasLbs isEqualToString:@"0"]) { 
            distance_str =  [NSString stringWithFormat:@"%@", @"未知"]; 
        }
        else {
            if ([item.extInfo doubleValue] > 1) {
                distance_str = [NSString stringWithFormat:@"%1.2fkm",[item.extInfo floatValue] ];
                
            }else { 
                distance_str = [NSString stringWithFormat:@"%gm",[item.extInfo floatValue]*1000];
            }
        }
        CGSize distance_size = [distance_str sizeWithFont:[UIFont systemFontOfSize:15]];
        [distance_str drawInRect:CGRectMake(218, 77, distance_size.width, 14) withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeCharacterWrap];
    }
        
}

- (void) drawImageView:(UIImage*)img in:(CGRect)rect{  
    
    [self setBackgroundColor:[UIColor whiteColor]]; 
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    UIColor *backgroundColor =  [UIColor whiteColor]; 
    
    [backgroundColor set];
    CGContextFillRect(context, rect);
    
    
    if (img == nil) {
        UIImage *img = [UIImage imageNamed:@"no_picture_100x100.png"];
        [img drawInRect: CGRectMake(2, 10, 110, 80) ]; 
    }
    else
    {
        [img drawInRect: CGRectMake(2, 10, 110, 80) ]; 
        
    }  
    
    
} 

@end
