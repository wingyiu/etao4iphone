//
//  ETMemoryCache.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETMemoryCache.h"

@implementation ETMemoryCache
@synthesize map = _map;
static ETMemoryCache *sharedCache = nil; 

+ (id)sharedCache
{
	if (!sharedCache) {
		@synchronized(self) {
			if (!sharedCache) {
				sharedCache = [[self alloc] initWithName:@"ETDownloadCache"]; 
			}
		}
	}
	return sharedCache;
}


- (void) dealloc {  
    [super dealloc];
}

- (id) initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        // default is 100
        _cacheCapacity = 100 ;
        self.map = [NSMutableDictionary dictionaryWithCapacity:_cacheCapacity];
    }
    return self;
}

// age is second , when -1 is forever
- (void)cacheObject:(NSData*)data forKey:(NSString*)key maxAge:(NSUInteger)age{    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];  
    NSArray *val = [NSArray arrayWithObjects:[NSNumber numberWithInt:age], [NSNumber numberWithDouble:now], data,nil];
    [_map setObject:val forKey:key];
}

- (NSData*) objectForKey:(NSString*)key {
    NSArray *val = [_map objectForKey:key];
    
    if (val == nil) {
        return nil ;
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
     
    int age  = [[val objectAtIndex:0] intValue];
    double save = [[val objectAtIndex:1] doubleValue];
    if (age != -1 && now - save > age) { 
        [_map removeObjectForKey:key];
        return nil;
    }
    return [val objectAtIndex:2];

}

- (void)removeObjectforKey:(NSString*)key {
    [_map removeObjectForKey:key];
}

- (void)removeAllObjects{
    [_map removeAllObjects];
}

// to do 
- (void)removeObjectsOutOfDate {
    
}


@end
