//
//  HttpRequest.h
//  etao4iphone
//
//  Created by iTeam on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "HttpCache.h"
#import "ASIHTTPRequest.h"

@interface HttpRequest : NSObject {
	
	id delegate;
	SEL requestDidFinishSelector;
	SEL requestDidFailedSelector;
	
	NSString *_jsonString;
	 
    NSData *_data ;
    NSString *_url; 
    
    BOOL _cache ;
	 
	
} 

@property (nonatomic, assign) id delegate; 
@property (nonatomic, assign) SEL requestDidFinishSelector;
@property (nonatomic, assign) SEL requestDidFailedSelector; 
@property (nonatomic, assign) BOOL _loading; 
@property (nonatomic, assign) BOOL cache; 
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSString *jsonString; 
@property (nonatomic, retain) NSString *_url; 


- (id)init; 
- (void) load:(NSString*)url;
- (void) requestFinished:(ASIHTTPRequest *)request ;
- (void) requestFailed:(ASIHTTPRequest *)request ;



@end
