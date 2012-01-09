//
//  UpdateAlertProtocol.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UpdateProtocol.h"
#import "NSObject+SBJson.h"

@implementation UpdateProtocol

@synthesize updateUrl = _updateUrl;
@synthesize versionDesc = _versionDesc;
@synthesize isHaveNewVersion = _isHaveNewVersion;


- (id) init {
	self = [super init];
    if (self) { 
    }
    return self; 
}


- (void)setItemsByJSON:(NSString*)json {
    
    NSDictionary *jsonValue = [json JSONValue];
    
    NSLog(@"%@", json);
    
    if (jsonValue != nil) { 
        self.isHaveNewVersion = [[[jsonValue objectForKey:@"data"]objectForKey:@"isupdate"] boolValue];
        self.updateUrl = [[jsonValue objectForKey:@"data"]objectForKey:@"url"];
        self.versionDesc = [[jsonValue objectForKey:@"data"]objectForKey:@"desc"];
    }
}


- (void) dealloc {
    [super dealloc];
}


@end
