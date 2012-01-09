//
//  ETDownloadCache.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCacheDelegate.h"
@interface ETDownloadCache : NSObject <ETCacheDelegate>{
    
    // The directory in which cached data will be stored
	// Defaults to a directory called 'ASIHTTPRequestCache' in the temporary directory
	NSString *storagePath;
	
	// Mediates access to the cache
	NSRecursiveLock *accessLock;
    
}

@property (nonatomic,retain) NSString *name;
@property (retain, nonatomic) NSString *storagePath;
@property (retain) NSRecursiveLock *accessLock;

// 
+ (id)sharedCache;

- (id) initWithName:(NSString*) name ;

// age is second , when -1 is forever
- (void)cacheObject:(NSData*)data forKey:(NSString*)key maxAge:(NSUInteger)age;
 
- (NSData*) objectForKey:(NSString*)key ;

- (void)removeObjectforKey:(NSString*)key ;

- (void)removeAllforKeys;

// to do 
- (void)removeObjectsOutOfDate ;

@end
