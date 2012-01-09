//
//  etaoAleartView.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EtaoAlertView;

@protocol ETaoAlertViewDelegate <NSObject>
@optional

-(void)myAlertViewClickButtonIndex:(EtaoAlertView*)alertView buttonIndex:(NSInteger)index;

@end

@interface EtaoAlertView : UIView
{
    id<ETaoAlertViewDelegate>m_delegate;
}

@property (nonatomic, assign) id<ETaoAlertViewDelegate>m_delegate;

-(id)initBackGroundImage:(UIImage*)img 
                delegate:(id)delegate
                   title:(NSString*)title 
                 message:(NSString*)message 
                //   width:(CGFloat)width
                 buttons:(NSArray*)buttons
             buttonimage:(UIImage*)buttonImg;

-(void)dismissMyAlertView;

@end
