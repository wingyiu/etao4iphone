//
//  SearchDetailSessionDelegate.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchDetailSessionDelegate<NSObject> 

- (void) SearchDetailRequestDidFinish:(NSObject *)obj;
- (void) SearchDetailRequestDidFailed:(NSObject *)obg;

@end
