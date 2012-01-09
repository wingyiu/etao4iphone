//
//  UIDeleteLineLabel.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-12-3.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import "UIDeleteLineLabel.h"


@implementation UIDeleteLineLabel

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
    
    const CGContextRef context = UIGraphicsGetCurrentContext();
	if (context != nil) {
		CGContextSaveGState(context) ;
		//CGContextSetFillColor(context, self.textColor.CGColor);
		CGContextFillRect(context, CGRectMake(rect.origin.x, ceil(rect.size.height/2.0), rect.size.width, 1));
		CGContextRestoreGState(context); 
	}  
}



@end
