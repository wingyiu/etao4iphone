//
//  HttpCache.m
//  SmartBook
//
//  Created by iTeam on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpCache.h"


@implementation HttpCache
  
@synthesize map = _map;
@synthesize keys = _keys ;
+ (HttpCache *)sharedCache {
    static HttpCache *cache = nil;
    
    if (cache == nil) {
        cache = [[HttpCache alloc] init];
    }
    
    return cache;
}


- (id)init {
    if ((self = [super init])) {         
        self.map = [NSMutableDictionary dictionaryWithCapacity:100];
        self.keys = [NSMutableArray arrayWithCapacity:100]; 
    }
    return self;
}

- (id)objectForKey:(id)key {
//	return nil;
    return [_map objectForKey:key];
}


- (void)removeObjectForKey:(id)key {
    [_map removeObjectForKey:key];
}


- (void)cacheObject:(id)obj forKey:(id)key {
    if (_keys == nil || obj == nil) { 
        return;
    }
    
    if ([_map objectForKey:key] != nil) {
        [self removeObjectForKey:key];
		NSUInteger index = [_keys indexOfObject:key];
		[_keys removeObjectAtIndex:index];
    }
	
    [_map setObject:obj forKey:key];
    [_keys addObject:key]; 
}


- (void)removeAllObjects {
    for (NSString *key in _keys) {
        [self removeObjectForKey:key];
    }
    
    [_keys removeAllObjects];
}


- (NSArray *)allKeys {
    return [[_keys copy] autorelease];
}
   

#pragma mark -

- (void)dealloc {
	[_keys release];
	[_map release]; 
	
    [[NSNotificationCenter defaultCenter] removeObserver:self];
         
    [super dealloc];
}

 

@end
