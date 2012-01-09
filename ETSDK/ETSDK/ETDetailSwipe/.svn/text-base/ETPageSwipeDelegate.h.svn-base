//
//  ETPageSwipeDelegate.h
//  etao4iphone
//
//  Created by 左 昱昊 on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETPageSwipeDelegate <NSObject>
@optional
    //滑动到某一页
    - (void)swipeAtIndex:(NSNumber*)index withCtrls:(UIViewController*)controller;
    //退出滑动
    - (void)swipeWillExitAtIndex:(NSNumber*)index;
@end

@protocol ETPageSwipeDetailDelegate <NSObject>
//以一个宝贝初始化详情页,实现这个接口后，调用者会很省心...
- (id)initWithItem:(id)item;

@end
