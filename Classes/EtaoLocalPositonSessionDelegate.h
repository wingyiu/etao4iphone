//
//  EtaoLocalPositonSessionDelegate.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EtaoLocalPositonSessionDelegate<NSObject> 

- (void) positonSessionRequestDidFinish:(id)sender;
- (void) positonSessionRequestDidFailed:(id)sender;

- (void) userLocationInfoRequestDidFinish:(id)sender;
- (void) userLocationInfoRequestDidFailed:(id)sender;

@end
