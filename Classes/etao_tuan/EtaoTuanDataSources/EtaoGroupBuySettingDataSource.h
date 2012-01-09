//
//  EtaoGroupBuySettingDataSource.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETHttpRequest.h"
#import "ETDataCenter.h"
#import "EtaoHttpRequest.h"
#import "EtaoTuanSettingItem.h"
#import "SBJson.h"

#define GROUPBUY_DATASOURCE_KEY @"groupbuy_setting"

#ifndef GROUPBUY_SETTING_URL
#define GROUPBUY_SETTING_URL @"http://wap.etao.com/go/rgn/decider/tuangou.html"
#endif

typedef enum{
    ET_DS_GROUPBUY_SETTING_LOCAL = 0, //初始状态，本地数据
    ET_DS_GROUPBUY_SETTING_LOADING,   //数据加载中
    ET_DS_GROUPBUY_SETTING_OK,        //数据加载完成，可获取，非本地数据
    ET_DS_GROUPBUY_SETTING_FAIL,      //数据加载失败,网络原因
    ET_DS_GROUPBUY_SETTING_ERROR      //数据加载失败,数据原因
}ET_DS_GROUPBUY_SETTING_STATUS;


@interface EtaoGroupBuySettingDataSource : NSObject<ETDataCenterProtocal,EtaoHttpRequstDelegate>{
    //状态
    ET_DS_GROUPBUY_SETTING_STATUS _status;
 
    EtaoHttpRequest* _request;
    NSMutableArray* _items;
    NSMutableArray *_oriItems;
}

@property (nonatomic,retain)NSMutableArray* items;
@property (nonatomic,assign)ET_DS_GROUPBUY_SETTING_STATUS status;

- (void)reload;
- (NSMutableArray*)getSelectedItems; //获取选中的items

@end
