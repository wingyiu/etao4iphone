//
//  TBMemoryCache.h
//  taobao4iphone
//
//  Created by Xu Jiwei on 10-6-12.
//  Copyright 2010 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TBMemoryCache : NSObject <NSCoding> {
    NSUInteger          cacheCapacity;
    NSString            *name;
    BOOL                dataSaveToDisk;
    
    NSMutableDictionary *map;
    NSMutableArray      *keys;
}

+ (TBMemoryCache *)sharedCache;
+ (TBMemoryCache *)sharedImageCache;
+ (TBMemoryCache *)sharedLargeImageCache;
+ (TBMemoryCache *)memoryCacheFromArchivedFile:(NSString *)path;

+ (TBMemoryCache *)cacheWithName:(NSString *)name;

- (id)initWithCapacity:(NSUInteger)capacity;

- (void)cacheObject:(id)obj forKey:(id)key;
- (id)objectForKey:(id)key;
- (NSArray *)allKeys;
- (void)removeAllObjects;

- (void)setCapacity:(NSUInteger)capacity;

- (BOOL)saveToFile:(NSString *)path;
- (BOOL)save;

@property (nonatomic, copy)    NSString            *name;
@property (nonatomic, assign)  BOOL                dataSaveToDisk;


@end
