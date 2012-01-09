//
//  EtaoPageBaseViewController.h
//  etaoetao
//
//  Created by GuanYuhong on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoPageBaseCategoryController.h"

@interface EtaoScrollView : UIScrollView 
{
}

@property (nonatomic, assign) id target; 
@property (nonatomic, assign) SEL action; 

@end

/* 代理协议 */ 

@protocol EtaoPageBaseViewControllerDelegate <NSObject>
@optional

//滑动到当前选中的controller
- (void)pageSlideToController:(UIViewController *)viewController;  
@end


@interface EtaoPageBaseViewController : UIViewController <UIScrollViewDelegate>
{  
    id <EtaoPageBaseViewControllerDelegate> delegate;
    SEL didPageSlideController;
    
    EtaoScrollView *_scrollHead;
    UIScrollView *_scrollv;
	UIPageControl *_pagectrl;
    
    NSMutableArray *_viewCtrls;
    
    NSMutableArray *_headViews;
     
    int kNumberOfPages ;
    
    UIImageView* _leftLabel;
    UIImageView* _rightLabel;
}
@property (nonatomic,assign) id delegate;
@property SEL didPageSlideController;
@property (nonatomic, retain)  UIScrollView *scrollv;
@property (nonatomic, retain)  EtaoScrollView *scrollHead;
@property (nonatomic, retain)  UIPageControl *pagectrl;
@property (nonatomic, retain)  NSMutableArray *viewCtrls; 
@property (nonatomic, retain)  NSMutableArray *headViews; 
@property (nonatomic, retain)  UIImageView* leftLabel;
@property (nonatomic, retain)  UIImageView* rightLabel;

@property (nonatomic, retain)  EtaoPageBaseCategoryController *categoryController; 
@property (nonatomic, retain)  UIViewController *searchController; 
 
@property int kNumberOfPages ;

- (id)initWithCategoryController:(EtaoPageBaseCategoryController *)categoryViewController ;
- (id)initWithViewController:(NSArray *)viewControllers ;

- (void)scrollToPage:(int)page ;

- (void)loadScrollViewWithPage:(int)page;
- (void)loadHeadScrollViewWithPage:(int)vpage;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end
