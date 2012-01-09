//
//  ETLoadingCache.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETLoadingCache.h"

@implementation ETLoadingCache
@synthesize map = _map;

static ETLoadingCache *sharedCache = nil; 

+ (ETLoadingCache*)sharedCache
{
	if (!sharedCache) {
		@synchronized(self) {
			if (!sharedCache) {
				sharedCache = [[self alloc] initWithName:@"ETLoadingCache"]; 
			}
		}
	}
	return sharedCache;
}

+ (void)checkForRelease{
    if( sharedCache !=nil){
        if ( [sharedCache.map count] == 0){
            [sharedCache release];
            sharedCache = nil;
        }
    }
}

- (id) initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        // default is 100
        _map = [[NSMutableDictionary alloc]initWithCapacity:100];
    }
    return self;
}

@end
