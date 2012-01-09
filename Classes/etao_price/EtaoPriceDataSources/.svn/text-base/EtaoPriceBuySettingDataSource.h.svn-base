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
#import "EtaoPriceSettingItem.h"
#import "SBJson.h"

#ifndef PRICEBUY_SETTING_URL
#define PRICEBUY_SETTING_URL @"http://wap.etao.com/go/rgn/decider/ssjj.html"
#endif

typedef enum{
    ET_DS_PRICEBUY_SETTING_LOCAL = 0, //初始状态，本地数据
    ET_DS_PRICEBUY_SETTING_LOADING,   //数据加载中
    ET_DS_PRICEBUY_SETTING_OK,        //数据加载完成，可获取，非本地数据
    ET_DS_PRICEBUY_SETTING_FAIL,      //数据加载失败,网络原因
    ET_DS_PRICEBUY_SETTING_ERROR      //数据加载失败,数据原因
}ET_DS_PRICEBUY_SETTING_STATUS;


@interface EtaoPriceBuySettingDataSource : NSObject<ETDataCenterProtocal,EtaoHttpRequstDelegate>{
    //状态
    ET_DS_PRICEBUY_SETTING_STATUS _status;
    
    EtaoHttpRequest* _request;
    NSMutableArray* _items;
    NSString* _mode;
    NSMutableArray *_oriItems;
}

@property (nonatomic,retain)NSMutableArray* items;
@property (nonatomic,retain)NSString* mode;
@property (nonatomic,assign)ET_DS_PRICEBUY_SETTING_STATUS status;

- (void)reload;
- (NSMutableArray*)getSelectedItems; //获取选中的items

@end
