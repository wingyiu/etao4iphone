//
//  SearchDetailSession.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EtaoSRPRequest.h"
#import "SearchDetailProtocol.h"
#import "SearchDetailSessionDelegate.h"

@interface SearchDetailSession : NSObject {
    
    id<SearchDetailSessionDelegate> _sessionDelegate;
    
    NSString *_urlprefix;
    
    SearchDetailProtocol* _SearchDetailProtocal;
    
    NSDictionary* _dictParam;
	
	NSString* _jsonStrin;
}

- (void)requestSearchDetailDate; 
//- (void) requestDateByDictionary:(NSDictionary*)dictionary;
//- (void) SetRequestDateSource:(NSString *)requestStr;

- (void) loadMoreFrom:(int)page count:(int)pageCount;
- (void) requestFinished:(HttpRequest *)request;
- (void) requestFailed:(HttpRequest *)request;

- (void) updateSessionByJsonDate:(NSString*)json;


@property (nonatomic, copy) NSString *urlprefix; 
@property (nonatomic, assign ) id<SearchDetailSessionDelegate> sessionDelegate;

@property (nonatomic, retain) SearchDetailProtocol* SearchDetailProtocal;

@property (nonatomic, retain) NSDictionary* dictParam ;
@property (nonatomic, retain) NSString* jsonStrin ;

@end
