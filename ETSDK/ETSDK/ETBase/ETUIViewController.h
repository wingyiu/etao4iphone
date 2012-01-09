//
//  ETUIViewController.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETUIViewController : UIViewController{
    ETUIViewController *_superController ;
}

- (void) UIBarButtonItemBackClick:(UIBarButtonItem*)sender ;
- (void) UIBarButtonItemHomeClick:(UIBarButtonItem*)sender ;

@property(nonatomic,assign) ETUIViewController *superController ;
@property(nonatomic, retain) UINavigationController *etnavigationController;

@end

