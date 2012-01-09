//
//  EtaoPageSlideController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define titleWidth 80

#import "ETaoUIViewController.h"
@interface EtaoPageSlideHeader : UIScrollView 
{
}

@property (nonatomic, assign) id target; 
@property (nonatomic, assign) SEL action; 

@end


/* 代理协议 */
@class EtaoPageSlideController;
@protocol EtaoPageSlideControllerDelegate <NSObject>
@optional

//滑动到当前选中的controller
- (void)pageSlideController:(EtaoPageSlideController *)tabBarController 
     didSildeViewController:(UIViewController *)viewController;

//滑动到当前选中的header
- (void)pageSlideController:(EtaoPageSlideController *)tabBarController 
        didSildeHeaderLabel:(UILabel *)headerLabel;

//重新加载数据
- (void)pageSlideController:(EtaoPageSlideController *)tabBarController
                 reloadData:(NSMutableArray *)scrollCtrls;
@end

/* 一个NB滑动控件 */
@interface EtaoPageSlideController : ETaoUIViewController <UIScrollViewDelegate>{
    id <EtaoPageSlideControllerDelegate> delegate;
    
    EtaoPageSlideHeader *_scrollHead;
    UIScrollView *_scrollv;
    
    NSMutableArray *_headViews;
    NSMutableArray *_viewCtrls;

    UIImageView* _leftLabel;
    UIImageView* _rightLabel;
    
    int _kNumberOfPages ;
    int _currentPage;
    
    
}
@property (nonatomic,assign) id <EtaoPageSlideControllerDelegate> delegate;

@property (nonatomic, retain)  UIScrollView *scrollHead;
@property (nonatomic, retain)  UIScrollView *scrollv;

@property (nonatomic, retain)  NSMutableArray *headViews; 
@property (nonatomic, retain)  NSMutableArray *viewCtrls; 

@property int kNumberOfPages;
@property int currentPage;

- (void)arrow; //箭头生成函数
- (void)selectToPage:(int)page;
- (void)loadScrollViewWithPage:(int)page;
- (void)loadHeadScrollViewWithPage:(int)vpage;
- (void)reloadData;

@end

