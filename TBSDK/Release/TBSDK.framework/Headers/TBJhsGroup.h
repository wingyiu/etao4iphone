//
//  TBJhsGroup.h
//  TBSDK
//
//  Created by Xu Jiwei on 11-1-19.
//  Copyright 2011 Taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TBModel.h"


//! 聚划算宝贝组
@interface TBJhsGroup : TBModel {
    NSUInteger              group_id;
    NSString                *group_name;
    NSString                *group_start_time;
    NSString                *group_end_time;
    NSInteger               platform_id;
    NSString                *ju_view;
    
    NSArray                 *item_list;
}

@property (nonatomic, assign)	NSUInteger              group_id;
@property (nonatomic, copy)     NSString                *group_name;
@property (nonatomic, copy)     NSString                *group_start_time;
@property (nonatomic, copy)     NSString                *group_end_time;
@property (nonatomic, assign)	NSInteger               platform_id;
@property (nonatomic, copy)     NSString                *ju_view;

@property (nonatomic, retain)     NSArray                 *item_list;

@end
