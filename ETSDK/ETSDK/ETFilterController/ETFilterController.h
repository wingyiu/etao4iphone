//
//  ETFilterController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


 
#import "ETFilterViewController.h"


@protocol ETFilterControllerDelegate <NSObject>

@optional


@end


@interface ETFilterController : NSObject <UIGestureRecognizerDelegate>{
    UIViewController *_parent ;
    
    float _beginx;
    float _lastpos;
    
    ETFilterViewController *_etFilterViewController ;
    
}
 

@property (nonatomic,retain) UIPanGestureRecognizer *panGes;
@property (nonatomic,assign,setter = initWithDelegate:) id<NSObject> delegate ;
@property (nonatomic,assign) UIView *view ;


@end
