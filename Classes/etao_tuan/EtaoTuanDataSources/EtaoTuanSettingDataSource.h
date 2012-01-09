//
//  EtaoTuanSettingDataSource.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EtaoHttpRequest.h"
#import "SBJson.h"
#import "EtaoTuanSettingItem.h"

#ifndef SETTING_URL
#define SETTING_URL @"http://wap.etao.com/go/rgn/decider/tuangou.html"
#endif

@interface EtaoTuanSettingDataSource : NSObject <EtaoHttpRequstDelegate>{
    EtaoHttpRequest* _request;
    NSMutableArray* _items;
}

@property(nonatomic,retain) NSMutableArray* items;

-(void)addItemsByJSON:(NSString *)json;
-(NSMutableArray *)mergeWebAndLocal:(NSArray *)webArray;

- (void)save;
- (void)load;
- (NSMutableArray*)getSelectedItems; //获取选中的items

@end
