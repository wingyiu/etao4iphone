//
//  SearchDetailSession.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchDetailSession.h"

#import "NSObject+SBJson.h"


@interface SearchDetailSession()
    - (void) requestDateByDictionary:(NSDictionary*)dictionary;
    - (void) SetRequestDateSource:(NSString *)requestStr;
@end


@implementation SearchDetailSession

@synthesize urlprefix = _urlprefix;
@synthesize sessionDelegate = _sessionDelegate;
@synthesize SearchDetailProtocal = _SearchDetailProtocal;

@synthesize jsonStrin = _jsonStrin ;
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


- (void) loadMoreFrom:(int)page count:(int)pageCount {
	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];
    httpquery.cache = NO;
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	//api=com.taobao.wap.rest2.etao.search&v=*&data=%20{"q":"nokia","s":0,"n":5}
    
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	[dict setValue:[NSNumber numberWithInt:page] forKey:@"pageNo"];
	[dict setValue:[NSNumber numberWithInt:pageCount] forKey:@"pageItemCount"];
    [dict setValue:@"detail" forKey:@"searchType"];
    
    if (_SearchDetailProtocal._offset != 0) {
        [dict setValue:[NSNumber numberWithInt:_SearchDetailProtocal._offset] forKey:@"offset"];    
    }
	
	NSLog(@"%@",[dict JSONRepresentation]);
    
    [dict addEntriesFromDictionary:_dictParam];
    
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"];
   
	[httpquery start]; 
}


- (void) updateSessionByJsonDate:(NSString*)json {
    if(nil == _SearchDetailProtocal) {
        _SearchDetailProtocal = [[SearchDetailProtocol alloc] init];
    }
    
    [_SearchDetailProtocal setItemsByJSON:json];
    
    [_dictParam setValue:_SearchDetailProtocal._ProductItem.title forKey:@"q"];
    [_dictParam setValue:_SearchDetailProtocal._ProductItem.pid forKey:@"epid"];
    
    [_sessionDelegate SearchDetailRequestDidFinish:nil];
}


- (void) requestFinished:(HttpRequest *)request {

    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _SearchDetailProtocal) {
        _SearchDetailProtocal = [[SearchDetailProtocol alloc] init];
    }
        
    [_SearchDetailProtocal setItemsByJSON:request.jsonString];

    [_sessionDelegate SearchDetailRequestDidFinish:request.jsonString];
}


- (void)requestSearchDetailDate {
    if ([_dictParam count] > 0) {
        [self requestDateByDictionary:_dictParam];
    }
    else if (_jsonStrin){
        [self SetRequestDateSource:_jsonStrin];
    }
}


- (void) requestDateByDictionary:(NSDictionary*)dictionary {
    EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
    httpquery.cache = NO;
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
	//api=com.taobao.wap.rest2.etao.search&v=*&data=%20{"q":"nokia","s":0,"n":5}
    
	[httpquery addParam:@"com.taobao.wap.rest2.etao.search" forKey:@"api"];
	[httpquery addParam:@"*" forKey:@"v"];
	
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
	//[dict setValue:@"me722" forKey:@"q"];
	[dict setValue:[NSNumber numberWithInt:0] forKey:@"pageNo"];
	[dict setValue:[NSNumber numberWithInt:10] forKey:@"pageItemCount"];
	[dict setValue:@"detail" forKey:@"searchType"];
	
	
	// add by zhangsuntai for log ;just kid 
	NSString *loginfo = [NSString stringWithFormat:@"%@;detail;search",[UIDevice currentDevice].uniqueIdentifier];
	[dict setValue:loginfo forKey:@"_app_from_"];
	
	
    [dict addEntriesFromDictionary:dictionary];
    
	NSLog(@"%@",[dict JSONRepresentation]); 	
	[httpquery addParam:[dict JSONRepresentation] forKey:@"data"]; 
	
	[httpquery start];    
}


- (void) SetRequestDateSource:(NSString *)requestStr {
    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _SearchDetailProtocal) {
        _SearchDetailProtocal = [[SearchDetailProtocol alloc] init];
    }
    
    [_dictParam setValue:_SearchDetailProtocal._ProductItem.title forKey:@"q"];
    [_dictParam setValue:_SearchDetailProtocal._ProductItem.pid forKey:@"epid"];

    [_SearchDetailProtocal setItemsByJSON:requestStr];
	
    [_sessionDelegate SearchDetailRequestDidFinish:nil];
}


- (void) requestFailed:(HttpRequest *)request {

    NSLog(@"%s",__FUNCTION__);
    
    [_sessionDelegate SearchDetailRequestDidFailed:request];
}


- (void) dealloc {
    
    //[_httpRequest release];
    //[_dictParam release];
    //[_jsonStrin release];
    
    [super dealloc];
}

@end
