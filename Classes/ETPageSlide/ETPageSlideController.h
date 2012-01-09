//
//  ETPageSlideController.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPageTouchView.h"
#import "ETPageTouchDelegate.h"
#import "ETPageSlideDelegate.h"

#define titleWidth 80

@interface ETPageSlideController : UIViewController <UIScrollViewDelegate>
{
    id <ETPageSlideDelegate,ETPageTouchDelegate> _delegate;
    
    UIScrollView* _viewHead;
    UIScrollView* _viewBody;
    
    int _currentPage;
    int _countOfPage;
    
    NSMutableDictionary* _ctrlsCache;
    
    NSMutableArray* _headArray; //头部数组
    NSMutableArray* _bodyArray; //主体数组
    NSMutableArray* _keyArray;  //主体key数组
    
    UIImageView* _leftLabel;
    UIImageView* _rightLabel;
    
    UIActivityIndicatorView* _activityView;//加载动画
}

@property (nonatomic,assign) id <ETPageSlideDelegate,ETPageTouchDelegate> delegate;
- (void)removeCtrls:(id)key;
- (void)reloadData;
- (void)reloadPage:(NSNumber *)index;
- (void)arrow;
@end
