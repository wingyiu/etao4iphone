//
//  EtaoHttpRequest.h
//  etao_price_setting
//
//  Created by 无线一淘客户端测试机 on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtaoHttpRequest.h"
#import "SBJson.h"
#import "EtaoPriceSettingModuleCell.h"

@interface EtaoPriceSettingHttpRequest : EtaoHttpRequest {
    
    NSMutableDictionary *_parameters;
    
    NSMutableArray* _items;
    
    NSString *_urlprefix;
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
