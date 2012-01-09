//
//  SearchDetailProtocol.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchDetailProtocol.h"
#import "NSObject+SBJson.h"

@implementation SearchDetailProtocol

@synthesize _items , _ProductItem, _totalCount, _offset;


- (id) init {
	self = [super init];
    if (self) { 
		self._items = [NSMutableArray arrayWithCapacity:20];
		self._totalCount = -1 ;
	}
    return self; 
	
}


- (NSUInteger)count {
	return [self._items count];
}


- (id)objectAtIndex:(NSUInteger)index{
	return [self._items objectAtIndex:index];
}


- (void)addItemsByJSON:(NSString*)json {
    
	NSDictionary *jsonValue = [json JSONValue]; 
    
    NSArray *tempArray = [jsonValue objectForKey:@"ret"];
    //FIX ME
    if ( tempArray != nil && [tempArray count]>0) {
        NSString* ifSucess = [tempArray objectAtIndex:0];
        
        if ([ifSucess hasPrefix:@"FAIL::"] == YES) {
            return;
        }
    }

	if (jsonValue != nil) { 
		NSDictionary *auctions = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"auctionList"];
		for (NSDictionary *item in auctions) { 
			EtaoAuctionItem *auction = [EtaoAuctionItem alloc] ;
			[auction setFromDictionary:item];
			[self._items addObject:auction];
	
            NSLog(@"%@",auction.title);
            [auction release];
		}
    }
	
}


- (void) addProductDoByJSON:(NSString*)json {
    
    NSDictionary *jsonValue = [json JSONValue]; 
    
    NSArray *tempArray = [jsonValue objectForKey:@"ret"];
    
    
    //FIX ME
    if ( tempArray != nil && [tempArray count]>0) {
        NSString* ifSucess = [tempArray objectAtIndex:0];
       
        if ([ifSucess hasPrefix:@"FAIL::"] == YES) {

            return;
        }
    }
    
	
	_totalCount = [[[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"totalCount"] intValue];
    
    _offset = [[[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"offset"] intValue];
    
	if (jsonValue != nil) { 
        //productDO
        NSDictionary *productDictionary = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"productDO"];

        if(nil == _ProductItem ) {
            _ProductItem = [[EtaoProductItem alloc]init];
        }
        
        [_ProductItem setFromDictionary:productDictionary];
    }
    
    NSLog(@"%@",json);
}


- (void)setItemsByJSON:(NSString*)json {
    
    NSLog(@"%@",json);
    
	//[self._items removeAllObjects];
	[self addItemsByJSON:json];
    
    [self addProductDoByJSON:json];
}


- (void) dealloc {
    
    [_ProductItem release];
    [super dealloc];
}

@end
