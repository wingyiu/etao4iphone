//
//  ETMemoryCache.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETCacheDelegate.h"

@interface ETMemoryCache : NSObject<ETCacheDelegate> {
    NSUInteger          _cacheCapacity; 
    
}
 
@property (nonatomic,retain) NSMutableDictionary *map;


+ (id)sharedCache;


@end
