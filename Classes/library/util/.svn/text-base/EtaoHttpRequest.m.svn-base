//
//  HttpRequest.m
//  testASIhttp
//
//  Created by GuanYuhong on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoHttpRequest.h"
@implementation EtaoHttpRequest


@synthesize delegate = _delegate;
@synthesize jsonString= _jsonString;
@synthesize requestDidFinishSelector = _requestDidFinishSelector;
@synthesize requestDidFailedSelector = _requestDidFailedSelector; 
@synthesize request = _request ; 
@synthesize url = _url ;
@synthesize data = _data;
@synthesize secondsToCache = _secondsToCache ;
@synthesize encoding = _encoding;
@synthesize isSyc;


- (id)init {     
    self = [super init];
    if (self) { 
        self.isSyc = NO;
        self.jsonString = nil;
        self.data = nil ;
        self.requestDidFailedSelector = @selector(requestFailed:);
        self.requestDidFinishSelector = @selector(requestFinished:);
        self.encoding = kCFStringEncodingUTF8 ;
		return self;  
    }
	return nil;
}


- (void)dealloc {
    NSLog(@"==%s",__FUNCTION__);
    _request.delegate = nil;
    [_request clearDelegatesAndCancel]; 
    [_jsonString release];  
    [_data release];
    [_request release];
    
	[super dealloc];
}


- (void) load:(NSString*)url { 
    NSLog(@"%@",url);
    [self retain];
	self.url = url ;
    self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    //self.request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [ASIHTTPRequest setDefaultTimeOutSeconds:5];
    if (_secondsToCache > 0 ) {
        [_request setDownloadCache: [ASIDownloadCache sharedCache]] ;  
        [_request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy]; 
        [_request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy]; 
        [_request setSecondsToCache:_secondsToCache]; // Cache for 30 days
    }
    
    
    [_request setDelegate:self];
    [_request setNumberOfTimesToRetryOnTimeout:3];
    [_request setDidFinishSelector:@selector(requestFinished:)];
    [_request setDidFailSelector:@selector(requestFailed:)];
    if(isSyc)
        [_request startSynchronous];
    else
        [_request startAsynchronous]; 
        
}


- (void) requestFinished:(ASIHTTPRequest *)request {  
    self.url = [NSString stringWithFormat:@"%@",request.url]; //这一句在后面才能拿到正确的url
    if ( [request didUseCachedResponse] ){
        NSLog(@"request didUseCachedResponse");
    }
	NSData *data =  [NSData dataWithData:[request responseData]]; 	
	if (data) 
	{
        self.data = [NSData dataWithData:data];  
		NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (_encoding);
		self.jsonString = [[[NSString alloc] initWithData:data encoding:enc]autorelease]; 
        
		if (self.delegate->isa!=NULL&&self.delegate && self.requestDidFinishSelector && [self.delegate respondsToSelector:self.requestDidFinishSelector]) {  
			[self.delegate performSelectorOnMainThread:self.requestDidFinishSelector withObject:self waitUntilDone:YES];
		}   
	}
    [self release];
}


- (void) requestFailed:(ASIHTTPRequest *)request { 
	if (self.delegate && self.requestDidFailedSelector && [self.delegate respondsToSelector:self.requestDidFailedSelector]) {
		[self.delegate performSelectorOnMainThread:self.requestDidFailedSelector withObject:self waitUntilDone:YES];
	}     
    [self release];
}
 

@end
