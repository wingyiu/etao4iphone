//
//  ETBannerController.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETBannerItem.h"
#import "ETBannerSession.h"
#import "ETBannerSessionDelegate.h"

@interface ETBannerController : UIViewController <UIScrollViewDelegate, ETBannerSessionDelegate> {

    UIScrollView* _scrollView;
    ETBannerSession* _bannerSession;
    
    NSTimer* _timer;
}

- (void) setBannerBoundRect:(CGRect)bounds;

@property (nonatomic, retain) UIViewController* superDelegate;
@property (nonatomic, retain) UIScrollView* scrollView;

@end
