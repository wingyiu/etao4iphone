//
//  EtaoSlider.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EtaoSliderView.h"


@implementation EtaoSliderView

@synthesize barView = _barView;
@synthesize thumbViewLeft = _thumbViewLeft;
@synthesize thumbViewRight = _thumbViewRight;
@synthesize labelLeft = _labelLeft;
@synthesize labelRight = _labelRight;
@synthesize delegate = _delegate;

- (void)dealloc{
    if (_barView != nil) {
        [_barView release];
        _barView = nil;
    }
    if (_thumbViewLeft != nil) {
        [_thumbViewLeft release];
        _thumbViewLeft = nil;
    }
    if (_thumbViewRight != nil) {
        [_thumbViewRight release];
        _thumbViewRight = nil;
    }
    if (_labelLeft != nil) {
        [_labelLeft release];
        _labelLeft = nil;
    }
    if (_labelRight != nil) {
        [_labelRight release];
        _labelRight = nil;
    }
    if (_delegate != nil) {
        _delegate = nil;
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        UIImage *barImg = [UIImage imageNamed:@"bar.png"];
        UIImage* thumbLeftImg = [UIImage imageNamed:@"thumbleft.png"];
        UIImage* thumbRightImg = [UIImage imageNamed:@"thumbright.png"];
        UIImage* labelImg = [UIImage imageNamed:@"characterLabel.png"];
        
        self.barView = [[[UIView alloc]initWithFrame:CGRectMake(thumbLeftImg.size.width, 0, frame.size.width-thumbLeftImg.size.width*2, frame.size.height)]autorelease];        
        UIImageView* barImgView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _barView.frame.size.width, barImg.size.height)]autorelease];
        barImgView.image = barImg;       
        [barImgView setContentMode:UIViewContentModeScaleToFill];
        [_barView addSubview:barImgView];

        self.thumbViewLeft = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, thumbLeftImg.size.width, thumbLeftImg.size.height)]autorelease];
        [_thumbViewLeft setBackgroundColor:[UIColor colorWithPatternImage:thumbLeftImg]];
        _thumbViewLeft.center = CGPointMake(frame.origin.x, barImgView.frame.size.height/2);
        _thumbViewLeft.userInteractionEnabled = YES;
        _thumbViewLeft.tag = 100;
        
        self.thumbViewRight = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, thumbRightImg.size.width, thumbRightImg.size.height)]autorelease];
        [_thumbViewRight setBackgroundColor:[UIColor colorWithPatternImage:thumbRightImg]];
        _thumbViewRight.center = CGPointMake(frame.origin.x, barImgView.frame.size.height/2);
        _thumbViewRight.userInteractionEnabled = YES;
        _thumbViewRight.tag = 101;
        
        [self addSubview:_barView];
        [self addSubview:_thumbViewRight];
        [self addSubview:_thumbViewLeft];
        
        UIPanGestureRecognizer *panGesLeft = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanLeft:)];    
        panGesLeft.maximumNumberOfTouches = 1;
        panGesLeft.delegate = self;
        [_thumbViewLeft addGestureRecognizer:panGesLeft];
        [panGesLeft release];
        
        
        UIPanGestureRecognizer *panGesRight = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanRight:)];
        panGesRight.maximumNumberOfTouches = 1;
        panGesRight.delegate = self;
        [_thumbViewRight addGestureRecognizer:panGesRight];
        [panGesRight release];
        
        self.labelLeft = [[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, barImgView.frame.size.height/2-46, 100, 29)]autorelease];
        _labelLeft.backgroundColor = [UIColor colorWithPatternImage:labelImg];
        _labelLeft.opaque = NO;
        _labelLeft.font = [UIFont systemFontOfSize:18];
        _labelLeft.textAlignment = UITextAlignmentCenter;
        _labelLeft.lineBreakMode = UILineBreakModeCharacterWrap;
        [self addSubview:_labelLeft];
        self.labelRight = [[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, barImgView.frame.size.height/2-46, 100, 29)]autorelease];
        _labelRight.backgroundColor = [UIColor colorWithPatternImage:labelImg];
        _labelRight.opaque = NO;
        _labelRight.font = [UIFont systemFontOfSize:18];
        _labelRight.textAlignment = UITextAlignmentCenter;
        _labelRight.lineBreakMode = UILineBreakModeCharacterWrap;
        [self addSubview:_labelRight];
    }
    return self;
}

