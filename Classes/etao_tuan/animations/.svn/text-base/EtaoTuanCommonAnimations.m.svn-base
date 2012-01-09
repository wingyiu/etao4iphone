//
//  EtaoTuanCommonAnimations.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTuanCommonAnimations.h"

@implementation EtaoTuanCommonAnimations



+ (void) updateAnimationDown:(UILabel*)update_label
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGRect frame = update_label.frame;
    frame.origin.y = 0;
    update_label.frame = frame;
    [UIView commitAnimations];
}

+ (void) updateAnimationUp:(UILabel*)update_label
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGRect frame = update_label.frame;
    frame.origin.y = -27;
    update_label.frame = frame;
    [UIView commitAnimations];
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
    animation.duration = 0.4;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
}

+(void) disScalesAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.4;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:nil];
    
}

+ (void) showMapAnimation:(UIView*)sliderView withMapView:(UIView*)mapView
{
 
//    CAKeyframeAnimation *animation=nil;
//    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.8;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT-100, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT-40, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT-10, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT-5, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT, 1.0)]];
//    animation.values = values;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [animation setDelegate:self];
//    [sliderView.layer addAnimation:animation forKey:nil];
    
//    [mapView setHidden:NO];
//    [mapView setFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];
//    [sliderView setFrame:CGRectMake(0, MAP_HEIGHT, 320, 460-MAP_HEIGHT-44)];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self];
////    [UIView setAnimationCurve:C];
//    [UIView setAnimationDuration:0.4]; 
//    [sliderView setFrame:CGRectMake(0, MAP_HEIGHT, 320, 460-MAP_HEIGHT-44)];
//    [mapView setFrame:CGRectMake(0, 0, 320, MAP_HEIGHT)];
//    [UIView commitAnimations]; 
//    [mapView setHidden:NO];
    
//    //第一贞
//    [UIView animateWithDuration:0.1 
//                     animations:^{[sliderView setFrame:CGRectMake(0, MAP_HEIGHT-100, 320, 460-MAP_HEIGHT-44)];} 
//                     completion:^(BOOL finish){
//                         //第二贞
//                         [UIView animateWithDuration:0.1 
//                                          animations:^{[sliderView setFrame:CGRectMake(0, MAP_HEIGHT-40, 320, 460-MAP_HEIGHT-44)];} 
//                                          completion:^(BOOL finish){
//                                              //第三贞
//                                              [UIView animateWithDuration:0.1 
//                                                               animations:^{[sliderView setFrame:CGRectMake(0, MAP_HEIGHT, 320, 460-MAP_HEIGHT-44)];} 
//                                                               completion:^(BOOL finish){}];
//                                          }];
//                     }];
    
    
    
    [mapView setHidden:NO];
    //第一贞
    [UIView animateWithDuration:0.3 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseOut  
                     animations:^{[sliderView setFrame:CGRectMake(0, MAP_HEIGHT, 320, 460-MAP_HEIGHT-44)];} 
                     completion:^(BOOL finished){
                         //第二贞
                         [UIView animateWithDuration:0.1
                                          animations:^{[sliderView setFrame:CGRectMake(0, MAP_HEIGHT-5, 320, 460-MAP_HEIGHT-44)];} 
                                          completion:^(BOOL finished){
                                              //第三贞
                                              [UIView animateWithDuration:0.1
                                                               animations:^{[sliderView setFrame:CGRectMake(0, MAP_HEIGHT, 320, 460-MAP_HEIGHT-44)];} 
                                                               completion:^(BOOL finished){
                                                                   
                                              }];
                         }];
    }];
    
}

+ (void) disMapAnimation:(UIView*)sliderView withMapView:(UIView*)mapView
{
//    CAKeyframeAnimation *animation=nil;
//    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.8;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, MAP_HEIGHT, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 40, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 10, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 5, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 1.0)]];
//    animation.values = values;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [animation setDelegate:self];
//    [sliderView.layer addAnimation:animation forKey:nil];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [UIView setAnimationDuration:0.4]; 
//    [sliderView setFrame:CGRectMake(0, 0, 320, 460-44)];
//    [mapView setFrame:CGRectMake(0, 0, 320, 0)];
//    [UIView commitAnimations];
    
    //第一贞
    [UIView animateWithDuration:0.3 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseOut  
                     animations:^{[sliderView setFrame:CGRectMake(0, 0, 320, 460-44)];} 
                     completion:^(BOOL finished){
                         //第二贞
                         [UIView animateWithDuration:0.1
                                          animations:^{[sliderView setFrame:CGRectMake(0, 5, 320, 460-44)];} 
                                          completion:^(BOOL finished){
                                              //第三贞
                                              [UIView animateWithDuration:0.1
                                                               animations:^{[sliderView setFrame:CGRectMake(0,0, 320, 460-44)];} 
                                                               completion:^(BOOL finished){
                                                                   [mapView setHidden:YES];
                                               }];
                          }];
    }];
}



@end
