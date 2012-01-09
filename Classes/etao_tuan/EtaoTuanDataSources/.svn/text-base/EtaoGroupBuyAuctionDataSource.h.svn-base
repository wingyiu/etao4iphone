//
//  EtaoGroupBuyAuctionDataSource.h
//  etao4iphone
//
//  Created by 左 昱昊 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "EtaoHttpRequest.h"
#import "ETDataCenter.h"
#import "ETHttpRequest.h"
#import "EtaoTuanAuctionItem.h"
#import "EtaoTuanSettingItem.h"

typedef enum{
    ET_DS_GROUPBUY_AUCTION_LOCAL = 0, //初始状态，本地数据
    ET_DS_GROUPBUY_AUCTION_LOADING,   //数据加载中
    ET_DS_GROUPBUY_AUCTION_OK,        //数据加载完成，可获取，非本地数据
    ET_DS_GROUPBUY_AUCTION_FAIL,      //数据加载失败,网络原因
    ET_DS_GROUPBUY_AUCTION_ERROR,     //数据加载失败,数据原因
    ET_DS_GROUPBUY_AUCTION_NOMORE     //没有更多宝贝
}ET_DS_GROUPBUY_AUCTION_STATUS;


@interface EtaoGroupBuyAuctionDataSource : NSObject <ETDataCenterProtocal,EtaoHttpRequstDelegate>{
    //状态
    ET_DS_GROUPBUY_AUCTION_STATUS _status;

    //裸数据
    NSString* _tag;
    NSMutableArray* _items;
    
    //网络访问相关
    int curPage;
    int pageNum;
    NSMutableDictionary* _query;
    NSString* _returnCount;
    EtaoHttpRequest* _request;
    EtaoTuanSettingItem* _settingItem;
}
@property (nonatomic,retain)NSString* tag;
@property (nonatomic,retain)NSString* returnCount;
@property (nonatomic,retain)NSMutableArray* items;
@property (nonatomic,retain)NSMutableDictionary* query;
@property (nonatomic,retain)EtaoTuanSettingItem* settingItem;
@property (nonatomic,assign)ET_DS_GROUPBUY_AUCTION_STATUS status;


//APIs
- (void)reload;
- (void)loadmore;
- (id)initWithSettingItem:(EtaoTuanSettingItem*)settingItem;

//Logic
- (BOOL)jsonParser:(NSData *)data;

@end
