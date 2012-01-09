//
//  EtaoSlider.h
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EtaoSliderDelegate <NSObject>

- (void)handlePanLeftDragFinished:(NSString *)leftStr;
- (void)handlePanRightDragFinished:(NSString *)rightStr;

@end

@interface EtaoSliderView : UIView <UIGestureRecognizerDelegate>
{
    UIView *_barView;
    UIView *_thumbViewLeft;
    UIView *_thumbViewRight;
    
    UILabel *_labelLeft;
    UILabel *_labelRight;
    
    float left_value;
    float right_value;
    float maxinum;
    float mininum;
    
    id <EtaoSliderDelegate> _delegate;
}

@property (nonatomic, retain) UIView *barView;
@property (nonatomic, retain) UIView *thumbViewLeft;
@property (nonatomic, retain) UIView *thumbViewRight;
@property (nonatomic, retain) UILabel *labelLeft;
@property (nonatomic, retain) UILabel *labelRight;
@property (nonatomic, assign) id<EtaoSliderDelegate> delegate;

- (void)setSliderPositions:(float)leftv andRightValue:(float)rightv;

- (void)setSliderMininumAndMaxinum:(float)min andMaxinum:(float)max;

@end
