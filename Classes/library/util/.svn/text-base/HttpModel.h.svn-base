//
//  HttpModel.h
//  TFunny
//
//  Created by iTeam on 11-7-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCache.h"
#import "ASIHTTPRequest.h"

@interface HttpModel : NSObject {
 
	id delegate;
	SEL requestDidFinishSelector;
	SEL requestDidFailedSelector;
	
	ASIHTTPRequest *request;
	
	NSString *jsonString;
	
	NSData * responeData ;
	
} 

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL requestDidFinishSelector;
@property (nonatomic, assign) SEL requestDidFailedSelector; 
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) NSString *jsonString;
@property (nonatomic, retain) NSData * responeData ;

- (id)init; 
- (void) load:(NSString*)url;
- (void) requestFinished:(ASIHTTPRequest *)request ;
- (void) requestFailed:(ASIHTTPRequest *)request ;



@end
