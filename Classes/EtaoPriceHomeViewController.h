//
//  EtaoJiangJiaHomeViewController.h
//  etao4iphone
//
//  Created by GuanYuhong on 11-11-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtaoPageBaseViewController.h"
#import "EtaoPageSlideController.h"
#import "EtaoPriceSettingController.h"
#import "ETaoUINavigationController.h"

@interface EtaoPriceHomeViewController:EtaoPageSlideController <EtaoPageSlideControllerDelegate> {
    NSMutableArray* _priceControllers;   
    EtaoPriceSettingController* _setting; 
    EtaoPriceSettingController* _setting2;
    
    BOOL _mode_lock;

}

+ (ETaoUINavigationController*)getNavgationController;

@end
