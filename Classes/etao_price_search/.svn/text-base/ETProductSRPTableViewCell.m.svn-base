//
//  ETProductSRPTableViewCell.m
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETProductSRPTableViewCell.h"

@implementation ETProductSRPTableViewCell


- (void) drawContentView:(id)it in:(CGRect)rect {  
    [self setBackgroundColor:[UIColor whiteColor]]; 
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
       
    
    int minus = 0 ; 
    if (priceNumber == 2 ) {
        minus = 20 ;
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
 
    [[UIColor grayColor] set];
    NSString *postFeeLabel = [NSString stringWithFormat:@"运费:%.2f", [item.sellerCount intValue]];
    [postFeeLabel drawInRect:CGRectMake(220, 49, 80, 14) withFont:[UIFont systemFontOfSize:13] lineBreakMode:UILineBreakModeTailTruncation];            
    
    NSCharacterSet *character = [NSCharacterSet characterSetWithCharactersInString:@";"];
    item.propListStr = [item.propListStr stringByTrimmingCharactersInSet:character]; 
    
    NSString* tempParamentTextStr = [item.propListStr stringByReplacingOccurrencesOfString:@";" withString:@" | "];
     
    
    [[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0] set];
    [tempParamentTextStr drawInRect:CGRectMake(5, 98+2.5, 300, 14) withFont:[UIFont systemFontOfSize:12]];
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
