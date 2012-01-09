//
//  ETPageTouchView.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPageTouchDelegate.h"
@interface ETPageTouchView : UIView <UIGestureRecognizerDelegate>
{
    id <ETPageTouchDelegate> _delegate;
    int _page;
    
    UISwipeGestureRecognizer* _swipeLeftRecognizer;
    UISwipeGestureRecognizer* _swipeRightRecognizer;
    UISwipeGestureRecognizer* _swipeUpRecognizer;
    UISwipeGestureRecognizer* _swipeDownRecognizer;
}
@property (nonatomic,assign) id <ETPageTouchDelegate> delegate;
@property (nonatomic,assign) int page;

@property (nonatomic,retain) UISwipeGestureRecognizer* swipeLeftRecognizer;
@property (nonatomic,retain) UISwipeGestureRecognizer* swipeRightRecognizer;
@property (nonatomic,retain) UISwipeGestureRecognizer* swipeUpRecognizer;
@property (nonatomic,retain) UISwipeGestureRecognizer* swipeDownRecognizer;

@end
