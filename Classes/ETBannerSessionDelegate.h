//
//  ETBannerSessionDelegate.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETBannerSessionDelegate <NSObject>

- (void) bannerRequestDidFinish:(NSObject *)obj;
- (void) bannerRequestDidFailed:(NSObject *)obg;

@end
