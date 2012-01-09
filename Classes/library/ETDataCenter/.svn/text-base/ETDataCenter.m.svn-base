//
//  ETDataCenter.m
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ETDataCenter.h"
#import "EtaoGroupBuyAuctionDataSource.h"
#import "EtaoGroupBuySettingDataSource.h"

static ETDataCenter* shareDataCenter = nil; //全局静态变量

@implementation ETDataCenter

+ (ETDataCenter*) dataCenter{
    if(shareDataCenter ==nil){
        shareDataCenter = [[ETDataCenter alloc]init];
    }
    return shareDataCenter;
}

- (id)init{
    self = [super init];
    if(self){
        _dataTable = [[NSMutableDictionary alloc]initWithCapacity:10];
    }
    return  self;
}

#pragma mark -V Operation

- (id<ETDataCenterProtocal>) getDataSourceWithKey:(NSString*)key{
    id<ETDataCenterProtocal> datasource = [_dataTable objectForKey:key];
    return  datasource;
}

- (void) addDataSource:(id<ETDataCenterProtocal>)datasource 
               withKey:(NSString*)key{
    [_dataTable setObject:datasource forKey:key];
}

- (BOOL) isExist:(NSString *)key{
    return [_dataTable objectForKey:key]==nil ? NO:YES;
}

#pragma mark -V Serializing
/* 本地持久化 */
- (void)save{
#ifdef ETDATACENTER_DEBUG
    NSLog(@"ETDataCenter saving...");
#endif
    
    
    //保存每个数据源
    NSArray* key_list = [_dataTable allKeys];
    NSMutableArray* class_list = [[[NSMutableArray alloc]init]autorelease];
    for(NSString* key in key_list){
        id<ETDataCenterProtocal> datasource = [_dataTable objectForKey:key];
        [datasource serializing:key];
        [class_list addObject:[datasource className]];
    }
    //保存key列表
    NSData *key_arrayData = [NSKeyedArchiver archivedDataWithRootObject:key_list];
    [[NSUserDefaults standardUserDefaults]setObject:key_arrayData forKey:@"ETDataCenterKeys"];
    
    
    //保存class列表
    NSData *class_arrayData = [NSKeyedArchiver archivedDataWithRootObject:class_list];
    [[NSUserDefaults standardUserDefaults]setObject:class_arrayData forKey:@"ETDataCenterClasses"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)load{
#ifdef ETDATACENTER_DEBUG
    NSLog(@"ETDataCenter loading...");
#endif
    NSBundle* bundle = [NSBundle mainBundle];

    //获取所有的key列表
    NSData *key_arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ETDataCenterKeys"];
    NSMutableArray *key_list = [NSKeyedUnarchiver unarchiveObjectWithData:key_arrayData];
    
    //获取所有的class列表
    NSData *class_arrayData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ETDataCenterClasses"];
    NSMutableArray *class_list = [NSKeyedUnarchiver unarchiveObjectWithData:class_arrayData];
    
    //生成数据字典
    for(int i =0 ;i <key_list.count ;i++){
        NSString* key = [key_list objectAtIndex:i];
        NSString* className = [class_list objectAtIndex:i];
        Class class = [bundle classNamed:className];
        id<ETDataCenterProtocal> datasource = [[[class alloc]init]autorelease];
        [datasource deserializing:key];
        [_dataTable setObject:datasource forKey:key];
    }
}

@end
