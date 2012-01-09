//
//  ETImageCache.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCacheDelegate.h"
@interface ETImageCache : NSObject {
    
    NSUInteger          _cacheCapacity; 
    
    NSMutableArray *_key;
    
}

@property (nonatomic,retain) NSMutableDictionary *map;


+ (id)sharedCache;


// age is second , when -1 is forever
- (void)cacheImage:(UIImage*)image forKey:(NSString*)key ;

- (UIImage*) objectForKey:(NSString*)key ;
@end
