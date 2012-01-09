//
//  HttpRequest.m
//  testASIhttp
//
//  Created by GuanYuhong on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETHttpRequest.h"
#import "ASIDataDecompressor.h"
#import "ETMemoryCache.h"
@implementation ETHttpRequest


@synthesize delegate = _delegate;
@synthesize jsonString= _jsonString; 
@synthesize request = _request ; 
@synthesize url = _url ;
@synthesize data = _data;
@synthesize maxConcurrentOperationCount;
@synthesize secondsToCache = _secondsToCache ;
@synthesize didUseCachedResponse ;
@synthesize encoding = _encoding;
@synthesize isSyc;
@synthesize contentLength,currentLength;

- (id)init {     
    self = [super init];
    if (self) { 
        self.isSyc = NO;
        self.jsonString = nil;
        self.data = nil ; 
        self.secondsToCache = -1 ; 
        self.encoding = kCFStringEncodingUTF8 ;
        self.contentLength = 1 ;
        self.currentLength = 0 ;
		return self;  
    }
	return nil;
}


- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    if (_request != nil) {
        [_request cancel];
        [_request clearDelegatesAndCancel];
        self.request = nil ; 
    }

    [_jsonString release];  
    [_data release];
    [_request release];
    [_url release];
    
	[super dealloc];
}

-(void) cancel {
    [_request cancel];
    [_request clearDelegatesAndCancel]; 
}


- (void) load:(NSString*)url { 
    NSLog(@"ETHttpRequest load %@",url); 
	self.url = url ;
    self.data = [NSMutableData dataWithCapacity:128]; 
    ETMemoryCache *cache = [ETMemoryCache sharedCache];
    NSData* data = [cache objectForKey:url];    
    if (data == nil) { 
        self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]]; 
        [ASIHTTPRequest setDefaultTimeOutSeconds:5];     
        [_request setDelegate:self]; 
        [_request setDidFinishSelector:@selector(requestFinished:)];
        [_request setDidFailSelector:@selector(requestFailed:)];
       // [_request setResponseEncoding:_encoding];
        if(isSyc)
            [_request startSynchronous];
        else
            [_request startAsynchronous]; 
    }
    else
    {
        self.didUseCachedResponse = YES; 
        [_data setData:data]; 
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (_encoding);
        self.jsonString = [[[NSString alloc] initWithData:_data encoding:enc]autorelease]; 
        SEL sel = @selector(requestFinished:);
        if (self.delegate && [self.delegate respondsToSelector:sel]) {  
            [self.delegate performSelector:sel withObject:self ];
        }  
        
    }
        
}

# pragma requestFinished when http fail
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    NSLog(@"%@",responseHeaders);
    self.contentLength = [[responseHeaders objectForKey:@"Content-Length"] intValue];
}
 
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data{
    [_data appendData:data];
    SEL sel = @selector(request:didReceiveData:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) { 
        [self.delegate performSelector:sel withObject:self withObject:data];
    }  
    
    currentLength += [data length];
    if (contentLength > 0) {
        SEL sel = @selector(requestProgress:);
        if (self.delegate && [self.delegate respondsToSelector:sel]) { 
            [self.delegate performSelector:sel withObject:[NSNumber numberWithInt:currentLength*100/contentLength]];
        }
    } 
}
 
- (void) requestFinished:(ASIHTTPRequest *)request { 
    //self.data = [NSData dataWithData:[request responseData]];
     if ([request isResponseCompressed] && [request shouldWaitToInflateCompressedResponses]) {
        NSData *tmp = [NSData dataWithData:_data];
		[_data setData:[ASIDataDecompressor uncompressData:tmp error:NULL]];
	} 
     
   // _data = [[NSData dataWithData:[request responseData]]retain];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (_encoding);
    self.jsonString = [[[NSString alloc] initWithData:_data encoding:enc]autorelease]; 
    SEL sel = @selector(requestFinished:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {  
        [self.delegate performSelector:sel withObject:self ];
    }  
    
    if ( _secondsToCache != 0 ) {
        ETMemoryCache *cache = [ETMemoryCache sharedCache];
        [cache cacheObject:_data forKey:_url maxAge:_secondsToCache];
    } 
    
}


- (void) requestFailed:(ASIHTTPRequest *)request { 
    SEL sel = @selector(requestFailed:);
	if (self.delegate &&  [self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel withObject:self ];
        
	}      
}
 

@end
