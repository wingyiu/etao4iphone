//
//  ETaoUIViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETaoUIViewController : UIViewController
{
    ETaoUIViewController *_superController ;
}

- (void) UIBarButtonItemBackClick:(UIBarButtonItem*)sender ;
- (void) UIBarButtonItemHomeClick:(UIBarButtonItem*)sender ;

@property(nonatomic,assign) ETaoUIViewController *superController ;

@end
