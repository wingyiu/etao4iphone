//
//  MyClass.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchEvaluateSession.h"
#import "NSObject+SBJson.h"

@interface SearchEvaluateSession()
    - (void) requestDateByDictionary:(NSDictionary*)dictionary;
@end

@implementation SearchEvaluateSession

@synthesize urlprefix = _urlprefix;
@synthesize sessionDelegate = _sessionDelegate;
@synthesize searchEvaluateProtocal = _searchEvaluateProtocal;

@synthesize dictParam = _dictParam ;

- (id)init {
    self = [super init];
    if (self) {
        //
        self.dictParam = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return self;
}


- (NSString *)_dictToQueryString:(NSDictionary *)dict {
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:[[dict allKeys] count]];
    
    for (NSString *key in [dict keyEnumerator]) {
        NSObject *val = [dict objectForKey:key];
        NSString *paramVal;
        
        if ([val isKindOfClass:[NSString class]]) {
            paramVal = (NSString *)val;
        } else {
            paramVal = [val JSONRepresentation];
        }
        
        [dataArr addObject:[NSString stringWithFormat:@"\"%@\":\"%@\"",
                            [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                            [[paramVal stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]
                            ]];
    }
    
    return [dataArr componentsJoinedByString:@","];
}


- (void) loadMoreFrom:(int)start count:(int)end {
	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	//api=com.taobao.wap.rest2.etao.search&v=*&data=%20{"q":"nokia","s":0,"n":5}
    
	[httpquery addParam:@"com.taobao.wap.rest2.etao.comment.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	[dict setValue:[NSNumber numberWithInt:start] forKey:@"s"];
	[dict setValue:[NSNumber numberWithInt:end] forKey:@"n"];
	
	// add by zhangsuntai for log ;just kid 
	NSString *loginfo = [NSString stringWithFormat:@"%@;comment;search",[UIDevice currentDevice].uniqueIdentifier];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
	NSLog(@"%@",[dict JSONRepresentation]);
    
    [dict addEntriesFromDictionary:_dictParam];
      
	
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"];
    
	[httpquery start]; 
}


- (void) requestFinished:(HttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _searchEvaluateProtocal) {
        _searchEvaluateProtocal = [[SearchEvaluateProtocol alloc] init];
    }
    
    [_searchEvaluateProtocal setItemsByJSON:request.jsonString];
    
    [_sessionDelegate SearchEvaluateRequestDidFinish:nil];
}


- (void)requestEvaluateDetailDate {
    if (_dictParam) {
        [self requestDateByDictionary:_dictParam];
    }
}


- (void) requestDateByDictionary:(NSDictionary*)dictionary {
    EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	//api=com.taobao.wap.rest2.etao.search&v=*&data=%20{"q":"nokia","s":0,"n":5}
    
	[httpquery addParam:@"com.taobao.wap.rest2.etao.comment.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	//[dict setValue:@"me722" forKey:@"q"];
	[dict setValue:[NSNumber numberWithInt:0] forKey:@"s"];
	[dict setValue:[NSNumber numberWithInt:10] forKey:@"n"];
	
	// add by zhangsuntai for log ;just kid 
	NSString *loginfo = [NSString stringWithFormat:@"%@;comment;search",[UIDevice currentDevice].uniqueIdentifier];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
    [dict addEntriesFromDictionary:dictionary];
    
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 
	
	[httpquery start];    
}


- (void) SetRequestDateSource:(NSString *)requestStr {
    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _searchEvaluateProtocal) {
        _searchEvaluateProtocal = [[SearchEvaluateProtocol alloc] init];
    }
    
    [_searchEvaluateProtocal setItemsByJSON:requestStr];
	
    [_sessionDelegate SearchEvaluateRequestDidFinish:nil];
}


- (void) requestFailed:(HttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);
    
    [_sessionDelegate SearchEvaluateRequestDidFailed:request];
}


- (void) dealloc {
    
    [_searchEvaluateProtocal release];
    //[_httpRequest release];
    //[_dictParam release];
    //[_jsonStrin release];
    
    [super dealloc];
}

@end
