//
//  EtoMoreViewController.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoUIViewWithBackgroundController.h"
#import "ETaoUIViewController.h"

@class UserFeedBackByEmail;
@interface EtaoMoreViewController : ETaoUIViewController {

    UserFeedBackByEmail* _userFeedBuEmail;
}

@property (nonatomic, retain)UserFeedBackByEmail* userFeedBuEmail;

@end
