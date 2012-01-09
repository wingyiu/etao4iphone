//
//  ETPageTouchView.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPageTouchDelegate.h"
@interface ETPageTouchView : UIView
{
    id <ETPageTouchDelegate> _delegate;
}
@property (nonatomic,assign) id <ETPageTouchDelegate> delegate;

@end
