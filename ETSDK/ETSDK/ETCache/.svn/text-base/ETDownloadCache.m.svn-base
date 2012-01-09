//
//  ETDownloadCache.m
//  ETSDK
//
//  Created by GuanYuhong on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETDownloadCache.h"

@implementation ETDownloadCache

@synthesize name = _name ;
@synthesize storagePath = _storagePath;
@synthesize accessLock = _accessLock ;

static ETDownloadCache *sharedCache = nil; 

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
    [_name release];
    [_storagePath release];
	[_accessLock release];
    [super dealloc];
}

- (id) initWithName:(NSString*) name {
    self = [super init];
    if (self) {  
        [self setAccessLock:[[[NSRecursiveLock alloc] init] autorelease]];
        [self setStoragePath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:name]];
        
        [[self accessLock] lock];
        
        NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
        BOOL isDirectory = NO;
        BOOL exists = [fileManager fileExistsAtPath:_storagePath isDirectory:&isDirectory];
        if (exists && !isDirectory) {
            [[self accessLock] unlock];
            [NSException raise:@"FileExistsAtCachePath" format:@"Cannot create a directory for the cache at '%@', because a file already exists",_storagePath];
        } else if (!exists) {
            [fileManager createDirectoryAtPath:_storagePath withIntermediateDirectories:NO attributes:nil error:nil];
            if (![fileManager fileExistsAtPath:_storagePath]) {
                [[self accessLock] unlock];
                [NSException raise:@"FailedToCreateCacheDirectory" format:@"Failed to create a directory for the cache at '%@'",_storagePath];
            }
        }
        
        [[self accessLock] unlock];
        
        self.name = name;
		return self;  
    }
	return nil;
}

- (void)cacheObject:(NSData*)data forKey:(NSString*)key maxAge:(NSUInteger)age{
    [[self accessLock] lock];  
    
    NSString *keycode = [NSString stringWithFormat:@"%d",[key hash]]; 
    
    NSString *headerPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cachedheaders"];
    NSString *dataPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cacheddatas"];
    

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]; 
    NSString *nowStr = [NSString stringWithFormat:@"%f",now]; 
    NSString *ageStr = [NSString stringWithFormat:@"%d",age]; 
    NSDictionary *heads = [NSDictionary dictionaryWithObjectsAndKeys:nowStr,@"save",ageStr,@"age", nil];
    
	[heads writeToFile:headerPath atomically:NO];
     
	if ( data != nil) {
		[data writeToFile:dataPath atomically:NO];
	}  
	
    [[self accessLock] unlock];
    
}

- (NSData*) objectForKey:(NSString*)key {
    [[self accessLock] lock];
	if (![self storagePath]) {
		[[self accessLock] unlock];
		return nil;
	} 
    
    NSString *keycode = [NSString stringWithFormat:@"%d",[key hash]]; 
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    
    NSString *headerPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cachedheaders"];
     
	BOOL exists = [fileManager fileExistsAtPath:headerPath ];
	if (!exists ) {
		[[self accessLock] unlock];
		return nil;
	}
    
    NSDictionary *head = [NSDictionary dictionaryWithContentsOfFile:headerPath];
    
    double saveTime = [[head objectForKey:@"save"]doubleValue];
    int age =  [[head objectForKey:@"age"]intValue];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]; 
    // out of day
    if (age != -1 && now - saveTime > age) { 
        NSString *dataPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cacheddatas"];
        [fileManager removeItemAtPath:headerPath error:NULL];
        [fileManager removeItemAtPath:dataPath error:NULL];
        [[self accessLock] unlock];
		return nil;
    }
    NSString *dataPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cacheddatas"];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
	[[self accessLock] unlock];     
    return data;
    
}
- (void)removeObjectforKey:(NSString*)key {
    [[self accessLock] lock];
	if (![self storagePath]) {
		[[self accessLock] unlock];
		return;
	}
    NSString *keycode = [NSString stringWithFormat:@"%d",[key hash]]; 
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    
    NSString *headerPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cachedheaders"];
    NSString *dataPath = [[_storagePath stringByAppendingPathComponent:keycode ] stringByAppendingPathExtension:@"cacheddatas"];

    [fileManager removeItemAtPath:headerPath error:NULL];
    [fileManager removeItemAtPath:dataPath error:NULL];
	
    [[self accessLock] unlock];
}

- (void)removeAllforKeys{
    [[self accessLock] lock];
	if (![self storagePath]) {
		[[self accessLock] unlock];
		return;
	} 
    
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    
	BOOL isDirectory = NO;
	BOOL exists = [fileManager fileExistsAtPath:_storagePath isDirectory:&isDirectory];
	if (!exists || !isDirectory) {
		[[self accessLock] unlock];
		return;
	}
	NSError *error = nil;
	NSArray *cacheFiles = [fileManager contentsOfDirectoryAtPath:_storagePath error:&error];
	if (error) {
		[[self accessLock] unlock];
		[NSException raise:@"FailedToTraverseCacheDirectory" format:@"Listing cache directory failed at path '%@'",_storagePath];	
	}
	for (NSString *file in cacheFiles) {
		[fileManager removeItemAtPath:[_storagePath stringByAppendingPathComponent:file] error:&error];
		if (error) {
			[[self accessLock] unlock];
			[NSException raise:@"FailedToRemoveCacheFile" format:@"Failed to remove cached data at path '%@'",_storagePath];
		}
	}
	[[self accessLock] unlock];
}


- (void)removeObjectsOutOfDate{
    [[self accessLock] lock]; 
    // to do list
	[[self accessLock] unlock];
}

@end
