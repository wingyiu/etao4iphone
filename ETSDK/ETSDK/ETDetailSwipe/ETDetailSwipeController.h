//
//  ETDetailSwipeController.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETUIViewController.h"
#import "EtaoTuanAuctionItem.h"

@protocol ETDetailSwipeInsiderControllerDelegate <NSObject>

//设置item
- (void) setDetailFromItem:(id)item;
//滑动到某一页
- (void)swipeAtIndex:(NSNumber*)index withCtrls:(UIViewController*)controller;
//退出滑动
- (void)swipeWillExitAtIndex:(NSNumber*)index;

@end

@interface ETDetailSwipeController : ETUIViewController <UIGestureRecognizerDelegate> {
     
    NSMutableArray *_detailsDataSourceItems;
    int _index ;
    
    UIViewController<ETDetailSwipeInsiderControllerDelegate> *_detailController; 
    UIViewController<ETDetailSwipeInsiderControllerDelegate> *_detailController2; 
    
}
@property (nonatomic, retain) NSString *navTitle;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeRightRecognizer;  

@property (nonatomic, assign) Class cls;

@property (nonatomic, retain) NSMutableArray *detailsDataSourceItems;


@property (nonatomic, retain) UIViewController<ETDetailSwipeInsiderControllerDelegate> *detailController;  

@property (nonatomic, retain) UIViewController<ETDetailSwipeInsiderControllerDelegate> *detailController2;


- (void) setDetailByIndex:(int) idx ;

-(UIView *)initButtomInfoView: (EtaoTuanAuctionItem *)_item;


@end
