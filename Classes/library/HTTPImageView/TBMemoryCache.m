//
//  TBMemoryCache.m
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-6-12.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import "TBMemoryCache.h"

#import "NSData+MD5.h"


@implementation TBMemoryCache

@synthesize name;
@synthesize dataSaveToDisk;

static NSMutableDictionary *cacheMap = nil;

+ (void)initialize {
    if (self == [TBMemoryCache class]) {
        cacheMap = [[NSMutableDictionary alloc] init];
    }
}


+ (TBMemoryCache *)sharedCache {
    static TBMemoryCache *cache = nil;
    
    if (cache == nil) {
        cache = [[TBMemoryCache alloc] initWithCapacity:100];
    }
    
    return cache;
}

+ (TBMemoryCache *)sharedImageCache {
    static TBMemoryCache *cache = nil;
    
    if (cache == nil) {
        cache = [[TBMemoryCache alloc] initWithCapacity:100];
    }
    
    return cache;
}

+ (TBMemoryCache *)sharedLargeImageCache {
    static TBMemoryCache *cache = nil;
    
    if (cache == nil) {
        cache = [[TBMemoryCache alloc] initWithCapacity:10];
    }
    
    return cache;
}


+ (NSString *)cacheFilePathForName:(NSString *)name {
    NSString *cacheFile = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                            stringByAppendingPathComponent:@"Caches"]
                           stringByAppendingPathComponent:[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return cacheFile;
}


+ (NSString *)cacheDataFilePathForName:(NSString *)name fileName:(NSString *)fileName {
    NSString *path = [[[self cacheFilePathForName:name] stringByAppendingString:@"_files"]
                      stringByAppendingPathComponent:[[fileName dataUsingEncoding:NSUTF8StringEncoding] md5HashString]];
    return path;
}


+ (TBMemoryCache *)cacheWithName:(NSString *)name {
    return [[[[self class] alloc] initWithName:name] autorelease];
}


- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveCache:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveCache:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}


- (id)init {
    if ((self = [super init])) {
        cacheCapacity = 100;
        
        map = [[NSMutableDictionary alloc] init];
        keys = [[NSMutableArray alloc] init];
        
        [self addNotificationObserver];
    }
    
    // Clean unused cache
    for (NSString *key in [cacheMap allKeys]) {
        NSObject *obj = [cacheMap objectForKey:key];
        if ([obj retainCount] == 1) {
            [cacheMap removeObjectForKey:key];
        }
    }
    
    return self;
}


- (id)initWithName:(NSString *)cacheName {
    TBMemoryCache *cache = [[cacheMap objectForKey:cacheName] retain];
    if (!cache) {
        cache = [[TBMemoryCache memoryCacheFromArchivedFile:[TBMemoryCache cacheFilePathForName:cacheName]] retain];
    }
    
    if (cache) {
        [self release];
        self = cache;
    } else {
        self = [self initWithCapacity:100];
    }
    
    self.name = cacheName;
    [cacheMap setObject:self forKey:cacheName];
    
    return self;
}


- (id)initWithCapacity:(NSUInteger)capacity {
    if ((self = [self init])) {
        cacheCapacity = capacity;
    }
    
    return self;
}

- (id)objectForKey:(id)key {
    if (self.dataSaveToDisk) {
        id obj = nil;
        @try {
            obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[TBMemoryCache cacheDataFilePathForName:self.name fileName:key]];
        } @catch (NSException *e) {
            // do nothing
        }
        
        return obj;
    }
    
    return [map objectForKey:key];
}


- (void)removeObjectForKey:(id)key {
    [map removeObjectForKey:key];
    if (self.dataSaveToDisk) {
        NSError *err = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[TBMemoryCache cacheDataFilePathForName:self.name fileName:key]
                                                   error:&err];
    }
}


