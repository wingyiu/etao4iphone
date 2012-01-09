//
//  ETaoLocalMenuView.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IpadpopupView.h"
@interface ETaoLocalMenuView : IpadpopupView { 	
	id _delegate ;
	SEL _action ; 
	
	BOOL _appeared ;
}  
- (void) disappeared ;

- (void) appeared ;

- (UIButton*) _getButton:(NSString*)text Tag:(int)t Frame:(CGRect)_frame;

- (void)addTarget:(id)target action:(SEL)action;

- (void)downButtonPressed:(id)sender;

@property (nonatomic, assign) id _delegate; 
@property (nonatomic, assign) SEL _action; 
@property (assign) BOOL _appeared ;

@end
