//
//  Test2MyHttpRequest.m
//  Test2
//
//  Created by 左 昱昊 on 11-10-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoTableViewHttpRequest.h"

@implementation EtaoTableViewHttpRequest

@synthesize _url;
@synthesize data;
@synthesize delegate;
@synthesize requestDidFailedSelector;
@synthesize requestDidFinishSelector;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)load:(NSString *)url withSync:(BOOL)isSync
{
    NSLog(@"Http request Start! %@",url);
    self._url = url;
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [ASIHTTPRequest setDefaultTimeOutSeconds:5];
    [request setDelegate:self]; 		
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    if(isSync){
        [request startSynchronous];
    }
    else{
        [request startAsynchronous]; 		
    }
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES ];
    [request setNumberOfTimesToRetryOnTimeout:3];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"request Finished!");
    self.data = [request responseData];
    if(data && self.requestDidFinishSelector){
        [self.delegate performSelector:self.requestDidFinishSelector withObject:self];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request Failed!");
    if(self.delegate && self.requestDidFailedSelector){
        [self.delegate performSelector:self.requestDidFailedSelector];
    }
}

- (void)dealloc
{
    if(_url!=nil)[_url release];
    if(data!=nil)[data release];
    [super dealloc];
}


@end