- (void)cacheObject:(id)obj forKey:(id)key {
    if (key == nil || obj == nil) {
        NSLog(@"WARNING: Insert nil key or object to memory cache");
        return;
    }
    
    if ([map objectForKey:key] != nil) {
        [self removeObjectForKey:key];
		NSUInteger index = [keys indexOfObject:key];
		[keys removeObjectAtIndex:index];
    }
    
    if (self.dataSaveToDisk) {
        NSString *path = [TBMemoryCache cacheDataFilePathForName:self.name fileName:key];
        NSString *dir = [path stringByDeletingLastPathComponent];
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES
                                                   attributes:nil error:NULL];
        [NSKeyedArchiver archiveRootObject:obj toFile:path];
        obj = @"";
    }
    
    [map setObject:obj forKey:key];
    [keys addObject:key];
    
    if ([keys count] > cacheCapacity) {
        key = [keys objectAtIndex:0];
        [self removeObjectForKey:key];
        //[map removeObjectForKey:key];
        [keys removeObjectAtIndex:0];
    }
}


- (void)removeAllObjects {
    for (NSString *key in keys) {
        [self removeObjectForKey:key];
    }
    
    [keys removeAllObjects];
}


- (NSArray *)allKeys {
    return [[keys copy] autorelease];
}


- (void)setCapacity:(NSUInteger)capacity {
    if (capacity < cacheCapacity) {
        int count = [keys count] - capacity;
        while (count > 0) {
            [self removeObjectForKey:[keys objectAtIndex:0]];
            [keys removeObjectAtIndex:0];
			count--;
        }
    }
    
    cacheCapacity = capacity;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        [self addNotificationObserver];
        
        TB_RELEASE(keys);
        TB_RELEASE(map);
        
        if ([aDecoder allowsKeyedCoding]) {
            cacheCapacity = [[aDecoder decodeObjectForKey:@"cacheCapacity"] intValue];
            keys = [[aDecoder decodeObjectForKey:@"keys"] mutableCopy];
            map = [[aDecoder decodeObjectForKey:@"maps"] mutableCopy];
            self.name = [aDecoder decodeObjectForKey:@"name"];
            self.dataSaveToDisk = [[aDecoder decodeObjectForKey:@"dataSaveToDisk"] boolValue];
        } else {
            cacheCapacity = [[aDecoder decodeObject] intValue];
            keys = [[aDecoder decodeObject] mutableCopy];
            map = [[aDecoder decodeObject] mutableCopy];
            self.name = [aDecoder decodeObject];
            self.dataSaveToDisk = [[aDecoder decodeObject] boolValue];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if ([aCoder allowsKeyedCoding]) {
        [aCoder encodeObject:[NSNumber numberWithInt:cacheCapacity] forKey:@"cacheCapacity"];
        [aCoder encodeObject:keys forKey:@"keys"];
        [aCoder encodeObject:map forKey:@"maps"];
        [aCoder encodeObject:name forKey:@"name"];
        [aCoder encodeObject:[NSNumber numberWithBool:dataSaveToDisk] forKey:@"dataSaveToDisk"];
    } else {
        [aCoder encodeObject:[NSNumber numberWithInt:cacheCapacity]];
        [aCoder encodeObject:keys];
        [aCoder encodeObject:map];
        [aCoder encodeObject:name];
        [aCoder encodeObject:[NSNumber numberWithBool:dataSaveToDisk]];
    }
}

+ (TBMemoryCache *)memoryCacheFromArchivedFile:(NSString *)path {
    TBMemoryCache *ret = nil;
    @try {
        ret = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } @catch (NSException *e) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    } @finally {
        return ret;
    }
}

- (BOOL)saveToFile:(NSString *)path {
    NSString *dir = [path stringByDeletingLastPathComponent];
    [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES
                                               attributes:nil error:NULL];
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:path];
    NSLog(@"Archive TBMemoryCache to %@ %@", path, success ? @"successed" : @"failed");
    return success;
}


- (BOOL)save {
    if ([self.name length] > 0) {
        NSString *path = [TBMemoryCache cacheFilePathForName:self.name];
        return [self saveToFile:path];
    }
    
    return NO;
}


- (void)saveCache:(NSNotification *)note {
    [self save];
}

#pragma mark -

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self save];
    
    TB_RELEASE(map);
    TB_RELEASE(keys);
    
    self.name = nil;
    
    [super dealloc];
}


@end
