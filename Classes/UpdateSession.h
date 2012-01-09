//
//  UpdateAlertSession.h
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtaoSRPRequest.h"
#import "UpdateProtocol.h"
#import "UpdateSessionDelegate.h"

@interface UpdateSession : NSObject {
    
    id<UpdateSessionDelegate> _sessionDelegate;
    
    UpdateProtocol* _UpdateProtocal;
}

- (void)requestUpdateDate; 

- (void) requestFinished:(HttpRequest *)request;
- (void) requestFailed:(HttpRequest *)request;


@property (nonatomic, assign ) id<UpdateSessionDelegate> sessionDelegate;

@property (nonatomic, retain) UpdateProtocol* UpdateProtocal;

@end