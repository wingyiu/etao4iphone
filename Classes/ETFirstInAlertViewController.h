//
//  FirstInAlertViewController.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETFirstInAlertItem.h"
#import "ETFirstAlertDelegate.h"

@interface ETFirstInAlertViewController: UIViewController<UIScrollViewDelegate> {

//    id<ETFirstAlertDelegate> delegate;
    
    UIScrollView* _scrollView;
    NSArray* _itemsPageArray;
}

+ (BOOL) isFirstShow;

- (id) initWithItem:(ETFirstInAlertItem*) item;
- (id) initWithArray:(NSArray*) itemArray;


//默认，只显示一次后，再不显示。此模式应用于还想再显示的特殊情况。比如帮助之类页面，可能会有特殊需求。
//-(void) isPlayNextTime:(BOOL)isPlay;

@property (nonatomic, assign ) id<ETFirstAlertDelegate> delegate;

@property (nonatomic, retain) NSArray* itemsPageArray;
@property (nonatomic, retain) UIScrollView* scrollView;

@end
