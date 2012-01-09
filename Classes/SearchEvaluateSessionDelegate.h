//
//  SearchEvaluateSessionDelegate.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SearchEvaluateSessionDelegate<NSObject> 

- (void) SearchEvaluateRequestDidFinish:(NSObject *)obj;
- (void) SearchEvaluateRequestDidFailed:(NSObject *)obg;

@end
