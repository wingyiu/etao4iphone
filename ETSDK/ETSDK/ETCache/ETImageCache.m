//
//  ETImageCache.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETImageCache.h"

@implementation ETImageCache

@synthesize map = _map;
static ETImageCache *sharedCache = nil; 

+ (id)sharedCache
{
	if (!sharedCache) {
		@synchronized(self) {
			if (!sharedCache) {
				sharedCache = [[self alloc] initWithName:@"ETImageCache"]; 
			}
		}
	}
	return sharedCache;
}


- (void) dealloc {  
    [_key release];
    [_map release];
    [super dealloc];
}

- (id) initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        // default is 100
        _cacheCapacity = 100 ;
        _map = [[NSMutableDictionary alloc]initWithCapacity:100];
        _key = [[NSMutableArray alloc]initWithCapacity:100];
    }
    return self;
}

// age is second , when -1 is forever
- (void)cacheImage:(UIImage*)image forKey:(NSString*)key {
    
    if ([_map objectForKey:key] != nil) {
        return ;
    } 
    if ([_map count] >= _cacheCapacity ) {
        NSString *url = [_key  objectAtIndex:0];
        [_key removeObjectAtIndex:0];
        [_map removeObjectForKey:url];
        
    }
    [_map setObject:image forKey:key];
    [_key addObject:key];
}

- (UIImage*) objectForKey:(NSString*)key {
    return [_map objectForKey:key]; 
    
}
 

@end
