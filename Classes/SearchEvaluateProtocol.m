//
//  SearchEvaluateProtocol.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchEvaluateProtocol.h"
#import "EtaoEvaluateItem.h"
#import "NSObject+SBJson.h"

@implementation SearchEvaluateProtocol

@synthesize _evaluateArray;
@synthesize _allEvaluateCount;


- (id) init {
	self = [super init];
    if (self) { 
        
        if(nil == _evaluateArray) {
            _evaluateArray = [[NSMutableArray alloc]init];
        }
	}
    return self; 
}


- (NSUInteger)count {
	return [_evaluateArray count];
}


- (id)objectAtIndex:(NSUInteger)index{
	return [_evaluateArray objectAtIndex:index];
}


- (void)addItemsByJSON:(NSString*)json {
	NSDictionary *jsonValue = [json JSONValue]; 
    
    NSLog(@"%@", json);
    
   if (jsonValue != nil) { 
       
       _allEvaluateCount = [[[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"totalCount"] intValue];
       
		NSDictionary *evaluates = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"comments"];
		for (NSDictionary *item in evaluates) { 
			EtaoEvaluateItem *evaluate = [EtaoEvaluateItem alloc] ;
			[evaluate setFromDictionary:item];
			[_evaluateArray addObject:evaluate];
            
            //NSLog(@"%@",auction.title);
            [evaluate release];
		}
    }
	
}


- (void)setItemsByJSON:(NSString*)json {
    
    NSLog(@"%@",json);
    
	//[self._items removeAllObjects];
	[self addItemsByJSON:json];
}


- (void) dealloc {
    
    [_evaluateArray release];
    [super dealloc];
}


@end
