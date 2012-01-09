//
//  HttpRequest.m
//  etao4iphone
//
//  Created by iTeam on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest.h"
#import "EtaoSystemInfo.h"

@implementation HttpRequest


@synthesize delegate;
@synthesize jsonString= _jsonString;
@synthesize requestDidFinishSelector;
@synthesize requestDidFailedSelector; 
@synthesize _loading ,_url;
@synthesize data = _data;
@synthesize cache = _cache ;
- (id)init {
	self.jsonString = nil;
    self.data = nil ;
    self.cache = NO ;
    self = [super init];
    if (self) { 
		return self;  
    }
	return nil;
}


- (void) load:(NSString*)url { 
	self._url = url ;
    _loading = YES; 
    
    [self retain];
    
	HttpCache *cache = [HttpCache sharedCache];
	NSData* data = [cache objectForKey:url];
	if (data != nil &&  _cache) {
		NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
		self.jsonString = [[[NSString alloc] initWithData:data encoding:enc]autorelease];
        self.data = [NSData dataWithData:data];         
		if (self.delegate && self.requestDidFinishSelector && [delegate respondsToSelector:self.requestDidFinishSelector]) {
 			[delegate performSelectorOnMainThread:self.requestDidFinishSelector withObject:self waitUntilDone:YES];
 		}
	}
	else {
		ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
		[ASIHTTPRequest setDefaultTimeOutSeconds:5];
		//if ( [ASIHTTPRequest isNetworkInUse ]) {
		//	[self requestFailed:request];
		//	return ;
		//}
		[request setDelegate:self]; 		
		[request setDidFinishSelector:@selector(requestFinished:)];
		[request setDidFailSelector:@selector(requestFailed:)];
        [request setNumberOfTimesToRetryOnTimeout:3];
        [request setTimeOutSeconds:20];
		[request startAsynchronous]; 
		//是否显示网络请求信息在status bar上：
		//[ ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO ]; 
	} 
}


- (void) requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"HttpRequest requestFinished");
	_loading = NO;
	NSLog(@"self=%d",[self retainCount]);
	NSData *data =  [NSData dataWithData:[request responseData]]; 	
	if (data) 
	{
        self.data = [NSData dataWithData:data]; 
		//[NSThread sleepForTimeInterval:10];
		NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
		self.jsonString = [[[NSString alloc] initWithData:data encoding:enc]autorelease]; 
        if (_cache) {
            HttpCache *cache = [HttpCache sharedCache]; 
            [cache cacheObject:data forKey:[request.url absoluteString]];
        }
        
		if (self.delegate && self.requestDidFinishSelector && [delegate respondsToSelector:self.requestDidFinishSelector]) { 
			NSLog(@"HttpRequest call");
            self._url = [NSString stringWithFormat:@"%@",request.url];
			[delegate performSelectorOnMainThread:self.requestDidFinishSelector withObject:self waitUntilDone:YES];
		}   
		else {
			NSLog(@"HttpRequest lose");
		}
	}    
	
	[self release];  
}


- (void) requestFailed:(ASIHTTPRequest *)request {
	_loading = NO;
	if (self.delegate && self.requestDidFailedSelector && [delegate respondsToSelector:self.requestDidFailedSelector]) {
		[delegate performSelectorOnMainThread:self.requestDidFailedSelector withObject:self waitUntilDone:YES];
	}   
	[self release];  
}


- (void)dealloc {  
	NSLog(@"HttpRequest release %@",_url);
    if(_url!=nil){
        [_url release];
    }
	if (_jsonString!= nil) {
		[_jsonString release]; 
	} 
    if (_data != nil) {
        [_data release];
    } 
	[super dealloc];
}


@end

