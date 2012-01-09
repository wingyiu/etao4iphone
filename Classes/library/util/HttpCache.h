//
//  HttpCache.h
//  SmartBook
//
//  Created by iTeam on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpCache : NSObject {
    
    NSMutableDictionary *_map;
    NSMutableArray      *_keys;
}

+ (HttpCache *)sharedCache; 

- (void)cacheObject:(id)obj forKey:(id)key;

- (id)objectForKey:(id)key;

- (NSArray *)allKeys;

- (void)removeAllObjects;
  
@property (nonatomic,retain) NSMutableDictionary *map;
@property (nonatomic,retain) NSMutableArray *keys;


@end
