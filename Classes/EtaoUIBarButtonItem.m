//
//  EtaoUIBarButtonItem.m
//  demo4etao
//
//  Created by GuanYuhong on 11-11-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoUIBarButtonItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation EtaoUIBarButtonItem

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

- (void) dealloc {
    [super dealloc];
}

// add by zhangsuntai
- (void)buttonClick {
    if (self.target && self.action && [self.target respondsToSelector:self.action]) {  
        [self.target performSelectorOnMainThread:self.action withObject:self waitUntilDone:YES];
    } 
    
}

- (id)initWithImage:(UIImage*)image target:(id)target action:(SEL)action{
    
    self = [super init];
    if (self) {  
        self.target = target ;
        self.action = action ;
        
        UIButton *aboutBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)]autorelease]; 
        [aboutBtn setImage:image forState:UIControlStateNormal]; 
        [aboutBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];    
        [aboutBtn setBackgroundImage:[UIImage imageNamed:@"navLeftButton.png"] forState:UIControlStateNormal];
        //UIView *v = [[[UIView alloc]initWithFrame:CGRectMake(39.5, 0, 0.5, 44)]autorelease];
        // v.backgroundColor = [UIColor lightGrayColor];
        //[aboutBtn addSubview:v];  
        [self initWithCustomView:aboutBtn];
		return self;  
    }
	return nil; 
}


- (id)initWithTitle:(NSString*)title bkColor:(UIColor*)color target:(id)target action:(SEL)action {
    
    self = [super init];
    if (self) {  
       // color = [UIColor colorWithRed:40/255.0f green:134/255.0f blue:174/255.0f alpha:1.0];
        self.target = target ;
        self.action = action ;
        self.title = title ;
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btn setFrame:CGRectMake(0, 0, 40, 30)];
        UIButton *btn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)]autorelease]; 
        //[btn setBackgroundImage:[EtaoUIBarButtonItem imageWithColor:color] forState:UIControlStateNormal]; 
        [btn setTitle:title forState:UIControlStateNormal];
        
//        [btn.layer setBorderColor: [[UIColor clearColor] CGColor]];
//        [btn.layer setBorderWidth: 4.0];
        [btn setBackgroundImage:[UIImage imageNamed:@"navRightButton.png"] forState:UIControlStateNormal];
        
        UIFont *font = [UIFont boldSystemFontOfSize:15];
		btn.titleLabel.font  = font;
		btn.titleLabel.textAlignment = UITextAlignmentCenter; 
		btn.titleLabel.shadowColor = [UIColor grayColor]; 
        btn.titleLabel.textColor = [UIColor whiteColor];//colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
//        btn.titleLabel.highlightedTextColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
 
		//CGSize s = {-1.0,-1.0};
		//btn.titleLabel.shadowOffset = s;   
        [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];         
        [self initWithCustomView:btn];
		return self;  
    }
	return nil;   
    
}
@end
