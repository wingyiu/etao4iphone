//
//  UserFeedBackController.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoUIViewWithBackgroundController.h"
#import "ETaoUIViewController.h"
#import <MessageUI/MessageUI.h>

@interface UserFeedBackByEmail:NSObject<MFMailComposeViewControllerDelegate> {
    
    id controllerID;
}

- (void) sendEmail:(id)sender;
@property (nonatomic, assign) id controllerID;

@end
