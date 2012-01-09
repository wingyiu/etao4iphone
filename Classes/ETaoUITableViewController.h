//
//  ETaoUITableViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETaoUITableViewController : UITableViewController{
     
    UIViewController *_superController ;
}

- (void) UIBarButtonItemBackClick:(UIBarButtonItem*)sender ;
- (void) UIBarButtonItemHomeClick:(UIBarButtonItem*)sender ;

@property(nonatomic,retain) UIViewController *superController ;
@end