- (void)setSliderPositions:(float)leftv andRightValue:(float)rightv{
    left_value = leftv;
    right_value = rightv;
    float eachScale = (maxinum-mininum)/(_barView.frame.size.width);
    if (left_value <= mininum) {
        _thumbViewLeft.center = CGPointMake(_barView.frame.origin.x, _thumbViewLeft.center.y);
        _labelLeft.text = [NSString stringWithFormat:@"%.1f", mininum];
    }else if(left_value >= maxinum){
        _thumbViewLeft.center = CGPointMake(_barView.frame.size.width+_barView.frame.origin.x, _thumbViewLeft.center.y);
        _labelLeft.text = [NSString stringWithFormat:@"%.1f", maxinum];
    }else{
        _thumbViewLeft.center = CGPointMake(left_value/eachScale+_barView.frame.origin.x, _thumbViewLeft.center.y);
        _labelLeft.text = [NSString stringWithFormat:@"%.1f", left_value];
    }
    _labelLeft.center = CGPointMake(_thumbViewLeft.center.x, _labelLeft.center.y);
    
    if (right_value <= mininum) {
        _thumbViewRight.center = CGPointMake(_barView.frame.origin.x, _thumbViewLeft.center.y);
         _labelRight.text = [NSString stringWithFormat:@"%.1f", mininum];
    }else if(right_value >= maxinum){
        _thumbViewRight.center = CGPointMake(_barView.frame.size.width+_barView.frame.origin.x, _thumbViewLeft.center.y);
         _labelRight.text = [NSString stringWithFormat:@"%.1f", maxinum];
    }else{
        _thumbViewRight.center = CGPointMake(right_value/eachScale+_barView.frame.origin.x, _thumbViewLeft.center.y);
        _labelRight.text = [NSString stringWithFormat:@"%.1f", right_value];
    }
    _labelRight.center = CGPointMake(_thumbViewRight.center.x, _labelRight.center.y);
    
}

- (void)setSliderMininumAndMaxinum:(float)min andMaxinum:(float)max{
    mininum = min;
    maxinum = max;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIView *aViewLeft = [self viewWithTag:100];
    UIView *aViewRight = [self viewWithTag:101];
    if (touch.view != aViewLeft && touch.view != aViewRight) {
        return NO;
    }
    return YES;
}

- (void)handlePanLeft:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint curPoint = [gestureRecognizer locationInView:self];
    curPoint.x = curPoint.x - _barView.frame.origin.x;
    float eachScale = (maxinum-mininum)/(_barView.frame.size.width);
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        if (curPoint.x <= 0) {
            _thumbViewLeft.center = CGPointMake(_barView.frame.origin.x, _thumbViewLeft.center.y);
            _labelLeft.text = [NSString stringWithFormat:@"%.1f", mininum];
        }
        else if(curPoint.x >= (_barView.frame.size.width))
        {
            _thumbViewLeft.center = CGPointMake(_barView.frame.size.width+_barView.frame.origin.x, _thumbViewLeft.center.y);
            _labelLeft.text = [NSString stringWithFormat:@"%.1f", maxinum];
        }
        else{
            [_thumbViewLeft setCenter:CGPointMake(curPoint.x+_barView.frame.origin.x, _thumbViewLeft.center.y)];
            _labelLeft.text = [NSString stringWithFormat:@"%.1f", (curPoint.x)*eachScale];
        }
        _labelLeft.center = CGPointMake(_thumbViewLeft.center.x, _labelLeft.center.y);
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(handlePanLeftDragFinished:)]) {
            [self.delegate handlePanLeftDragFinished:_labelLeft.text];
        }
    }
}

- (void)handlePanRight:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint curPoint = [gestureRecognizer locationInView:self];
    curPoint.x = curPoint.x - _barView.frame.origin.x;
    float eachScale = (maxinum-mininum)/(_barView.frame.size.width);
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        if (curPoint.x <= 0) {
            _thumbViewRight.center = CGPointMake(_barView.frame.origin.x, _thumbViewLeft.center.y);
            _labelRight.text = [NSString stringWithFormat:@"%.1f", mininum];
        }else if(curPoint.x >= (_barView.frame.size.width)){
             _thumbViewRight.center = CGPointMake(_barView.frame.size.width+_barView.frame.origin.x, _thumbViewLeft.center.y);
            _labelRight.text = [NSString stringWithFormat:@"%.1f", maxinum];
        }
        else{
            [_thumbViewRight setCenter:CGPointMake(curPoint.x+_barView.frame.origin.x, _thumbViewLeft.center.y)];
            _labelRight.text = [NSString stringWithFormat:@"%.1f", curPoint.x*eachScale];
        }
        _labelRight.center = CGPointMake(_thumbViewRight.center.x, _labelRight.center.y);
        
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(handlePanRightDragFinished:)]) {
            [self.delegate handlePanRightDragFinished:_labelRight.text];
        }
    }
}

@end
