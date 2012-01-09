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

@class EtaoHttpRequest;
@protocol EtaoHttpRequstDelegate <NSObject>

@optional
- (void) requestFinished:(EtaoHttpRequest *)request ;
- (void) requestFailed:(EtaoHttpRequest *)request ;

@end


#import "ASIHTTPRequest.h"

@interface EtaoHttpRequest : NSObject {
	
	id _delegate;
	SEL _requestDidFinishSelector;
	SEL _requestDidFailedSelector;
	
    ASIHTTPRequest* _request ;
	NSString *_jsonString;
    NSData *_data ;
    NSString * _url ;
    
    int _secondsToCache;
    NSStringEncoding _encoding ;
    
    BOOL isSyc;
	
} 

@property (nonatomic, retain) id delegate; 
@property (nonatomic, assign) SEL requestDidFinishSelector;
@property (nonatomic, assign) SEL requestDidFailedSelector;  
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSString *jsonString; 
@property (nonatomic, retain) NSString *url; 
@property (nonatomic, retain) ASIHTTPRequest* request ;
@property (nonatomic, assign) BOOL isSyc;

@property (assign) int secondsToCache;
@property (assign) NSStringEncoding encoding ;

- (id) init; 
- (void) load:(NSString*)url;
- (void) requestFinished:(ASIHTTPRequest *)request ;
- (void) requestFailed:(ASIHTTPRequest *)request ;


@end
