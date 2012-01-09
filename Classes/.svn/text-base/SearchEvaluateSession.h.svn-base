//
//  MyClass.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EtaoSRPRequest.h"
#import "SearchEvaluateProtocol.h"
#import "SearchEvaluateSessionDelegate.h"

@interface SearchEvaluateSession : NSObject {
    
    id<SearchEvaluateSessionDelegate> _sessionDelegate;
    
    NSString *_urlprefix;
    
    SearchEvaluateProtocol* _searchEvaluateProtocal;
    
    NSDictionary* _dictParam;
}

- (void)requestEvaluateDetailDate; 

- (void) loadMoreFrom:(int)start count:(int)end;
- (void) requestFinished:(HttpRequest *)request;
- (void) requestFailed:(HttpRequest *)request;


@property (nonatomic, copy) NSString *urlprefix; 

@property (nonatomic, assign ) id<SearchEvaluateSessionDelegate> sessionDelegate;

@property (nonatomic, retain) SearchEvaluateProtocol* searchEvaluateProtocal;

@property (nonatomic, retain) NSDictionary* dictParam ;

@end
