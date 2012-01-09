//
//  EtaoCategorySession.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EtaoSRPRequest.h"
#import "EtaoCategoryProtocol.h"
#import "EtaoCategorySessionDelegate.h"

@interface EtaoCategorySession : NSObject {
    
    id<EtaoCategorySessionDelegate> _sessionDelegate;
    
    NSString *_urlprefix;
    
    EtaoCategoryProtocol* _etaoCategoryProtocal;
}

- (void)requestEtaoCategoryDate; 

- (void) requestFinished:(HttpRequest *)request;
- (void) requestFailed:(HttpRequest *)request;


@property (nonatomic, copy) NSString *urlprefix; 

@property (nonatomic, assign ) id<EtaoCategorySessionDelegate> sessionDelegate;

@property (nonatomic, retain) EtaoCategoryProtocol* etaoCategoryProtocal;

@end