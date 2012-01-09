//
//  ETPageSwipeController.h
//  etao4iphone
//
//  Created by 左 昱昊 on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPageSwipeDelegate.h"
#import "EtaoUIBarButtonItem.h"

@interface ETPageSwipeController : UIViewController <UIGestureRecognizerDelegate>{
    
    NSMutableArray* _items;
    int _index;
    id<ETPageSwipeDelegate> _delegate;
    
    UIViewController<ETPageSwipeDelegate>* _thisCtrls;
    UIViewController<ETPageSwipeDelegate>* _nextCtrls;
    
    Class _detailClass;
    
}

@property (nonatomic, retain) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeRightRecognizer;  

- (id)initWithItems:(NSMutableArray*)items
         withDelegate:(id<ETPageSwipeDelegate>)delegate
              atIndex:(int)index
        byDetailClass:(Class<ETPageSwipeDetailDelegate>)detailClass;

@end
