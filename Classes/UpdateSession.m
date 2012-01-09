//
//  UpdateAlertSession.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UpdateSession.h"
#import "NSObject+SBJson.h"

@implementation UpdateSession

@synthesize sessionDelegate = _sessionDelegate;
@synthesize UpdateProtocal = _UpdateProtocal;

- (id)init {
    self = [super init];
    if (self) {
        //
    }
    
    return self;
}


- (void) requestFinished:(HttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _UpdateProtocal) {
        _UpdateProtocal = [[UpdateProtocol alloc] init];
    }
    
    [_UpdateProtocal setItemsByJSON:request.jsonString];
    
    [_sessionDelegate UpdateRequestDidFinish:nil];
}


- (void)requestUpdateDate {

    EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	[httpquery addParam:@"com.taobao.client.sys.updatecheck&v=iphone" forKey:@"api"];
	[httpquery addParam:__TTID__ forKey:@"ttid"];
		
	[httpquery start];    
}


- (void) SetRequestDateSource:(NSString *)requestStr {
    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _UpdateProtocal) {
        _UpdateProtocal = [[UpdateProtocol alloc] init];
    }
    
    [_UpdateProtocal setItemsByJSON:requestStr];
	
    [_sessionDelegate UpdateRequestDidFinish:nil];
}


- (void) requestFailed:(HttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);
    
    [_sessionDelegate UpdateRequestDidFailed:request];
}


- (void) dealloc {
    
    [_UpdateProtocal release];
    //[_httpRequest release];
    //[_dictParam release];
    //[_jsonStrin release];
    
    [super dealloc];
}

@end
