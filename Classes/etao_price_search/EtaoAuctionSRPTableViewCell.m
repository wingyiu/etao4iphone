//
//  EtaoAuctionSRPTableViewCell1.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoAuctionSRPTableViewCell.h"
#import "ETImageCache.h" 
 
@implementation EtaoAuctionSRPTableViewCell
static UIFont *g_srp_titleFont ;
static UIColor *g_srp_titleColor ;
static UIFont *g_srp_priceFont;
static UIColor *g_srp_priceColor ;
static UIFont *g_srp_detailFont ;
static UIColor *g_srp_detailColor ;
static UIFont *g_srp_ppriceFont ; 



+ (void) initialize {
    if(self == [EtaoAuctionSRPTableViewCell class])
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
    if ([it isKindOfClass:[EtaoAuctionItem class]] )
    {
        EtaoAuctionItem *item = (EtaoAuctionItem *)it;
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        
        UIColor *backgroundColor = self.selected || self.highlighted ? [UIColor clearColor] : [UIColor whiteColor];
        
        [backgroundColor set];
        CGContextFillRect(context, rect);      
         
        [[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] set];
        [item.title drawInRect:CGRectMake(100, 5, 200, 34) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeTailTruncation];
        
        
        // price  
        NSString *price = [NSString stringWithFormat:@"%1.2f",[item.price floatValue]]; 		
        [[UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] set];
        [price drawInRect:CGRectMake(110, 48, 200, 16) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:18] lineBreakMode:UILineBreakModeTailTruncation];
        UIImage *rmb = [UIImage imageNamed:@"rmb_price.png"];
        [rmb drawInRect:CGRectMake(100, 54, rmb.size.width, rmb.size.height)]; 
        
        
        
        if(-1 != [item.postFee floatValue]) {  
            [[UIColor grayColor] set];
            NSString *text = [NSString stringWithFormat:@"运费:%.2f", [item.postFee floatValue]];
            [text drawInRect:CGRectMake(220, 49, 80, 14) withFont:[UIFont systemFontOfSize:13] lineBreakMode:UILineBreakModeTailTruncation]; 
        }
        
        if ([item.sales intValue] > 0 ) {
            [[UIColor grayColor] set];
            NSString *sales = [NSString stringWithFormat:@"售出%d笔", [item.sales intValue]];
            [sales drawInRect:CGRectMake(115, 77, 200, 14) withFont:[UIFont systemFontOfSize:13]];
            [[UIImage imageNamed:@"black_people.png"] drawInRect:CGRectMake(100,78, 13,13)]; 
        } 
        
        NSString *shop = @""; 
        if ([item.userType isEqualToString:@"0"] ) {
            shop = [NSString stringWithFormat:@"淘宝网 %@",item.userNickName];
        }
        else if ([item.userType isEqualToString:@"1"] ) {
            shop = [NSString stringWithFormat:@"淘宝商城 %@",item.userNickName];
        }
        else {
            shop = item.userNickName;
        }  
        
        [[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0] set];
        [shop drawInRect:CGRectMake(5, 98+2.5, 300, 14) withFont:[UIFont systemFontOfSize:12]];
    }
    else
    {
         
        EtaoProductItem *item = (EtaoProductItem *)it;
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIColor *backgroundColor = self.selected || self.highlighted ? [UIColor clearColor] : [UIColor whiteColor];
        
        [backgroundColor set];
        CGContextFillRect(context, rect);    
        
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
            
            [[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] set];
            [item.title drawInRect:CGRectMake(100, 10, 200, 17) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeTailTruncation];
        } 
        else
        {  
            [[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0] set];
            [item.title drawInRect:CGRectMake(100, 5, 200, 34) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeTailTruncation];
        }
        
        if (priceNumber == 2 ){
            
            NSArray *lines = [item.priceListStr componentsSeparatedByString:@";"];

            
            UIImage *rmb = [UIImage imageNamed:@"rmb_price.png"];
            [rmb drawInRect:CGRectMake(150, 34, rmb.size.width, rmb.size.height)]; 
            [rmb drawInRect:CGRectMake(150, 54, rmb.size.width, rmb.size.height)]; 
    
            
            
            NSArray *items1 = [[lines objectAtIndex:0] componentsSeparatedByString:@":"]; 
            NSString *key = [NSString stringWithFormat:@"%@:",[items1 objectAtIndex:0]];
            NSString *value = [NSString stringWithFormat:@"%1.2f",[[items1 objectAtIndex:1] floatValue]]; 
            
            
            NSArray *items2 = [[lines objectAtIndex:1] componentsSeparatedByString:@":"]; 
            
            NSString *key2 = [NSString stringWithFormat:@"%@:",[items2 objectAtIndex:0]];
            NSString *value2 = [NSString stringWithFormat:@"%1.2f",[[items2 objectAtIndex:1] floatValue]]; 
            
            
            
            [[UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] set];
            [value drawInRect:CGRectMake(160, 30, 200, 16) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:18] lineBreakMode:UILineBreakModeTailTruncation];
            
            [value2 drawInRect:CGRectMake(160, 50, 200, 16) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:18] lineBreakMode:UILineBreakModeTailTruncation]; 
            
            
            [[UIColor grayColor]set];
            [key drawInRect:CGRectMake(100, 33, 60, 16) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:13] lineBreakMode:UILineBreakModeTailTruncation]; 
            [key2 drawInRect:CGRectMake(100, 53, 60, 16) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:13] lineBreakMode:UILineBreakModeTailTruncation]; 
            
        }
        else
        {
            
            // price  
            NSString *price = [NSString stringWithFormat:@"%1.2f",[item.price floatValue]]; 		
            [[UIColor colorWithRed:226/255.0f green:43/255.0f blue:80/255.0f alpha:1.0] set];
            [price drawInRect:CGRectMake(110, 48, 200, 16) withFont:[UIFont fontWithName:@"Arial-BoldMT" size:18] lineBreakMode:UILineBreakModeTailTruncation];
            UIImage *rmb = [UIImage imageNamed:@"rmb_price.png"];
            [rmb drawInRect:CGRectMake(100, 54, rmb.size.width, rmb.size.height)]; 
        }
        [[UIColor grayColor] set]; 
        NSString *sales = [NSString stringWithFormat:@"售出%d笔", [item.lwQuantity intValue]];
        [sales drawInRect:CGRectMake(115, 77, 200, 14) withFont:[UIFont systemFontOfSize:13]];
        [[UIImage imageNamed:@"black_people.png"] drawInRect:CGRectMake(100,78, 13,13)]; 
         
        
        NSString *b2cCount = [NSString stringWithFormat:@"%d个商家", [item.sellerCount intValue]];
        [b2cCount drawInRect:CGRectMake(220, 78, 80, 14) withFont:[UIFont systemFontOfSize:12]]; 
         
        
                   
        
        NSCharacterSet *character = [NSCharacterSet characterSetWithCharactersInString:@";"];
        item.propListStr = [item.propListStr stringByTrimmingCharactersInSet:character]; 
        
        NSString* tempParamentTextStr = [item.propListStr stringByReplacingOccurrencesOfString:@";" withString:@" | "];
        
        
        [[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0] set];
        [tempParamentTextStr drawInRect:CGRectMake(5, 98+2.5, 300, 14) withFont:[UIFont systemFontOfSize:12]];
     
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
        UIImage *img = [UIImage imageNamed:@"no_picture_100x100.png"];
        [img drawInRect: CGRectMake(5, 5, 90, 90) ]; 
    }
    else
    {
        [img drawInRect: CGRectMake(5, 5, 90, 90) ]; 
    } 
    
} 
@end
