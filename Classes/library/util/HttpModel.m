//
//  HttpModel.m
//  TFunny
//
//  Created by iTeam on 11-7-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpModel.h"


@implementation HttpModel
 

@synthesize delegate,request,jsonString,responeData;
@synthesize requestDidFinishSelector;
@synthesize requestDidFailedSelector;


- (id)init {
	
    self = [super init];
    if (self) { 
		 return self;  
    }
	return nil;
}

 


- (void) load:(NSString*)url {
	HttpCache *cache = [HttpCache sharedCache];
	NSData* data = [cache objectForKey:url];
	if (data != nil) {
		self.responeData = data;
		if (self.delegate && self.requestDidFinishSelector && [delegate respondsToSelector:self.requestDidFinishSelector]) {
 			[delegate performSelectorOnMainThread:self.requestDidFinishSelector withObject:self waitUntilDone:YES];
 		}
	}
	else {
		self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
		[ASIHTTPRequest setDefaultTimeOutSeconds:10];
		
		NSLog(@"1self=%d",[self retainCount]);
		[self.request setDelegate:self];
		
		NSLog(@"2self=%d",[self retainCount]);
		
		[self.request setDidFinishSelector:@selector(requestFinished:)];
		[self.request setDidFailSelector:@selector(requestFailed:)];
		[self.request startAsynchronous];
	} 
}
- (void) requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"requestFinished.self=%d",[self.request retainCount]);
	NSData *data = [self.request responseData]; 	
	if (data) 
	{
		NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
		jsonString = [[NSString alloc] initWithData:data encoding:enc];  		
		HttpCache *cache = [HttpCache sharedCache];
		[cache cacheObject:data forKey:self.request.url]; 
		if (self.delegate && self.requestDidFinishSelector && [delegate respondsToSelector:self.requestDidFinishSelector]) {
			[delegate performSelectorOnMainThread:self.requestDidFinishSelector withObject:nil waitUntilDone:YES];
		}
		
	}  
}
- (void) requestFailed:(ASIHTTPRequest *)request {
	
	if (self.delegate && self.requestDidFailedSelector && [delegate respondsToSelector:self.requestDidFailedSelector]) {
		[delegate performSelectorOnMainThread:self.requestDidFailedSelector withObject:self waitUntilDone:YES];
	} 
}

- (void)dealloc {
	self.delegate= nil ;
	if (self.request) { 
		[request release];
	}
	if (self.jsonString) {
		[jsonString release];
	}
	
    [super dealloc];
}


@end
