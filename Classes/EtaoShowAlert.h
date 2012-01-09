//
//  EtaoShowAleartView.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EtaoAlertView;

@interface EtaoShowAlert : NSObject 

+ (void)showAlert;

@property (nonatomic, retain) EtaoAlertView *etaoAlertView;

@end
