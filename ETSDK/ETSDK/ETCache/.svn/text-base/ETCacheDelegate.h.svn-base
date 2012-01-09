//
//  ETCacheDelegate.h
//  ETSDK
//
//  Created by GuanYuhong on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETCacheDelegate <NSObject>

@required

- (id) initWithName:(NSString*) name ;

// age is second , when -1 is forever
- (void)cacheObject:(NSData*)data forKey:(NSString*)key maxAge:(NSUInteger)age;

- (NSData*) objectForKey:(NSString*)key ;

- (void)removeObjectforKey:(NSString*)key ;

- (void)removeAllObjects;

// to do 
- (void)removeObjectsOutOfDate ;

@end
