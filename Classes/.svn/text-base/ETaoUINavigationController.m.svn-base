//
//  ETaoUINavigationController.m
//  yyyy
//
//  Created by GuanYuhong on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETaoUINavigationController.h"
#import "EtaoUIBarButtonItem.h"

@implementation UINavigationBar (background)

- (void)drawRect:(CGRect)rect {
    //UIImage *image = [UIImage imageNamed:@"second.png"];
    UIImage *image = [EtaoUIBarButtonItem imageWithColor:[UIColor colorWithRed:43/255.0f green:166/255.0f blue:210/255.0f alpha:1.0]];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end

@implementation ETaoUINavigationController
 
- (void)dealloc
{ 
    [super dealloc];     
}

- (id)initWithRootViewController:(UIViewController *)rootViewController andImage:(UIImage*)image{
    
    self = [super initWithRootViewController:rootViewController];
    if (self) { 
        if([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
            //iOS 5 new UINavigationBar custom background
            [self.navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
        } 
		return self;  
    }
	return nil; 
}

- (id)initWithRootViewController:(UIViewController *)rootViewController andColor:(UIColor*)color {
    
    self = [super initWithRootViewController:rootViewController];
    if (self) { 
        if([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
            //iOS 5 new UINavigationBar custom background
            UIImage *image = [EtaoUIBarButtonItem imageWithColor:color];
            [self.navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
        } 
		return self;  
    }
	return nil;   
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{ 
    return [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{     
    viewController.navigationItem.backBarButtonItem = nil;
    EtaoUIBarButtonItem *back = [[[EtaoUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_arrow.png"] target:viewController action:@selector(UIBarButtonItemBackClick:)]autorelease];
    back.title = @"back"; 
    viewController.navigationItem.leftBarButtonItem = back;
     
    [super pushViewController:viewController animated:animated];  
     
}

@end
