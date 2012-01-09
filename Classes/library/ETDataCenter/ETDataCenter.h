//
//  ETDataCenter.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETDataCenterProtocal.h"
#define ETDATACENTER_DEBUG

#define ET_NF_GROUPBUY_MAP2LIST_SELECTITEM @"ET_NF_GROUPBUY_MAP2LIST_SELECTITEM"
//list被选中时，通知map，被选中的item并展现
#define ET_NF_GROUPBUY_LIST2MAP_SELECTITEM @"ET_NF_GROUPBUY_LIST2MAP_SELECTITEM"

/*
 * 单例模式，datasource数据集合，全局变量
 * key-value模式，每个datasource有唯一的key
 * 如果key不存在，由调用方负责生成相关数据源
 * 统一保存数据源，加载数据源，保证任何地方都可以拿到最新最全的数据
 *
 */


@interface ETDataCenter : NSObject{
    NSMutableDictionary* _dataTable; //主表
}

+ (ETDataCenter*) dataCenter; //单例方法
- (id<ETDataCenterProtocal>) getDataSourceWithKey:(NSString*)key; //获取数据源
- (void) addDataSource:(id<ETDataCenterProtocal>)datasource 
               withKey:(NSString*)key; //添加数据源
- (BOOL) isExist:(NSString*)key; //判断是否存在数据源

- (void)load;//加载数据中心
- (void)save;//保存数据中心

@end
