//
//  EtaoCategorySession.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoCategorySession.h"
#import "NSObject+SBJson.h"


@implementation EtaoCategorySession

@synthesize urlprefix = _urlprefix;
@synthesize sessionDelegate = _sessionDelegate;
@synthesize etaoCategoryProtocal = _etaoCategoryProtocal;


- (id)init {
    self = [super init];
    if (self) {
        //
    }
    
    return self;
}

- (void)requestEtaoCategoryDate {
    
	EtaoSRPRequest *httpquery = [[[EtaoSRPRequest alloc]init]autorelease];  
	httpquery.delegate = self;
	httpquery.requestDidFinishSelector = @selector(requestFinished:);
	httpquery.requestDidFailedSelector = @selector(requestFailed:);
	
    httpquery._urlprefix = @"http://wap.etao.com/go/rgn/decider/etaocategory.html";

    [httpquery start]; 
}


- (void) requestFinished:(HttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);
    
    if(nil == _etaoCategoryProtocal) {
        _etaoCategoryProtocal = [[EtaoCategoryProtocol alloc] init];
    }
    
    [_etaoCategoryProtocal setItemsByJSON:request.jsonString];
    
    [_sessionDelegate EtaoCategoryRequestDidFinish:nil];

    //保存成功的数据，以防止下次失败时使用。
    [[NSUserDefaults standardUserDefaults] setObject:request.jsonString forKey:@"EtaoCategorySearchDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) requestFailed:(HttpRequest *)request {
    
    NSLog(@"%s",__FUNCTION__);

    //当下载失败时，读取上次存储的数据。
    NSString* catedate = [[NSUserDefaults standardUserDefaults] stringForKey:@"EtaoCategorySearchDate"];
    if(catedate != nil) {
        if(nil == _etaoCategoryProtocal) {
            _etaoCategoryProtocal = [[EtaoCategoryProtocol alloc] init];
        }
        
        [_etaoCategoryProtocal setItemsByJSON:catedate];
        
        [_sessionDelegate EtaoCategoryRequestDidFinish:nil];
        return;
    }
    
    [_sessionDelegate EtaoCategoryRequestDidFailed:request];
}


- (void) dealloc {
    
    [_etaoCategoryProtocal release];
    //[_httpRequest release];
    //[_dictParam release];
    //[_jsonStrin release];
    
    [super dealloc];
}

@end