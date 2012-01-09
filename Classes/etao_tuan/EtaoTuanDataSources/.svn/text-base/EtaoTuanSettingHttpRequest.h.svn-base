//
//  EtaoTuanSettingHttpRequest.h
//  etao4iphone
//
//  Created by  on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EtaoHttpRequest.h"

@interface EtaoTuanSettingHttpRequest : EtaoHttpRequest{
    
    NSMutableDictionary *_parameters;
    
    NSMutableArray* _items;
 
}

@property (nonatomic, retain)NSMutableArray* items;

-(void)addParam:(NSObject *)param forKey:(NSString *)key;
-(void)removeParam:(NSString *)key;
-(NSString *)_dictToString:(NSDictionary *)dict;
-(void)start;

-(NSUInteger)count;
-(void)addItemsByJSON:(NSString *)json;
-(id)objectAtIndex:(NSUInteger)index;
-(NSMutableArray *)mergeWebAndLocal:(NSArray*)webArray;
-(void)removeAllObjects;
-(void)clear;

@end
