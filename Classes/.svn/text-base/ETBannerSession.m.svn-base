//
//  ETBannerSession.m
//  etao4iphone
//
//  Created by 稳 张 on 11-12-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETBannerSession.h"
#import "NSObject+SBJson.h"


@interface ETBannerSession()
@end


@implementation ETBannerSession

@synthesize sessionDelegate = _sessionDelegate;
@synthesize bannerProtocal = _bannerProtocal;
@synthesize http = _http;



- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}


- (void) requestFinished:(ETHttpRequest *)request {    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _bannerProtocal) {
        _bannerProtocal = [[ETBannerProtocol alloc] init];
    }
    
    [_bannerProtocal setItemsByJSON:request.jsonString];
    
    [_sessionDelegate bannerRequestDidFinish:request.jsonString];

    //保存成功的数据，以防止下次失败时使用。
    [[NSUserDefaults standardUserDefaults] setObject:request.jsonString forKey:@"EtaoBannerSearchDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)requestSearchBannerDate {
    
    if (nil == _http) {
        _http = [[ETHttpRequest alloc]init];
        [_http setDelegate:self];
    }
	
    [_http load: @"http://wap.etao.com/go/rgn/decider/etaohomebanner.html"];
}


- (void) requestFailed:(ETHttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);
    
    //当下载失败时，读取上次存储的数据。
    NSString* catedate = [[NSUserDefaults standardUserDefaults] stringForKey:@"EtaoBannerSearchDate"];
    
    if(catedate != nil) {
        if(nil == _bannerProtocal) {
            _bannerProtocal = [[ETBannerProtocol alloc] init];
        }
        
        [_bannerProtocal setItemsByJSON:catedate];
        
        [_sessionDelegate bannerRequestDidFinish:nil];
        return;
    }

    
    [_sessionDelegate bannerRequestDidFailed:request];
}


- (void) dealloc {
    
    _sessionDelegate = nil;
    
    [_http release];
    
    [_bannerProtocal release];
    
    [super dealloc];
}


@end
