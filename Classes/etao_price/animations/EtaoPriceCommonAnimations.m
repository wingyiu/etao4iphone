//
//  EtaoPriceCommonAnimations.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoPriceCommonAnimations.h"

@implementation EtaoPriceCommonAnimations



+ (void) updateAnimationDown:(UILabel*)update_label
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    CGRect frame = update_label.frame;
//    frame.origin.y = 0;
//    update_label.frame = frame;
//    [UIView commitAnimations];
    
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,25, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,27, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,22, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,25, 1.0)]];
    //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,23, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [update_label.layer addAnimation:animation forKey:nil];
}

+ (void) updateAnimationUp:(UILabel*)update_label
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    CGRect frame = update_label.frame;
//    frame.origin.y = -27;
//    update_label.frame = frame;
//    [UIView commitAnimations];
    
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,25, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,27, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,22, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0,0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [update_label.layer addAnimation:animation forKey:nil];
}

+(void) showShakeAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(10, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-10, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
}

+(void) showScalesAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
}

@end
