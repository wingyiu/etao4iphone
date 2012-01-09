//
//  ETHttpRequestTestController.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ETHttpRequest.h"
#import "ETUIViewController.h"
#import "ETHttpImageView.h"
#import "ETDetailSwipeController.h"
@interface ETHttpRequestTestController : ETUIViewController <EtaoHttpRequstDelegate,EtaoHttpImageViewDelegate,ETDetailSwipeInsiderControllerDelegate>

@property (nonatomic, retain) ETHttpRequest *httpr ;
@property (nonatomic ,retain) UILabel *progress;
@end
