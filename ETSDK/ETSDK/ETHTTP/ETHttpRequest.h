//
//  HttpRequest.h
//  testASIhttp
//
//  Created by GuanYuhong on 11-11-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"

@class ETHttpRequest;
@protocol ETHttpRequstDelegate <NSObject>

@optional
- (void) requestFinished:(ETHttpRequest *)request ;
- (void) requestFailed:(ETHttpRequest *)request ;
- (void) requestProgress:(NSNumber *)progress ;
- (void)request:(ETHttpRequest *)request didReceiveData:(NSData *)data;

@end


#import "ASIHTTPRequest.h"

@interface ETHttpRequest : NSObject <ASIHTTPRequestDelegate>{
	
	id _delegate; 
	
    ASIHTTPRequest* _request ;
	NSString *_jsonString;
    NSMutableData *_data ;
    NSString * _url ;
     
    NSStringEncoding _encoding ;
     
	
} 

@property (nonatomic, assign) id delegate;  

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *jsonString; 
@property (nonatomic, retain) NSString *url; 

@property (nonatomic, retain) ASIHTTPRequest* request ;
@property (nonatomic, assign) BOOL isSyc;
@property (assign) int maxConcurrentOperationCount;
@property (assign) NSTimeInterval secondsToCache;
@property (assign) BOOL didUseCachedResponse;
@property int contentLength ;
@property int currentLength ;
@property (assign) NSStringEncoding encoding ;

- (id) init; 
- (void) cancel;
- (void) load:(NSString*)url;
- (void) requestFinished:(ASIHTTPRequest *)request ;
- (void) requestFailed:(ASIHTTPRequest *)request ;


@end
