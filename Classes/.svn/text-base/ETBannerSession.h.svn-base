//
//  ETBannerSession.h
//  etao4iphone
//
//  Created by 稳 张 on 11-12-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBannerProtocol.h"
#import "ETBannerSessionDelegate.h"
#import "ETHttpRequest.h"

@interface ETBannerSession : NSObject <ETHttpRequstDelegate>{
    
    id<ETBannerSessionDelegate> _sessionDelegate;
    
    ETBannerProtocol* _bannerProtocal;
    
    ETHttpRequest* _http;
}

- (void)requestSearchBannerDate; 

- (void) requestFinished:(ETHttpRequest *)request;
- (void) requestFailed:(ETHttpRequest *)request;

@property (nonatomic, assign ) id<ETBannerSessionDelegate> sessionDelegate;
@property (nonatomic, retain) ETBannerProtocol* bannerProtocal;
@property (nonatomic, retain) ETHttpRequest *http;

@end
