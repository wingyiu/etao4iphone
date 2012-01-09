//
//  ETHttpImage.m
//  etao4iphone
//
//  Created by taobao-hz\boyi.wb on 11-12-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETHttpImage.h"
#import "ETImageCache.h"

@implementation ETHttpImage
@synthesize imageRect;

- (void)dealloc{

//    [_accessLock release];
}

- (id)init{
    self = [super init];
    if (self) {
 //       [self setAccessLock:[[[NSRecursiveLock alloc] init] autorelease]];
    }
    return self;
}

- (void) setItem:(NSString*) url{
    
    ETImageCache *sharedCache = [ETImageCache sharedCache];
    UIImage* _mainImage = [sharedCache objectForKey:url];
    if (_mainImage == nil ) {
        ETHttpImageView *httpImage = [[ETLoadingCache sharedCache].map objectForKey:url];
        if(httpImage){

        }
        else{
            
            httpImage = [[[ETHttpImageView alloc] init]autorelease];
            httpImage.imageRect = imageRect;
            [httpImage load:url];
            [[ETLoadingCache sharedCache].map setObject:httpImage forKey:url];
        }
    }    
    else{

    }
}

@end
