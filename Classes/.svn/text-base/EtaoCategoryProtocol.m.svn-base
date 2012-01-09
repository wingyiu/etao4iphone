//
//  EtaoCategoryProtocol.m
//  etao4iphone
//
//  Created by jianyi.zw on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoCategoryProtocol.h"
#import "EtaoCategoryItemTop.h"
#import "NSObject+SBJson.h"

@implementation EtaoCategoryProtocol

@synthesize categoryArray = _categoryArray;
@synthesize categoryCount;


- (id) init {
	self = [super init];
    if (self) { 
        
        if(nil == _categoryArray) {
            _categoryArray = [[NSMutableArray alloc]init];
        }
	}
    return self; 
}


- (NSUInteger)count {
	return [_categoryArray count];
}


- (id)objectAtIndex:(NSUInteger)index{
	return [_categoryArray objectAtIndex:index];
}


- (void)addItemsByJSON:(NSString*)json {
	NSDictionary *jsonValue = [json JSONValue]; 
    
    NSLog(@"%@", json);
    
    if (jsonValue != nil) { 
        
        categoryCount = [[[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"count"] intValue];
        
        NSDictionary *evaluates = [[[jsonValue objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"categoryListTop"];
		for (NSDictionary *item in evaluates) { 
			EtaoCategoryItemTop *evaluate = [EtaoCategoryItemTop alloc];
			//[evaluate setFromDictionary:item];
//            @synthesize name;
//            @synthesize info;
//            @synthesize count;
//            @synthesize isHide;
//            @synthesize categoryMidList;
            evaluate.count = [[item objectForKey:@"count"] intValue];
			evaluate.name = [item objectForKey:@"name"];
            evaluate.info = [item objectForKey:@"info"];
           
            evaluate.isHide = YES;
            
            if( evaluate.categoryMidList == nil ) {
                NSMutableArray* midArray = [[NSMutableArray alloc]init];
                evaluate.categoryMidList = midArray;
                [midArray release];
            }
            else{
                [evaluate.categoryMidList removeAllObjects];
            }
            NSDictionary *midlist = [item objectForKey:@"categoryListMid"];
            
            int midItemCount = 0;
            for (NSDictionary *miditem in midlist) { 
                
                midItemCount++;
               
                EtaoCategoryItemMid *midEvaluate = [EtaoCategoryItemMid alloc] ;
                //[evaluate setFromDictionary:item];
                //            @synthesize name;
                //            @synthesize info;
                //            @synthesize count;
                //            @synthesize isHide;
                //            @synthesize categoryMidList;
                midEvaluate.name = [miditem objectForKey:@"name"];
                midEvaluate.info = [miditem objectForKey:@"info"];
                midEvaluate.cat = [miditem objectForKey:@"cat"];
                midEvaluate.count = [[miditem objectForKey:@"count"] intValue];
                midEvaluate.isHide = YES;
                
                if( midEvaluate.categoryList == nil ) {
                    NSMutableArray* midArray = [[NSMutableArray alloc]init];
                    midEvaluate.categoryList = midArray;
                    [midArray release];
                }
                else {
                    [midEvaluate.categoryList removeAllObjects];
                }
                NSDictionary *bottomList = [miditem objectForKey:@"categoryList"];
                
                int itemInfoCount = 0;
                for (NSDictionary *bottomItem in bottomList) { 
                    
                    itemInfoCount++;
                    
                    EtaoCategoryItemInfo *bottomEvaluate = [EtaoCategoryItemInfo alloc] ;
                    //[evaluate setFromDictionary:item];
//                    @synthesize name;
//                    @synthesize cat;

                    bottomEvaluate.name = [bottomItem objectForKey:@"name"];
                    bottomEvaluate.cat = [bottomItem objectForKey:@"cat"];
                    
                    [midEvaluate.categoryList addObject:bottomEvaluate];
                    [bottomEvaluate release];
                } 
                
                if (midEvaluate.count != itemInfoCount) {
                    midEvaluate.count = itemInfoCount;
                    
                    NSLog(@"error EtaoCategoryItemInfo (midEvaluate.count != itemInfoCount)%@!",midEvaluate.name);
                }

                
                [evaluate.categoryMidList addObject:midEvaluate];
                [midEvaluate release];
            } 
            
            if (evaluate.count != midItemCount) {
                evaluate.count = midItemCount;
                
                NSLog(@"error EtaoCategoryItemMid (evaluate.count != tempCount)%@!",evaluate.name);
            }
            
            [_categoryArray addObject:evaluate];
            [evaluate release];
		}
    }
}


- (void)setItemsByJSON:(NSString*)json {
    
    NSLog(@"%@",json);
    
	[_categoryArray removeAllObjects];
	[self addItemsByJSON:json];
}


- (void) dealloc {
    
    
    [_categoryArray release];
    [super dealloc];
}


@end

