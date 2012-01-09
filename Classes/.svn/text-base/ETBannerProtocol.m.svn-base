//
//  ETBannerProtocol.m
//  etao4iphone
//
//  Created by 稳 张 on 11-12-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETBannerProtocol.h"
#import "ETBannerItem.h"
#import "NSObject+SBJson.h"

@implementation ETBannerProtocol

@synthesize bannerArray = _bannerArray;
@synthesize bannerCount;


- (id) init {
	self = [super init];
    if (self) { 
        
        if(nil == _bannerArray) {
            _bannerArray = [[NSMutableArray alloc]init];
        }
	}
    return self; 
}


- (NSUInteger)count {
	return [_bannerArray count];
}


- (id)objectAtIndex:(NSUInteger)index{
	return [_bannerArray objectAtIndex:index];
}


- (void)addItemsByJSON:(NSString*)json {
	NSDictionary *jsonValue = [json JSONValue]; 
    
    NSLog(@"%@", json);
    
    if (jsonValue != nil) { 
        
        bannerCount = [[jsonValue objectForKey:@"count"] intValue];
        NSDictionary *evaluates = [jsonValue objectForKey:@"item"];

        /*
         @synthesize type;
         @synthesize backImgUrl;
         @synthesize bannerTitle;
         @synthesize url;
         @synthesize cat;
         @synthesize seller;
         @synthesize q;
         @synthesize test;
         
         imgurl: "http://img03.taobaocdn.com/tps/i3/T1P8KJXixdXXXXXXXX-300-95.jpg",
         title: "man的狂欢",
         url: "",
         cat: "50080024",
         epid: "",
         seller: "",
         q: "man的狂欢",
         type: "2",
         test: "1"
         */
        
		for (NSDictionary *item in evaluates) { 
            ETBannerItem *bannerItem = [ETBannerItem alloc];

            bannerItem.type = [[item objectForKey:@"type"] intValue];
			bannerItem.backImgUrl = [item objectForKey:@"imgurl"];
            bannerItem.bannerTitle = [item objectForKey:@"title"];
            bannerItem.url = [item objectForKey:@"url"];
            bannerItem.cat = [item objectForKey:@"cat"];
            bannerItem.epid = [item objectForKey:@"epid"];
            bannerItem.seller = [item objectForKey:@"seller"];
            bannerItem.q = [item objectForKey:@"q"];
            bannerItem.test = [item objectForKey:@"test"];
            
            [_bannerArray addObject:bannerItem];
            [bannerItem release];
		}
    }
}


- (void)setItemsByJSON:(NSString*)json {
    
    NSLog(@"%@",json);
    
	[_bannerArray removeAllObjects];
	[self addItemsByJSON:json];
}


- (void) dealloc {
    
    
    [_bannerArray release];
    [super dealloc];
}


@end

